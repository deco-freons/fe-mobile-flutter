import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int eventCount = 12;
  List<String> interests = [
    "Gaming",
    "Movie",
    "Dancing",
    "Culinary",
    "Basketball",
    "⚽️ Football"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 35.0),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0.0,
      ),
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(child: buildProfile()),
      ),
    );
  }

  Widget buildProfile() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 43.0),
      children: [
        Center(
          child: CircleAvatar(
            radius: 52.5,
            child:
                Image.asset('lib/common/assets/images/CircleAvatarDefault.png'),
          ),
        ),
        const SizedBox(
          height: 41.0,
        ),
        CustomForm(
          inputs: [
            CustomFormInput(
              label: "First Name",
              type: TextFieldType.string,
              initialValue: "Zahra",
            ),
            CustomFormInput(
              label: "Last Name",
              type: TextFieldType.string,
              initialValue: "Abraara",
            ),
            CustomFormInput(
              label: "Username",
              type: TextFieldType.string,
              initialValue: "Abraara",
            ),
            CustomFormInput(
              label: "Email",
              type: TextFieldType.string,
              initialValue: "zahra@gmail.com",
              disable: true,
            ),
            CustomFormInput(
              label: "Birth Date",
              type: TextFieldType.date,
              initialValue: "2022-02-06",
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ),
          ],
          submitTitle: "Save",
          submitHandler: () {},
          textButtonHandler: () {},
          sidePadding: 0.0,
          labelColor: Theme.of(context).colorScheme.tertiary,
          inputStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Wrap(spacing: 10.0, runSpacing: 16.0, children: buildInterest()),
        const SizedBox(height: 34.0),
        CustomButton(
          label: "Save",
          type: ButtonType.primary,
          onPressedHandler: () {},
          cornerRadius: 32.0,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget buildField(label, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 38.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  List<Widget> buildInterest() {
    List<Widget> widgets = [];
    for (String interest in interests) {
      Widget card = IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          height: 36.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.21),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Row(
            children: [
              Text(
                interest,
                style: const TextStyle(fontSize: 15.0),
              )
            ],
          ),
        ),
      );
      widgets.add(card);
    }
    return widgets;
  }
}
