import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/circle_icon_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail_state.dart';
import 'package:flutter_boilerplate/event/components/edit_bottom_modal.dart';
import 'package:flutter_boilerplate/event/components/event_info.dart';
import 'package:flutter_boilerplate/event/components/leave_bottom_modal.dart';

import 'package:flutter_boilerplate/event/data/place_model.dart';
import 'package:flutter_boilerplate/event/components/see_more.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';
import 'package:flutter_boilerplate/page/show_location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:google_geocoding/google_geocoding.dart' as geocode;

class EventDetail extends StatefulWidget {
  static const routeName = "/event-detail";
  final int eventID;

  const EventDetail({Key? key, required this.eventID}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

final googleApiKey = dotenv.env['googleApiKey'];

class _EventDetailState extends State<EventDetail> {
  geocode.GoogleGeocoding googleGeocoding =
      geocode.GoogleGeocoding(googleApiKey!);
  final EventDetailRepository _eventDetailRepository =
      EventDetailRepositoryImpl();
  String locationName = "";
  String locationArea = "";
  String formattedAddress = "";
  LoadingType geoCodeStatus = LoadingType.INITIAL;

  Future<void> _handleReverseGeoCoding(double lat, double long) async {
    try {
      geocode.GeocodingResponse? response =
          await googleGeocoding.geocoding.getReverse(geocode.LatLon(lat, long));
      if (response != null) {
        setState(() {
          formattedAddress = response.results?[0].formattedAddress ?? "";
          locationName =
              response.results?[0].addressComponents?[0].longName ?? "";
          locationArea =
              '${response.results?[0].addressComponents?[1].longName ?? ""}, ${response.results?[0].addressComponents?[2].shortName}';
          geoCodeStatus = LoadingType.SUCCESS;
        });
      }
    } catch (e) {
      setState(() {
        locationName = "";
        locationArea = "";
        formattedAddress = "";
      });
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
      create: (context) => EventDetailCubit(_eventDetailRepository)
        ..getEventDetail(widget.eventID),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<EventDetailCubit, EventDetailState>(
            listener: (listenerContext, state) {
              // REVERSE GEO LOCATE HERE
              if (state is EventDetailSuccessState &&
                  geoCodeStatus == LoadingType.INITIAL) {
                _handleReverseGeoCoding(
                    state.eventDetailResponseModel.event.latitude,
                    state.eventDetailResponseModel.event.longitude);
              }
              if (state is EventDetailDeletedState) {
                NavigatorUtil.goBacknTimes(context, 2);
                Navigator.pop(context, state.eventID);
              }
            },
            builder: (blocContext, state) {
              if (state is EventDetailErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              bool isSuccessState = state is EventDetailSuccessState;
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
                          Navigator.of(buildContext, rootNavigator: true).pop();
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
                          if (state is EventDetailSuccessState) {
                            showLeaveOrEditBottomModal(
                                blocContext,
                                state.eventDetailResponseModel.event.eventID,
                                state.eventDetailResponseModel.isEventCreator);
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 250),
                      padding: const EdgeInsets.all(27),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildEventCategory(state),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildEventName(state),
                          const SizedBox(
                            height: 15,
                          ),
                          _buildEventCreatorDetail(state),
                          const SizedBox(
                            height: 15,
                          ),
                          _buildParticipantsDetail(state),
                          const SizedBox(
                            height: 25,
                          ),
                          isSuccessState
                              ? EventInfo(
                                  icon: Icons.access_time_outlined,
                                  title: DateFormat('MMMM dd, yyyy').format(
                                      DateTime.parse(state
                                          .eventDetailResponseModel
                                          .event
                                          .date)),
                                  body:
                                      '${state.eventDetailResponseModel.event.startTime} - ${state.eventDetailResponseModel.event.endTime}',
                                )
                              : const EventInfo.loading(),
                          const SizedBox(
                            height: 36,
                          ),
                          isSuccessState
                              ? EventInfo(
                                  icon: Icons.location_on_outlined,
                                  title: locationArea,
                                  body: locationName,
                                  onTap: () {
                                    // OPEN GOOGLE MAP
                                    if (geoCodeStatus == LoadingType.SUCCESS) {
                                      Navigator.of(context).pushNamed(
                                        ShowLocation.routeName,
                                        arguments: PlaceModel(
                                            formattedAddress,
                                            state.eventDetailResponseModel.event
                                                .latitude,
                                            state.eventDetailResponseModel.event
                                                .longitude),
                                      );
                                    }
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
                          _buildJoinButton(state, blocContext)
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
    );
  }

  showLeaveOrEditBottomModal(
      BuildContext blocContext, int eventID, bool isEventCreator) {
    showModalBottomSheet(
      context: blocContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return isEventCreator
            ? EditBottomModal(eventID: eventID, blocContext: blocContext)
            : LeaveBottomModal(
                eventID: eventID,
                blocContext: blocContext,
              );
      },
    );
  }

  Widget _buildJoinButton(state, BuildContext context) {
    return state is EventDetailSuccessState
        ? CustomButton(
            label: !state.eventDetailResponseModel.event.participated
                ? "Join event"
                : "Event Joined",
            type: ButtonType.primary,
            cornerRadius: 32,
            onPressedHandler: !state.eventDetailResponseModel.event.participated
                ? () async {
                    // JOIN HERE
                    final cubit = context.read<EventDetailCubit>();
                    await cubit.joinEvent(
                        state.eventDetailResponseModel.event.eventID);
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
    return state is EventDetailSuccessState
        ? SeeMore(
            text: state.eventDetailResponseModel.event.description == "-"
                ? "No description"
                : state.eventDetailResponseModel.event.description,
            characterLimit: (MediaQuery.of(context).size.width / 5).floor(),
          )
        : BuildLoading.buildRectangularLoading(
            height: 16, count: 3, verticalPadding: 3);
  }

  Widget _buildEventName(EventDetailState state) {
    return state is EventDetailSuccessState
        ? Text(
            state.eventDetailResponseModel.event.eventName,
            style: TextStyle(
              color: neutral.shade700,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        : BuildLoading.buildRectangularLoading(height: 20, verticalPadding: 5);
  }

  Widget _buildEventCategory(EventDetailState state) {
    return state is EventDetailSuccessState
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 15,
              children: state.eventDetailResponseModel.event.categories
                  .map(
                    (category) => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primary.shade400,
                      ),
                      child: Text(
                        category.preferenceName,
                        style: TextStyle(
                          color: neutral.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        : BuildLoading.buildRectangularLoading(
            height: 16, width: 70, verticalPadding: 5);
  }

  Widget _buildImage(EventDetailState state) {
    return state is EventDetailSuccessState
        ? Image.asset(
            "lib/common/assets/images/eventBG.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          )
        : const ShimmerWidget.rectangular(height: 300);
  }

  Widget _buildEventCreatorDetail(EventDetailState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        state is EventDetailSuccessState
            ? const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(
                    "lib/common/assets/images/CircleAvatarDefault.png"),
              )
            : const ShimmerWidget.circular(width: 30, height: 30),
        const SizedBox(
          width: 13,
        ),
        state is EventDetailSuccessState
            ? Text(
                '${state.eventDetailResponseModel.event.eventCreator.firstName} ${state.eventDetailResponseModel.event.eventCreator.lastName}',
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
    return Row(
      children: [
        state is EventDetailSuccessState
            ? RichText(
                text: TextSpan(
                  text: state.eventDetailResponseModel.event.participants
                      .toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: neutral.shade900,
                    fontSize: 16,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " people are going:",
                      style: TextStyle(
                        color: neutral,
                      ),
                    ),
                  ],
                ),
              )
            : BuildLoading.buildRectangularLoading(
                height: 16, width: 150, verticalPadding: 3),
        const SizedBox(
          width: 15,
        ),
        ...List.filled(
          3,
          Padding(
            padding: const EdgeInsets.all(1),
            child: state is EventDetailSuccessState
                ? const CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(
                        "lib/common/assets/images/CircleAvatarDefault.png"),
                  )
                : const ShimmerWidget.circular(width: 20, height: 20),
          ),
        ),
        const Spacer(),
        state is EventDetailSuccessState
            ? CustomTextButton(
                text: "View All",
                fontSize: 16,
                onPressedHandler: () {
                  // GO TO VIEW ALL PARTICIPANTS PAGE
                },
              )
            : BuildLoading.buildRectangularLoading(
                height: 25, width: 65, verticalPadding: 3)
      ],
    );
  }
}
