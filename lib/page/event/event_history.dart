import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/date_parser.dart';
import 'package:flutter_boilerplate/event/bloc/events_history/events_history_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/events_history/events_history_state.dart';
import 'package:flutter_boilerplate/event/components/common/event_joined_card.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';

class EventHistory extends StatefulWidget {
  const EventHistory({Key? key}) : super(key: key);
  static const routeName = "/history";

  @override
  State<EventHistory> createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory>
    with AutomaticKeepAliveClientMixin<EventHistory> {
  bool keepAlive = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<EventsHistoryCubit>(
      create: (context) =>
          EventsHistoryCubit(getIt.get<EventsJoinedRepository>())
            ..getEventsHistory(0),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: neutral.shade100,
          appBar: const PageAppBar(
            title: "History",
            subTitle:
                "Congratulations! These are the list of events you have attended.",
          ),
          body: const BuildEventHistory()),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}

class BuildEventHistory extends StatefulWidget {
  const BuildEventHistory({Key? key}) : super(key: key);

  @override
  State<BuildEventHistory> createState() => _BuildEventHistoryState();
}

class _BuildEventHistoryState extends State<BuildEventHistory> {
  final ScrollController _scrollController = ScrollController();
  int page = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        EventsHistoryCubit eventsHistoryCubit =
            context.read<EventsHistoryCubit>();
        EventsHistoryState state = eventsHistoryCubit.state;
        if (state is EventsHistorySuccessState) {
          if (state.hasMore) {
            page = page + 1;

            eventsHistoryCubit.getEventsHistory(page);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        page = 0;
        await context.read<EventsHistoryCubit>().getEventsHistory(page);
      },
      child: ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          BlocConsumer<EventsHistoryCubit, EventsHistoryState>(
            listener: (context, state) {
              if (state is EventsHistoryFetchMoreErrorState) {
                showSnackbar(state.errorMessage);
              }
              if (state is EventsHistoryErrorState) {
                page = 0;
                showSnackbar(state.errorMessage);
              }
            },
            buildWhen: (previous, current) {
              return current is! EventsHistoryFetchMoreLoadingState;
            },
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomPadding.body,
                    vertical: CustomPadding.base),
                itemCount: getItemCount(state),
                itemBuilder: (context, index) {
                  if (state is EventsHistorySuccessState) {
                    return buildCard(context, state.events[index]);
                  }

                  if (state is EventsHistoryFetchMoreErrorState) {
                    return buildCard(context, state.events[index]);
                  }

                  if (state is EventsHistoryLoadingState) {
                    return const EventJoinedCard.loading();
                  }

                  return const SizedBox.shrink();
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: CustomPadding.xxl,
                ),
              );
            },
          ),
          BlocBuilder<EventsHistoryCubit, EventsHistoryState>(
            builder: (context, state) {
              return state is EventsHistoryFetchMoreLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }

  showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget buildCard(BuildContext context, EventJoinedModel event) {
    List<String> splittedDate = DateParser.parseEventDate(event.date);
    return EventJoinedCard(
      eventID: event.eventID,
      title: event.eventName,
      author: event.eventCreator.username,
      month: splittedDate[0].substring(0, 3),
      date: splittedDate[1].substring(0, 2),
      distance: event.distance,
      location: '${event.locationName}, ${event.location.city}',
      type: EventJoinedCardType.HISTORY,
      participants: event.participantsList,
      isEventCreator: event.isEventCreator,
      fee: event.eventPrice.fee,
    );
  }

  int getItemCount(EventsHistoryState state) =>
      state is EventsHistorySuccessState
          ? state.events.length
          : state is EventsHistoryFetchMoreErrorState
              ? state.events.length
              : state is EventsHistoryLoadingState
                  ? 4
                  : 0;
}
