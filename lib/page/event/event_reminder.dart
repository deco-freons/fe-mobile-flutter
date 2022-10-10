import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/event_reminder/event_reminder_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_reminder/event_reminder_state.dart';
import 'package:flutter_boilerplate/event/components/common/event_joined_card.dart';
import 'package:flutter_boilerplate/event/components/common/no_events_card.dart';
import 'package:flutter_boilerplate/event/components/event_reminder/event_reminder_card.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/page/event/event_detail.dart';

class EventReminder extends StatefulWidget {
  const EventReminder({Key? key}) : super(key: key);
  static const routeName = "/event-reminder";

  @override
  State<EventReminder> createState() => _EventReminderState();
}

class _EventReminderState extends State<EventReminder> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventsReminderCubit>(
      create: (context) =>
          EventsReminderCubit(getIt.get<EventsJoinedRepository>())
            ..getEventsReminder(0, []),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: neutral.shade100,
          appBar:
              const PageAppBar(title: "Notification", hasLeadingWidget: true),
          body: const BuildEventReminder()),
    );
  }
}

class BuildEventReminder extends StatefulWidget {
  const BuildEventReminder({Key? key}) : super(key: key);

  @override
  State<BuildEventReminder> createState() => _BuildEventReminderState();
}

class _BuildEventReminderState extends State<BuildEventReminder> {
  final ScrollController _scrollController = ScrollController();
  List<EventJoinedModel> events = [];
  int page = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        EventsReminderCubit eventsReminderCubit =
            context.read<EventsReminderCubit>();
        EventsReminderState state = eventsReminderCubit.state;
        if (state is EventsReminderSuccessState) {
          if (state.hasMore) {
            page = page + 1;

            eventsReminderCubit.getEventsReminder(page, events);
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
        await context.read<EventsReminderCubit>().getEventsReminder(page, []);
      },
      child: ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          BlocConsumer<EventsReminderCubit, EventsReminderState>(
            listener: (context, state) {
              if (state is EventsReminderFetchMoreErrorState) {
                showSnackbar(state.errorMessage);
              }
              if (state is EventsReminderErrorState) {
                page = 0;
                showSnackbar(state.errorMessage);
              }
              if (state is EventsReminderSuccessState) {
                events = state.events;
              }
            },
            buildWhen: (previous, current) {
              return current is! EventsReminderFetchMoreLoadingState;
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
                  if (state is EventsReminderSuccessState) {
                    if (events.isEmpty) {
                      buildEmptyCard();
                    } else {
                      return buildCard(
                          context, events[index], index, state.hasMore);
                    }
                  }

                  if (state is EventsReminderFetchMoreErrorState) {
                    if (events.isEmpty) {
                      buildEmptyCard();
                    } else {
                      return buildCard(context, events[index], index, false);
                    }
                  }

                  if (state is EventsReminderLoadingState) {
                    return const EventJoinedCard.loading();
                  }

                  return const FittedBox(
                    child: Padding(
                      padding: EdgeInsets.only(top: CustomPadding.base),
                      child: NoEventsCard(),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: CustomPadding.xxl,
                ),
              );
            },
          ),
          BlocBuilder<EventsReminderCubit, EventsReminderState>(
            builder: (context, state) {
              return state is EventsReminderFetchMoreLoadingState
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

  Widget buildCard(
      BuildContext context, EventJoinedModel event, int index, bool hasMore) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetail.routeName,
            arguments: event.eventID);
      },
      child: EventReminderCard(
        eventName: event.eventName,
        imageUrl: event.eventImage?.imageUrl,
        handleDismissClick: () async {
          setState(() {
            events.removeAt(index);
          });
          if (events.length < 5 && hasMore) {
            page = page + 1;
            await context
                .read<EventsReminderCubit>()
                .getEventsReminder(page, events);
          }
        },
      ),
    );
  }

  Widget buildEmptyCard() {
    return const FittedBox(
      child: Padding(
        padding: EdgeInsets.only(top: CustomPadding.base),
        child: NoEventsCard(),
      ),
    );
  }

  int getItemCount(EventsReminderState state) {
    return state is EventsReminderSuccessState
        ? events.isEmpty
            ? 1
            : state.events.length
        : state is EventsReminderFetchMoreErrorState
            ? state.events.length
            : state is EventsReminderLoadingState
                ? 4
                : 1;
  }
}
