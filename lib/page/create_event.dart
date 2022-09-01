import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/create_event_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/create_event_state.dart';
import 'package:flutter_boilerplate/event/data/create_event_model.dart';
import 'package:flutter_boilerplate/event/data/create_event_repository.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';

import '../../common/config/enum.dart';

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
                'Create Event',
                style: TextStyle(
                    fontSize: CustomFontSize.title,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        BlocConsumer<CreateEventCubit, CreateEventState>(
          builder: (context, state) {
            if (state is CreateEventLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            } else if (state is CreateEventErrorState) {
              return CreateEventForm(errorMessage: state.errorMessage);
            } else {
              return const CreateEventForm();
            }
          },
          listener: (context, state) {
            if (state is CreateEventSuccessState) {
              Navigator.pushReplacementNamed(context, Dashboard.routeName);
            }
          },
        ),
      ],
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
  final CustomFormInput photo =
      CustomFormInput(label: 'Add Photo', type: TextFieldType.image);
  final CustomFormInput eventName =
      CustomFormInput(label: 'Event Name', type: TextFieldType.string);
  final CustomFormInput category = CustomFormInput(
    label: 'Category',
    type: TextFieldType.category,
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
  final CustomFormInput description = CustomFormInput(
    label: 'Description',
    type: TextFieldType.textArea,
  );
  final CustomFormInput location = CustomFormInput(
    label: 'Location',
    type: TextFieldType.location,
  );

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      inputs: [
        photo,
        eventName,
        category,
        date,
        eventTime,
        location,
        description
      ],
      submitTitle: 'Create',
      submitHandler: () {
        CreateEventModel data = CreateEventModel(
            eventName: eventName.controller.text,
            categories: [category.controller.text],
            date: date.controller.text,
            startTime: eventTime.controller.text,
            endTime: eventTime.secondController != null
                ? eventTime.secondController!.text
                : eventTime.controller.text,
            longitude: location.lng.toString(),
            latitude: location.lat.toString(),
            description: description.controller.text != ""
                ? description.controller.text
                : "No description");
        submit(context, data);
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

void submit(BuildContext context, CreateEventModel data) {
  final cubit = context.read<CreateEventCubit>();
  cubit.createEvent(data);
}
