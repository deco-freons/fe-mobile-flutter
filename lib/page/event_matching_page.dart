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
import 'package:flutter_boilerplate/event/components/event_matching/event_matching_card.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_repository.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

const int snackbarDuration = 1000;
const int rightSwipeDelay = 2000;
const int leftSwipeDelay = 700;

class EventMatching extends StatefulWidget {
  const EventMatching({Key? key}) : super(key: key);
  static const routeName = '/event-matching';

  @override
  State<EventMatching> createState() => _EventMatchingState();
}

class _EventMatchingState extends State<EventMatching> {
  final SwipeableCardSectionController _cardController =
      SwipeableCardSectionController();
  List<DistanceFilter> radiusOptions = DistanceFilter.values;
  DistanceFilter radiusValue = DistanceFilter.ten;
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventMatchingCubit>(
          create: (BuildContext context) =>
              EventMatchingCubit(EventMatchingRepositoryImpl())
                ..getEvents(DistanceFilter.ten),
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
          hasBackButton: true,
          widget: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: CustomPadding.body, horizontal: CustomPadding.sm),
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
                            .getEvents(radiusValue);
                      },
                    )),
              ),
            );
          }),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: CustomPadding.sm),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 72 / 100),
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
                            duration:
                                const Duration(milliseconds: snackbarDuration),
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
                            duration:
                                const Duration(milliseconds: snackbarDuration),
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
                        List<EventMatchingCard> cards = state.events
                            .map((event) => EventMatchingCard(event: event))
                            .toList();
                        return Column(
                          children: [
                            SwipeableCardsSection(
                              context: context,
                              cardController: _cardController,
                              items: cards.sublist(0, 3),
                              cardHeightBottomMul: 0.8,
                              cardHeightMiddleMul: 0.8,
                              cardHeightTopMul: 0.8,
                              cardWidthBottomMul: 0.9,
                              cardWidthMiddleMul: 0.9,
                              cardWidthTopMul: 0.9,
                              enableSwipeDown: false,
                              enableSwipeUp: false,
                              onCardSwiped: (dir, index, widget) {
                                if (dir == Direction.right) {
                                  if (index < cards.length) {
                                    context
                                        .read<EventMatchingJoinCubit>()
                                        .joinEvent(cards[index].event.eventID);
                                    Future.delayed(
                                        const Duration(
                                            milliseconds: rightSwipeDelay), () {
                                      isDisabled = false;
                                    });
                                  }
                                } else {
                                  Future.delayed(
                                      const Duration(
                                          milliseconds: leftSwipeDelay), () {
                                    isDisabled = false;
                                  });
                                }
                                if (index + 3 < cards.length) {
                                  _cardController.addItem(cards[index + 3]);
                                } else if (index + 3 == cards.length) {
                                  _cardController.addItem(EventMatchingCard(
                                    event: state.events.last,
                                    isEventEmpty: true,
                                  ));
                                }
                                if (index + 3 > cards.length + 1) {
                                  _cardController.enableSwipe(false);
                                  Future.delayed(
                                      Duration(
                                          milliseconds: dir == Direction.left
                                              ? leftSwipeDelay + 1
                                              : rightSwipeDelay + 1), () {
                                    isDisabled = true;
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      }
                      return BuildLoading.buildRectangularLoading(
                          width: 342, height: 600, borderRadius: 20);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (!isDisabled) {
                        isDisabled = true;
                        _cardController.triggerSwipeLeft();
                      }
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
                      if (!isDisabled) {
                        isDisabled = true;
                        _cardController.triggerSwipeRight();
                      }
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}
