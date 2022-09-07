import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail_model.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';
import 'package:flutter_boilerplate/get_it.dart';

import '../../common/config/enum.dart';

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
        Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Text(
                'Edit Event',
                style: TextStyle(
                    fontSize: CustomFontSize.title,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        BlocConsumer<UpdateEventDetailCubit, UpdateEventDetailState>(
          builder: (context, state) {
            if (state is UpdateEventDetailLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            } else if (state is UpdateEventDetailErrorState) {
              return EditEventForm(errorMessage: state.errorMessage);
            } else {
              return EditEventForm(eventDetail: widget.eventDetail);
            }
          },
          listener: (context, state) {
            if (state is UpdateEventDetailEditedState) {
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
  @override
  Widget build(BuildContext context) {
    EventDetailModel? event = widget.eventDetail?.event;
    final CustomFormInput photo =
        CustomFormInput(label: 'Add Photo', type: TextFieldType.image);
    final CustomFormInput eventName = CustomFormInput(
        label: 'Event Name',
        type: TextFieldType.string,
        initialValue: event?.eventName);
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

    void submit(BuildContext context, EventDetailResponseModel data) {
      final cubit = context.read<UpdateEventDetailCubit>();
      cubit.editEvent(
        data,
        location.googleMapSuburbId != null ? location.googleMapSuburbId! : 0,
      );
    }

    return CustomForm(
      inputs: [
        photo,
        eventName,
        category,
        date,
        eventTime,
        location,
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
            shortDescription: shortDescription.controller.text,
            description: description.controller.text,
            eventCreator: event.eventCreator,
            participants: event.participants,
            participantsList: event.participantsList,
            participated: event.participated,
            locationName: location.controller.text,
            location: location.location,
          );
          EventDetailResponseModel data = EventDetailResponseModel(
            event: updatedEvent,
            isEventCreator: true,
          );
          submit(context, data);
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
