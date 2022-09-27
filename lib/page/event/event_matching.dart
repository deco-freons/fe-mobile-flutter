import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_dropdown_button.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_join_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_join_state.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_state.dart';
import 'package:flutter_boilerplate/event/components/event_matching/card_provider.dart';
import 'package:flutter_boilerplate/event/components/event_matching/swipe_cards.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_repository.dart';
import 'package:provider/provider.dart';

const int snackbarDuration = 1000;

class EventMatching extends StatefulWidget {
  const EventMatching({Key? key}) : super(key: key);
  static const routeName = '/event-matching';

  @override
  State<EventMatching> createState() => _EventMatchingState();
}

class _EventMatchingState extends State<EventMatching> {
  List<DistanceFilter> radiusOptions = DistanceFilter.values;
  DistanceFilter radiusValue = DistanceFilter.ten;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventMatchingCubit>(
          create: (BuildContext context) =>
              EventMatchingCubit(EventMatchingRepositoryImpl())
                ..getEvents(radiusValue, true),
        ),
        BlocProvider<EventMatchingJoinCubit>(
          create: (BuildContext context) =>
              EventMatchingJoinCubit(EventMatchingRepositoryImpl()),
        ),
      ],
      child: Scaffold(
        backgroundColor: neutral.shade100,
        resizeToAvoidBottomInset: true,
        appBar: PageAppBar(
          title: "Featured",
          hasLeadingWidget: true,
          widget: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: CustomPadding.base, horizontal: CustomPadding.sm),
              child: DecoratedBox(
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
                        context
                            .read<EventMatchingCubit>()
                            .getEvents(radiusValue, true);
                      },
                    )),
              ),
            );
          }),
        ),
        body: SafeArea(
          child: ChangeNotifierProvider(
            create: (context) =>
                CardProvider(context.read<EventMatchingJoinCubit>()),
            child: Padding(
              padding: const EdgeInsets.only(top: CustomPadding.xxl),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 70 / 100),
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<EventMatchingCubit, EventMatchingState>(
                          listener: (context, state) {
                        if (state is EventMatchingErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                            ),
                          );
                        }
                      }),
                      BlocListener<EventMatchingJoinCubit,
                          EventMatchingJoinState>(listener: (context, state) {
                        if (state is EventMatchingJoinErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(
                                  milliseconds: snackbarDuration),
                              backgroundColor: error,
                              content: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: CustomPadding.xl),
                                child: Text(
                                  state.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: CustomFontSize.lg,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (state is EventMatchingJoinSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(
                                  milliseconds: snackbarDuration),
                              content: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: CustomPadding.xl),
                                child: const Text(
                                  "Successfully joined event",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: CustomFontSize.lg,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                    child: BlocBuilder<EventMatchingCubit, EventMatchingState>(
                      builder: (context, state) {
                        if (state is EventMatchingSuccessState) {
                          CardProvider provider =
                              Provider.of<CardProvider>(context);
                          provider.addEvents(state.events);
                          if (provider.events.isEmpty && state.hasMore) {
                            context
                                .read<EventMatchingCubit>()
                                .getEvents(radiusValue, false);
                          }
                          return Builder(
                              builder: (context) => buildCards(context));
                        }
                        return BuildLoading.buildRectangularLoading(
                            width: 342, height: 500, borderRadius: 20);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Builder(builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          final provider =
                              Provider.of<CardProvider>(context, listen: false);
                          provider.skip();
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: error,
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.close_rounded,
                            color: neutral.shade100,
                            size: 50,
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          final provider =
                              Provider.of<CardProvider>(context, listen: false);
                          EventMatchingJoinCubit cubit =
                              context.read<EventMatchingJoinCubit>();
                          provider.join(cubit);
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(100)),
                          child: ImageIcon(
                            const AssetImage(
                                'lib/common/assets/images/HeartIcon.png'),
                            color: neutral.shade100,
                          ),
                        ),
                      ),
                    ],
                  );
                })
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCards(BuildContext context) {
    final provider = Provider.of<CardProvider>(context);
    final events = provider.events;
    return events.isEmpty
        ? const SwipeCards.empty()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: CustomPadding.md),
            child: Stack(
              children: events
                  .map((event) => SwipeCards(
                      eventID: event.eventID,
                      eventName: event.eventName,
                      participants: event.participants,
                      date: event.date,
                      suburb: event.location.suburb,
                      city: event.location.city,
                      locationName: event.locationName,
                      distance: event.distance,
                      startTime: event.startTime,
                      endTime: event.endTime,
                      shortDescription: event.shortDescription,
                      image: event.eventImage?.imageUrl,
                      isFront: events.last == event))
                  .toList(),
            ),
          );
  }
}
