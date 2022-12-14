import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_dropdown_button.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/date_parser.dart';
import 'package:flutter_boilerplate/common/utils/typedef.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_home_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_home_state.dart';
import 'package:flutter_boilerplate/event/bloc/event_reminder/event_reminder_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_reminder/event_reminder_state.dart';
import 'package:flutter_boilerplate/event/bloc/popular_event/popular_events_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/popular_event/popular_events_state.dart';
import 'package:flutter_boilerplate/event/components/common/event_list.dart';
import 'package:flutter_boilerplate/event/components/event_matching/event_matching_home_card.dart';
import 'package:flutter_boilerplate/event/components/common/home_content.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/events_by_user/event_by_user_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_home_repository.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:flutter_boilerplate/event/data/popular_event/popular_events_repository.dart';
import 'package:flutter_boilerplate/common/data/item_filter_model.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/notification/notification_service.dart';
import 'package:flutter_boilerplate/page/event/event_matching.dart';
import 'package:flutter_boilerplate/page/event/event_reminder.dart';
import 'package:flutter_boilerplate/page/user/profile.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:flutter_boilerplate/user/bloc/common/user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/common/user_state.dart';
import 'package:flutter_boilerplate/user/data/common/user_repository.dart';

class Homepage extends StatefulWidget {
  final HandlePageCallBack handlePageChanged;

