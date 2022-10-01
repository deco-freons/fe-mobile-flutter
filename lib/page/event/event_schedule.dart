import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/date_parser.dart';
import 'package:flutter_boilerplate/event/bloc/events_schedule/events_schedue_state.dart';
import 'package:flutter_boilerplate/event/bloc/events_schedule/events_schedule_cubit.dart';
import 'package:flutter_boilerplate/event/components/common/event_joined_card.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';

class EventSchedule extends StatefulWidget {
  const EventSchedule({Key? key}) : super(key: key);
  static const routeName = "/event-schedule";
  @override
  State<EventSchedule> createState() => _EventScheduleState();
}

class _EventScheduleState extends State<EventSchedule>
    with AutomaticKeepAliveClientMixin<EventSchedule> {
  bool keepAlive = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<EventsScheduleCubit>(
      create: (context) =>
          EventsScheduleCubit(getIt.get<EventsJoinedRepository>())
            ..getEventsSchedule(0),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: neutral.shade100,
          appBar: const PageAppBar(title: "Scheduled Events"),
          body: const BuildEventSchedule()),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}

class BuildEventSchedule extends StatefulWidget {
  const BuildEventSchedule({Key? key}) : super(key: key);

  @override
  State<BuildEventSchedule> createState() => _BuildEventScheduleState();
}

class _BuildEventScheduleState extends State<BuildEventSchedule> {
  final ScrollController _scrollController = ScrollController();
  int page = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        EventsScheduleCubit eventsScheduleCubit =
            context.read<EventsScheduleCubit>();
        EventsScheduleState state = eventsScheduleCubit.state;
        if (state is EventsScheduleSuccessState) {
          if (state.hasMore) {
            page = page + 1;

            eventsScheduleCubit.getEventsSchedule(page);
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
        await context.read<EventsScheduleCubit>().getEventsSchedule(page);
      },
      child: ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          BlocConsumer<EventsScheduleCubit, EventsScheduleState>(
            listener: (context, state) {
              if (state is EventsScheduleFetchMoreErrorState) {
                showSnackbar(state.errorMessage);
              }
              if (state is EventsScheduleErrorState) {
                page = 0;
                showSnackbar(state.errorMessage);
              }
            },
            buildWhen: (previous, current) {
              return current is! EventsScheduleFetchMoreLoadingState;
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
                  if (state is EventsScheduleSuccessState) {
                    return buildCard(context, state.events[index]);
                  }

                  if (state is EventsScheduleFetchMoreErrorState) {
                    return buildCard(context, state.events[index]);
                  }

                  if (state is EventsScheduleLoadingState) {
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
          BlocBuilder<EventsScheduleCubit, EventsScheduleState>(
            builder: (context, state) {
              return state is EventsScheduleFetchMoreLoadingState
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
      type: EventJoinedCardType.SCHEDULED,
      participants: event.participantsList,
      onCancelClick: (eventID) {},
    );
  }

  int getItemCount(EventsScheduleState state) =>
      state is EventsScheduleSuccessState
          ? state.events.length
          : state is EventsScheduleFetchMoreErrorState
              ? state.events.length
              : state is EventsScheduleLoadingState
                  ? 4
                  : 0;
}
