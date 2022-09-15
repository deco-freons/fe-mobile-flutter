import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_dropdown_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/typedef.dart';
import 'package:flutter_boilerplate/event/bloc/popular_event/popular_events_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/popular_event/popular_events_state.dart';
import 'package:flutter_boilerplate/event/components/event_list.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/event/data/event_by_user_model.dart';
import 'package:flutter_boilerplate/event/data/popular_event/popular_events_repository.dart';
import 'package:flutter_boilerplate/event/data/search_event/models/item_filter_model.dart';
import 'package:flutter_boilerplate/page/profile.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

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
    return BlocProvider(
      create: (context) => PopularEventsCubit(PopularEventsRepositoryImpl())
        ..getPopularEvents([], radiusValue),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: SafeArea(
              child: BuildHome(
            handlePageChanged: widget.handlePageChanged,
          )),
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

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                  onTap: () {
                    Navigator.pushNamed(context, Profile.routeName);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    child: Image.asset(
                        'lib/common/assets/images/CircleAvatarDefault.png'),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 45.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        HomeContent(
            title: 'Featured',
            isPair: true,
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
                    },
                  )),
            ),
            contentWidgets: [
              Padding(
                padding: const EdgeInsets.only(
                    left: CustomPadding.body, right: CustomPadding.body),
                child: SizedBox(
                  width: 350,
                  height: 343.0,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: neutral.shade400)),
                ),
              ),
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
                prefs =
                    prefs.map((pref) => pref.copyWith(isPicked: true)).toList();
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
        BlocBuilder<PopularEventsCubit, PopularEventsState>(
            builder: (context, state) {
          if (state is PopularEventsErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          bool isSuccessState = state is PopularEventsSuccessState;
          return Padding(
            padding: const EdgeInsets.only(bottom: CustomPadding.md),
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
                          longitude: event.longitude))
                      .toList()
                  : [],
              onPressed: () {
                widget.handlePageChanged(1);
              },
            ),
          );
        }),
      ],
    );
  }

  void getPopularEvents(
      BuildContext context, List<String> data, DistanceFilter radius) {
    final cubit = context.read<PopularEventsCubit>();
    cubit.getPopularEvents(data, radius);
  }
}
