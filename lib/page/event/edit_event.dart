import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_component.dart';
import 'package:flutter_boilerplate/common/components/layout/page_header.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/brisbane_location_list_model.dart';
import 'package:flutter_boilerplate/common/utils/brisbane_location_util.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/update_event/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_model.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_response_model.dart';
import 'package:flutter_boilerplate/get_it.dart';

class EditEvent extends StatefulWidget {
  final EventDetailResponseModel eventDetail;
  const EditEvent({Key? key, required this.eventDetail}) : super(key: key);
  static const routeName = '/edit-event';

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdateEventDetailCubit(getIt.get<EventDetailRepository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(child: buildEditEvent()),
        ),
      ),
    );
  }

  Widget buildEditEvent() {
    return ListView(
      children: [
        const PageHeader(title: "Edit Event"),
        BlocConsumer<UpdateEventDetailCubit, UpdateEventDetailState>(
          builder: (context, state) {
            if (state is UpdateEventDetailLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (state is UpdateEventDetailErrorState) {
              return EditEventForm(
                errorMessage: state.errorMessage,
                eventDetail: widget.eventDetail,
              );
            } else {
              return EditEventForm(eventDetail: widget.eventDetail);
            }
          },
          listener: (context, state) {
            if (state is UpdateEventDetailEditedState ||
                state is UpdateEventDetailImageErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state is UpdateEventDetailImageErrorState
                      ? state.errorMessage
                      : "Event successfully updated!")));
              NavigatorUtil.goBacknTimes(context, 2);
            }
          },
        ),
      ],
    );
  }
}

class EditEventForm extends StatefulWidget {
  final String errorMessage;
  final EventDetailResponseModel? eventDetail;

  const EditEventForm({
    Key? key,
    this.eventDetail,
    this.errorMessage = "",
  }) : super(key: key);

  @override
  State<EditEventForm> createState() => _EditEventFormState();
}

class _EditEventFormState extends State<EditEventForm> {
  late Future<String> _brisbaneLocationJson;

  @override
  void initState() {
    super.initState();
    _brisbaneLocationJson = BrisbaneLocationUtil.getJson(context);
  }

  @override
  Widget build(BuildContext context) {
    EventDetailModel? event = widget.eventDetail?.event;
    final CustomFormInput image = CustomFormInput(
        label: 'Add Photo',
        type: TextFieldType.eventImage,
        initialImage: widget.eventDetail?.event.eventImage?.imageUrl);
    final CustomFormInput eventName = CustomFormInput(
        label: 'Event Name',
        type: TextFieldType.string,
        initialValue: event?.eventName,
        required: true);
    final CustomFormInput category = CustomFormInput(
      label: 'Category',
      type: TextFieldType.interest,
    );
    final CustomFormInput date = CustomFormInput(
      label: 'Date',
      type: TextFieldType.date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialValue: event?.date,
    );
    final CustomFormInput eventTime = CustomFormInput(
      label: 'Start and End Time',
      type: TextFieldType.eventTime,
      initialValue: event?.startTime,
      initialSecondValue: event?.endTime,
    );
    final CustomFormInput shortDescription = CustomFormInput(
      label: 'Short Description',
      type: TextFieldType.textArea,
      maxLength: 100,
      initialValue: event?.shortDescription,
    );
    final CustomFormInput description = CustomFormInput(
      label: 'Description',
      type: TextFieldType.textArea,
      initialValue: event?.description,
    );
    final CustomFormInput price = CustomFormInput(
      label: 'Price',
      type: TextFieldType.price,
      initialValue: event?.eventPrice.fee.toString(),
    );
    final CustomFormInput location = CustomFormInput(
      label: 'Location',
      type: TextFieldType.location,
      initialValue: event?.locationName,
      initialgoogleMapSuburb: event?.location.suburb,
    );

    if (event != null) {
      location.setLatLng(event.latitude, event.longitude);
      category.setPreferences(event.categories);
      location.location = event.location;
    }

    void submit(
      BuildContext context,
      EventDetailResponseModel data,
      File? image,
      ImageInputAction action,
    ) async {
      final cubit = context.read<UpdateEventDetailCubit>();

      List<dynamic> jsonResult = jsonDecode(await _brisbaneLocationJson);
      BrisbaneLocationListModel locationListModel = BrisbaneLocationListModel(
          brisbaneLocations: BrisbaneLocationUtil.createModel(jsonResult));

      cubit.editEvent(
          data,
          location.googleMapSuburbId != null &&
                  location.initialgoogleMapSuburb != null
              ? location.googleMapSuburbId!
              : locationListModel.getIdFromSuburb(
                  location.initialgoogleMapSuburb!,
                  location.initialgoogleMapSuburb!),
          image,
          action);
    }

    return CustomForm(
      inputs: [
        image,
        eventName,
        category,
        date,
        eventTime,
        location,
        price,
        shortDescription,
        description,
      ],
      submitTitle: 'Save',
      submitHandler: () {
        if (event != null) {
          EventDetailModel updatedEvent = EventDetailModel(
              eventID: event.eventID,
              eventName: eventName.controller.text,
              categories: category.preferences,
              date: date.controller.text,
              startTime: eventTime.controller.text,
              endTime: eventTime.secondController != null
                  ? eventTime.secondController!.text
                  : eventTime.controller.text,
              longitude: location.lng,
              latitude: location.lat,
              shortDescription: shortDescription.controller.text != ""
                  ? shortDescription.controller.text
                  : "No Description",
              description: description.controller.text != ""
                  ? description.controller.text
                  : "No Description",
              eventCreator: event.eventCreator,
              participants: event.participants,
              participantsList: event.participantsList,
              participated: event.participated,
              locationName: location.controller.text,
              location: location.location,
              eventStatus: event.eventStatus,
              eventImage: event.eventImage,
              eventPrice: event.eventPrice.copyWith(
                  fee: price.controller.text != ""
                      ? int.parse(price.controller.text)
                      : 0));
          EventDetailResponseModel data = EventDetailResponseModel(
            event: updatedEvent,
            isEventCreator: true,
          );
          submit(context, data, image.image, image.imageInputAction);
        }
      },
      topPadding: 0.0,
      textButtonHandler: () {},
      labelColor: Theme.of(context).colorScheme.tertiary,
      inputStyle: TextStyle(
        fontSize: CustomFontSize.lg,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      errorMessage: widget.errorMessage,
    );
  }
}
