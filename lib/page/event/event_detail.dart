import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/circle_icon_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_container.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail/event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail/event_detail_state.dart';
import 'package:flutter_boilerplate/event/bloc/update_event/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/components/common/event_info.dart';
import 'package:flutter_boilerplate/event/components/event_detail/event_detail_categories.dart';
import 'package:flutter_boilerplate/event/components/event_detail/event_detail_modal.dart';
import 'package:flutter_boilerplate/event/components/event_detail/event_detail_participants.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_place_model.dart';
import 'package:flutter_boilerplate/event/components/common/see_more.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/page/show_location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  static const routeName = "/event-detail";
  final int eventID;

  const EventDetail({Key? key, required this.eventID}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

final googleApiKey = dotenv.env['googleApiKey'];

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext buildContext) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              EventDetailCubit(getIt.get<EventDetailRepository>())
                ..onSubscriptionRequested(widget.eventID),
        ),
        BlocProvider(
            create: (context) =>
                UpdateEventDetailCubit(getIt.get<EventDetailRepository>()))
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<UpdateEventDetailCubit, UpdateEventDetailState>(
                listener: (context, state) {
                  if (state is UpdateEventDetailDeletedState) {
                    NavigatorUtil.goBacknTimes(context, 2);
                    Navigator.pop(context, state.eventID);
                  } else if (state is UpdateEventDetailErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                },
              ),
              BlocListener<EventDetailCubit, EventDetailState>(
                listener: (context, state) {
                  if (state.status == LoadingType.ERROR) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
              ),
            ],
            child: BlocBuilder<EventDetailCubit, EventDetailState>(
              builder: (blocContext, state) {
                bool isSuccessState = state.status == LoadingType.SUCCESS;
                return SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      _buildImage(state),
                      Positioned(
                        left: 24,
                        top: 32,
                        child: CircleIconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(buildContext, rootNavigator: true)
                                .pop();
                          },
                        ),
                      ),
                      Positioned(
                        right: 24,
                        top: 32,
                        child: CircleIconButton(
                          icon: const Icon(Icons.more_horiz_outlined),
                          onPressed: () {
                            // OPEN MORE HERE
                            if (isSuccessState) {
                              EventDetailBottomModal.showReportOrEditModal(
                                  context: blocContext,
                                  eventDetail: state.model,
                                  isEventCreator: state.model.isEventCreator);
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 250),
                        padding: const EdgeInsets.all(CustomPadding.body),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(CustomRadius.body),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildEventCategory(state),
                            const SizedBox(
                              height: CustomPadding.base,
                            ),
                            _buildEventName(state),
                            const SizedBox(
                              height: CustomPadding.md,
                            ),
                            _buildEventCreatorDetail(state),
                            const SizedBox(
                              height: CustomPadding.md,
                            ),
                            _buildParticipantsDetail(state),
                            const SizedBox(
                              height: CustomPadding.md,
                            ),
                            isSuccessState
                                ? EventInfo(
                                    icon: Icons.access_time_outlined,
                                    title: DateFormat('MMMM dd, yyyy').format(
                                        DateTime.parse(state.model.event.date)),
                                    body:
                                        '${state.model.event.startTime} - ${state.model.event.endTime}',
                                  )
                                : const EventInfo.loading(),
                            const SizedBox(
                              height: 36,
                            ),
                            isSuccessState
                                ? EventInfo(
                                    icon: Icons.location_on_outlined,
                                    title:
                                        "${state.model.event.location.suburb}, ${state.model.event.location.city}",
                                    body: state.model.event.locationName,
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        ShowLocation.routeName,
                                        arguments: EventPlaceModel(
                                            state.model.event.locationName,
                                            state.model.event.latitude,
                                            state.model.event.longitude),
                                      );
                                    },
                                  )
                                : const EventInfo.loading(),
                            const SizedBox(
                              height: 36,
                            ),
                            isSuccessState
                                ? Text(
                                    "About Event",
                                    style: TextStyle(
                                        color: neutral.shade700,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                : BuildLoading.buildRectangularLoading(
                                    height: 22, width: 100, verticalPadding: 3),
                            _buildEventDescription(state),
                            const SizedBox(
                              height: 25,
                            ),
                            _buildJoinButton(state, blocContext),
                            _buildLeaveButton(state, blocContext)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveButton(
      EventDetailState eventDetailState, BuildContext blocContext) {
    return eventDetailState.status == LoadingType.SUCCESS
        ? eventDetailState.model.event.participated &&
                !eventDetailState.model.isEventCreator
            ? Center(
                child: CustomTextButton(
                  text: "Leave",
                  textWeight: FontWeight.bold,
                  type: TextButtonType.error,
                  onPressedHandler: () {
                    EventDetailBottomModal.showLeaveConfirmationModal(
                        context: context,
                        onLeavePressed: () {
                          blocContext
                              .read<UpdateEventDetailCubit>()
                              .leaveEvent(eventDetailState.model.event.eventID)
                              .then((value) {
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
              )
            : const SizedBox.shrink()
        : const SizedBox.shrink();
  }

  Widget _buildJoinButton(
      EventDetailState eventDetailState, BuildContext context) {
    return eventDetailState.status == LoadingType.SUCCESS
        ? CustomButton(
            label: !eventDetailState.model.event.participated
                ? "Join event"
                : "Event Joined",
            type: ButtonType.primary,
            cornerRadius: CustomRadius.button,
            onPressedHandler: !eventDetailState.model.event.participated
                ? () async {
                    final cubit = context.read<UpdateEventDetailCubit>();
                    await cubit.joinEvent(eventDetailState.model.event.eventID);
                  }
                : null)
        : ShimmerWidget.rectangular(
            height: 52,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          );
  }

  Widget _buildEventDescription(EventDetailState state) {
    return state.status == LoadingType.SUCCESS
        ? SeeMore(
            text: state.model.event.description == "-"
                ? "No description"
                : state.model.event.description,
            characterLimit: (MediaQuery.of(context).size.width / 5).floor(),
          )
        : BuildLoading.buildRectangularLoading(
            height: 16, count: 3, verticalPadding: CustomPadding.xs);
  }

  Widget _buildEventName(EventDetailState state) {
    return state.status == LoadingType.SUCCESS
        ? Text(
            state.model.event.eventName,
            style: TextStyle(
              color: neutral.shade700,
              fontSize: CustomFontSize.lg,
              fontWeight: FontWeight.bold,
            ),
          )
        : BuildLoading.buildRectangularLoading(
            height: 20, verticalPadding: CustomPadding.xs);
  }

  Widget _buildEventCategory(EventDetailState state) {
    return state.status == LoadingType.SUCCESS
        ? EventDetailCategories(event: state.model.event)
        : BuildLoading.buildRectangularLoading(
            height: 16, width: 70, verticalPadding: CustomPadding.xs);
  }

  Widget _buildImage(EventDetailState state) {
    return state.status == LoadingType.SUCCESS
        ? NetworkImageContainer(
            width: double.infinity,
            height: 300,
            image: state.model.event.eventImage?.imageUrl,
          )
        : const ShimmerWidget.rectangular(height: 300);
  }

  Widget _buildEventCreatorDetail(EventDetailState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        state.status == LoadingType.SUCCESS
            ? NetworkImageAvatar(
                imageUrl: state.model.event.eventCreator.userImage?.imageUrl,
                radius: 15)
            : const ShimmerWidget.circular(width: 30, height: 30),
        const SizedBox(
          width: 13,
        ),
        state.status == LoadingType.SUCCESS
            ? Text(
                '${state.model.event.eventCreator.firstName} ${state.model.event.eventCreator.lastName}',
                style: const TextStyle(
                  color: neutral,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            : BuildLoading.buildRectangularLoading(height: 16, width: 100),
      ],
    );
  }

  Widget _buildParticipantsDetail(EventDetailState state) {
    return state.status == LoadingType.SUCCESS
        ? EventDetailParticipants(event: state.model.event)
        : const EventDetailParticipants.loading();
  }
}
