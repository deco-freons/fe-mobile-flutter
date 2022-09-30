import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_component.dart';
import 'package:flutter_boilerplate/common/components/layout/page_header.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/create_event/create_event_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/create_event/create_event_state.dart';
import 'package:flutter_boilerplate/event/data/create_event/create_event_model.dart';
import 'package:flutter_boilerplate/event/data/create_event/create_event_repository.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);
  static const routeName = '/create-event';

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEventCubit(CreateEventRepositoryImpl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(child: buildCreateEvent()),
        ),
      ),
    );
  }

  Widget buildCreateEvent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PageHeader(title: "Create Event"),
          BlocConsumer<CreateEventCubit, CreateEventState>(
            builder: (context, state) {
              if (state is CreateEventLoadingState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBarHeight -
                      48,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              } else if (state is CreateEventErrorState) {
                return CreateEventForm(errorMessage: state.errorMessage);
              } else {
                return const CreateEventForm();
              }
            },
            listener: (context, state) {
              if (state is CreateEventSuccessState ||
                  state is CreateEventUploadErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state is CreateEventUploadErrorState
                        ? state.errorMessage
                        : "Event successfully created"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pushReplacementNamed(context, Dashboard.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}

class CreateEventForm extends StatefulWidget {
  final String errorMessage;

  const CreateEventForm({
    Key? key,
    this.errorMessage = "",
  }) : super(key: key);

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final CustomFormInput image =
      CustomFormInput(label: 'Add Photo', type: TextFieldType.eventImage);
  final CustomFormInput eventName =
      CustomFormInput(label: 'Event Name', type: TextFieldType.string);
  final CustomFormInput category = CustomFormInput(
    label: 'Category',
    type: TextFieldType.interest,
  );
  final CustomFormInput date = CustomFormInput(
    label: 'Date',
    type: TextFieldType.date,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
  final CustomFormInput eventTime = CustomFormInput(
    label: 'Start and End Time',
    type: TextFieldType.eventTime,
  );
  final CustomFormInput shortDescription = CustomFormInput(
    label: 'Short Description',
    type: TextFieldType.textArea,
    maxLength: 100,
  );
  final CustomFormInput description = CustomFormInput(
    label: 'Description',
    type: TextFieldType.textArea,
  );
  final CustomFormInput location = CustomFormInput(
    label: 'Location',
    type: TextFieldType.location,
    initialgoogleMapSuburb: "",
  );
  final CustomFormInput price = CustomFormInput(
    label: 'Price',
    type: TextFieldType.price,
  );

  @override
  Widget build(BuildContext context) {
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
        description
      ],
      submitTitle: 'Create',
      submitHandler: () {
        CreateEventModel data = CreateEventModel(
            eventName: eventName.controller.text,
            categories:
                category.preferences.map((pref) => pref.preferenceID).toList(),
            date: date.controller.text,
            startTime: eventTime.controller.text,
            endTime: eventTime.secondController != null
                ? eventTime.secondController!.text
                : eventTime.controller.text,
            longitude: location.lng.toString(),
            latitude: location.lat.toString(),
            location: location.googleMapSuburbId != null
                ? location.googleMapSuburbId!
                : 0,
            locationName: location.controller.text,
            shortDescription: shortDescription.controller.text != ""
                ? shortDescription.controller.text
                : "No description",
            description: description.controller.text != ""
                ? description.controller.text
                : "No description");

        submit(context, data, image.image);
      },
      topPadding: 0.0,
      textButtonHandler: () {},
      labelColor: neutral.shade600,
      inputStyle: TextStyle(
        fontSize: CustomFontSize.lg,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      errorMessage: widget.errorMessage,
    );
  }
}

void submit(BuildContext context, CreateEventModel data, File? image) {
  final cubit = context.read<CreateEventCubit>();
  cubit.createEvent(data, image);
}
