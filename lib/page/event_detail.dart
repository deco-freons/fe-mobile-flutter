import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/circle_icon_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail_state.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/components/edit_bottom_modal.dart';
import 'package:flutter_boilerplate/event/components/event_info.dart';
import 'package:flutter_boilerplate/event/components/leave_bottom_modal.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';
import 'package:flutter_boilerplate/event/data/place_model.dart';
import 'package:flutter_boilerplate/event/components/see_more.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';
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
                  // REVERSE GEO LOCATE HERE
                  if (state.status == LoadingType.SUCCESS &&
                      geoCodeStatus == LoadingType.INITIAL) {
                    _handleReverseGeoCoding(state.model.event.latitude,
                        state.model.event.longitude);
                  } else if (state.status == LoadingType.ERROR) {
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
                              showLeaveOrEditBottomModal(blocContext,
                                  state.model, state.model.isEventCreator);
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
                                    title: locationArea,
                                    body: locationName,
                                    onTap: () {
                                      // OPEN GOOGLE MAP
                                      if (geoCodeStatus ==
                                          LoadingType.SUCCESS) {
                                        Navigator.of(context).pushNamed(
                                          ShowLocation.routeName,
                                          arguments: PlaceModel(
                                              formattedAddress,
                                              state.model.event.latitude,
                                              state.model.event.longitude),
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
      ),
    );
  }

  showLeaveOrEditBottomModal(BuildContext blocContext,
      EventDetailResponseModel eventDetail, bool isEventCreator) {
    showModalBottomSheet(
      context: blocContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(CustomRadius.body),
        ),
      ),
      builder: (context) {
        return isEventCreator
            ? EditBottomModal(eventDetail: eventDetail)
            : LeaveBottomModal(
                eventID: eventDetail.event.eventID,
              );
      },
    );
  }

  Widget _buildJoinButton(
      EventDetailState eventDetailState, BuildContext context) {
    return eventDetailState.status == LoadingType.SUCCESS
        ? BlocBuilder<UpdateEventDetailCubit, UpdateEventDetailState>(
            builder: (context, state) {
              return CustomButton(
                  label: !eventDetailState.model.event.participated
                      ? "Join event"
                      : "Event Joined",
                  type: ButtonType.primary,
                  cornerRadius: CustomRadius.button,
                  onPressedHandler: !eventDetailState.model.event.participated
                      ? () async {
                          final cubit = context.read<UpdateEventDetailCubit>();
                          await cubit
                              .joinEvent(eventDetailState.model.event.eventID);
                        }
                      : null);
            },
          )
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
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: CustomPadding.md,
              children: state.model.event.categories
                  .map(
                    (category) => Container(
                      padding: const EdgeInsets.all(CustomPadding.sm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(CustomRadius.xl),
                        color: primary.shade300,
                      ),
                      child: Text(
                        category.preferenceName,
                        style: TextStyle(
                          color: neutral.shade700,
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
            height: 16, width: 70, verticalPadding: CustomPadding.xs);
  }

  Widget _buildImage(EventDetailState state) {
    return state.status == LoadingType.SUCCESS
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
        state.status == LoadingType.SUCCESS
            ? const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(
                    "lib/common/assets/images/CircleAvatarDefault.png"),
              )
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
    return Row(
      children: [
        state.status == LoadingType.SUCCESS
            ? RichText(
                text: TextSpan(
                  text: state.model.event.participants.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: neutral.shade900,
                    fontSize: CustomFontSize.base,
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
            child: state.status == LoadingType.SUCCESS
                ? const CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(
                        "lib/common/assets/images/CircleAvatarDefault.png"),
                  )
                : const ShimmerWidget.circular(width: 20, height: 20),
          ),
        ),
        const Spacer(),
        state.status == LoadingType.SUCCESS
            ? CustomTextButton(
                text: "View All",
                fontSize: CustomFontSize.base,
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