  const Homepage({Key? key, required this.handlePageChanged}) : super(key: key);
  static const routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin<Homepage> {
  bool keepAlive = true;
  DistanceFilter radiusValue = DistanceFilter.ten;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) =>
              UserCubit(UserRepositoryImpl())..getUser(),
        ),
        BlocProvider(
          create: (context) => PopularEventsCubit(PopularEventsRepositoryImpl())
            ..getPopularEvents([], radiusValue),
        ),
        BlocProvider(
          create: (context) =>
              EventMatchingHomeCubit(EventMatchingHomeRepositoryImpl())
                ..getEventMatchingHome(radiusValue),
        ),
        BlocProvider<EventsReminderCubit>(
          create: (context) =>
              EventsReminderCubit(getIt.get<EventsJoinedRepository>())
                ..getEventsReminder(0, []),
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: SafeArea(
            child: BuildHome(
              handlePageChanged: widget.handlePageChanged,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}

class BuildHome extends StatefulWidget {
  final String errorMessage;
  final HandlePageCallBack handlePageChanged;

  const BuildHome(
      {Key? key, this.errorMessage = '', required this.handlePageChanged})
      : super(key: key);

  @override
  State<BuildHome> createState() => _BuildHomeState();
}

class _BuildHomeState extends State<BuildHome> {
  bool allCheck = true;
  List<ItemFilterModel<PrefType>> prefs = PrefType.values
      .map((pref) => ItemFilterModel(data: pref, isPicked: true))
      .toList();
  DistanceFilter radiusValue = DistanceFilter.ten;
  List<DistanceFilter> radiusOptions = DistanceFilter.values;

  final NotificationService _notificationService =
      getIt.get<NotificationService>();

  Future<void> scheduleNotification(int id) async {
    await _notificationService.scheduleNotification(
      id: 1,
      title: "Event Nearby Found!",
      body: "We found an event near your location. Click to see more.",
      milisecondFromNow:
          DateTime.now().add(const Duration(seconds: 5)).millisecondsSinceEpoch,
      payload: id.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = context.read<UserCubit>();

    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserCubit>().getUser();
        context.read<PopularEventsCubit>().getPopularEvents([], radiusValue);
        context
            .read<EventMatchingHomeCubit>()
            .getEventMatchingHome(radiusValue);
        context.read<EventsReminderCubit>().getEventsReminder(0, []);
      },
      child: ListView(
        children: [
          SizedBox(
            height: appBarHeight,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: CustomPadding.body, right: CustomPadding.body),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(context, Profile.routeName);
                      userCubit.getUser();
                    },
                    child: BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        String? imageUrl;
                        if (state is UserSuccessState) {
                          imageUrl = state.user.userImage?.imageUrl;
                        }
                        return NetworkImageAvatar(
                            imageUrl: imageUrl, radius: 23);
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(EventReminder.routeName);
                    },
                    child:
                        BlocBuilder<EventsReminderCubit, EventsReminderState>(
                      builder: (context, state) {
                        int notificationsCount = 0;
                        if (state is EventsReminderSuccessState) {
                          notificationsCount = state.events.length;
                        }
                        if (notificationsCount > 0) {
                          return Stack(children: [
                            const Icon(
                              Icons.notifications_outlined,
                              size: 45.0,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: CustomPadding.xs),
                                decoration: BoxDecoration(
                                    color: error,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  notificationsCount.toString(),
                                  style: TextStyle(color: neutral.shade100),
                                ),
                              ),
                            )
                          ]);
                        } else {
                          return const Icon(
                            Icons.notifications_outlined,
                            size: 45.0,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          HomeContent(
              title: "Let's Match!",
              subTitle: "Events that might spark your interest.",
              isPair: true,
              isCentered: true,
              secondWidget: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: neutral.shade500)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CustomDropdownButton(
                      options: radiusOptions,
                      texts: radiusValue.descList,
                      initialValue: radiusValue,
                      callback: (newValue) {
                        radiusValue = newValue;
                        getPopularEvents(context, [], radiusValue);
                        getEventMatchingHome(context, radiusValue);
                      },
                    )),
              ),
              contentWidgets: [
                BlocBuilder<EventMatchingHomeCubit, EventMatchingHomeState>(
                    builder: (context, state) {
                  if (state is EventMatchingHomeErrorState) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is EventMatchingHomeSuccessState) {
                    if (state.events.isEmpty) {
                      return EventMatchingCardHome.empty(
                        isEventEmpty: true,
                        onTapHandler: () {},
                      );
                    } else {
                      List<String> splittedDate =
                          DateParser.parseEventDate(state.events[0].date);
                      return Center(
                        child: EventMatchingCardHome(
                            title: state.events[0].eventName,
                            author: state.events[0].eventCreator.username,
                            distance: state.events[0].distance,
                            location:
                                '${state.events[0].locationName}, ${state.events[0].location.city}',
                            month: splittedDate[0].substring(0, 3),
                            date: splittedDate[1].substring(0, 2),
                            image: state.events[0].eventImage?.imageUrl,
                            fee: state.events[0].eventPrice.fee,
                            onTapHandler: () {
                              Navigator.of(context)
                                  .pushNamed(EventMatching.routeName);
                            }),
                      );
                    }
                  } else {
                    return EventMatchingCardHome.empty(
                      loading: true,
                      onTapHandler: () {},
                    );
                  }
                }),
              ]),
          const SizedBox(
            height: 32,
          ),
          HomeContent(title: 'Categories', contentWidgets: [
            PreferenceButton(
              type: PrefType.GM,
              isAll: true,
              elevation: 4.0,
              onPressedHandler: () {
                if (allCheck) return;
                setState(() {
                  allCheck = true;
                  prefs = prefs
                      .map((pref) => pref.copyWith(isPicked: true))
                      .toList();
                  getPopularEvents(context, [], radiusValue);
                });
              },
              isActive: allCheck,
            ),
            for (PrefType pref in PrefType.values)
              PreferenceButton(
                type: pref,
                elevation: 4.0,
                onPressedHandler: () {
                  List<ItemFilterModel<PrefType>> isOnePrefPicked =
                      prefs.where((currPref) => currPref.isPicked).toList();

                  if (isOnePrefPicked.length == 1) {
                    if (isOnePrefPicked.first.data == pref) return;
                  }
                  setState(() {
                    prefs = prefs
                        .map((currPref) => currPref.data == pref
                            ? currPref.copyWith(
                                isPicked: allCheck ? null : !currPref.isPicked)
                            : currPref.copyWith(
                                isPicked: allCheck ? false : null))
                        .toList();
                    allCheck = false;
                    getPopularEvents(
                        context,
                        prefs
                            .where((currPref) => currPref.isPicked)
                            .map((currPref) => currPref.data.name)
                            .toList(),
                        radiusValue);
                  });
                },
                isActive: allCheck
                    ? false
                    : prefs
                        .firstWhere((currPref) => currPref.data == pref)
                        .isPicked,
              )
          ]),
          const SizedBox(
            height: 22,
          ),
          BlocConsumer<PopularEventsCubit, PopularEventsState>(
              listener: (context, state) async {
            if (state is PopularEventsSuccessState) {
              List<EventModel> events = state.events;
              events.sort(((a, b) => a.distance.compareTo(b.distance)));
              if (events.isNotEmpty) {
                await scheduleNotification(events[0].eventID);
              }
            }
          }, builder: (context, state) {
            if (state is PopularEventsErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            bool isSuccessState = state is PopularEventsSuccessState;
            return Padding(
              padding: const EdgeInsets.only(bottom: CustomPadding.xxxl),
              child: EventList(
                title: "Popular events",
                isLoading: !isSuccessState,
                events: state is PopularEventsSuccessState
                    ? state.events
                        .map((event) => EventByUserModel(
                            eventID: event.eventID,
                            eventName: event.eventName,
                            distance: event.distance,
                            date: event.date,
                            latitude: event.latitude,
                            longitude: event.longitude,
                            eventImage: event.eventImage,
                            eventPrice: event.eventPrice))
                        .toList()
                    : [],
                onPressed: () {
                  widget.handlePageChanged(1);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  void getPopularEvents(
      BuildContext context, List<String> data, DistanceFilter radius) {
    final cubit = context.read<PopularEventsCubit>();
    cubit.getPopularEvents(data, radius);
  }

  void getEventMatchingHome(BuildContext context, DistanceFilter radius) {
    final cubit = context.read<EventMatchingHomeCubit>();
    cubit.getEventMatchingHome(radius);
  }
}
