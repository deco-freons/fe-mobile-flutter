import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_component.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/data/user_model.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/bloc/update_user/edit_user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/update_user/edit_user_state.dart';
import 'package:flutter_boilerplate/user/bloc/common/user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/common/user_state.dart';
import 'package:flutter_boilerplate/user/data/update_user/edit_user_repository.dart';
import 'package:flutter_boilerplate/user/data/update_user/edit_user_model.dart';
import 'package:flutter_boilerplate/user/data/common/user_location_model.dart';
import 'package:flutter_boilerplate/user/data/common/user_repository.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  final EditUserRepositoryImpl editUserRepository = EditUserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditUserCubit>(
          create: (BuildContext context) => EditUserCubit(editUserRepository),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) =>
              UserCubit(userRepository)..getUser(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PageAppBar(
          title: "Edit Profile",
          hasLeadingWidget: true,
        ),
        body: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: SafeArea(
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                } else if (state is UserErrorState) {
                  return Text(state.errorMessage);
                } else if (state is UserSuccessState) {
                  return buildEditProfile(context, state.user);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditProfile(BuildContext context, UserModel user) {
    final CustomFormInput profileImage = CustomFormInput(
        label: "",
        type: TextFieldType.profileImage,
        initialImage: user.userImage?.imageUrl);
    CustomFormInput firstName = CustomFormInput(
      label: "First Name",
      type: TextFieldType.string,
      initialValue: user.firstName,
      required: true,
    );
    CustomFormInput lastName = CustomFormInput(
      label: "Last Name",
      type: TextFieldType.string,
      initialValue: user.lastName,
      required: true,
    );
    CustomFormInput username = CustomFormInput(
      label: "Username",
      type: TextFieldType.string,
      initialValue: user.username,
      disable: true,
    );
    CustomFormInput email = CustomFormInput(
      label: "Email",
      type: TextFieldType.string,
      initialValue: user.email,
      disable: true,
    );
    CustomFormInput birthDate = CustomFormInput(
      label: "Birth Date",
      type: TextFieldType.date,
      initialValue: user.birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    CustomFormInput interest = CustomFormInput(
      label: "Interests",
      type: TextFieldType.interest,
      preferences: user.preferences,
    );
    CustomFormInput location = CustomFormInput(
      label: "Location",
      type: TextFieldType.suburbDropdown,
      initialValue: user.location.suburb,
      initialgoogleMapSuburb: "",
    );
    CustomFormInput isShareLocation = CustomFormInput(
      label: "Allow other users to see your location?",
      type: TextFieldType.toggleSwitch,
      initialSwitchValue: user.isShareLocation,
    );
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: CustomPadding.body),
      shrinkWrap: true,
      children: [
        BlocListener<EditUserCubit, EditUserState>(
          listener: (context, state) {
            if (state is EditUserSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Profile successfuly updated!")));
              Navigator.pop(context, state.user);
            } else if (state is EditUserImageErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              Navigator.pop(context, state.user);
            }
          },
          child: CustomForm(
            inputs: [
              profileImage,
              firstName,
              lastName,
              username,
              email,
              birthDate,
              location,
              isShareLocation,
              interest,
            ],
            submitTitle: "Save",
            submitHandler: () {
              List<String> newPreferences = interest.preferences
                  .map((pref) => pref.preferenceID)
                  .toList();
              EditUserModel data = EditUserModel(
                  firstName: firstName.controller.text,
                  lastName: lastName.controller.text,
                  birthDate: birthDate.controller.text,
                  location: location.controller.text == ""
                      ? 0
                      : int.parse(location.controller.text),
                  isShareLocation: isShareLocation.switchController != null
                      ? isShareLocation.switchController!.value
                      : false,
                  preferences: newPreferences);
              submit(
                  context,
                  data,
                  interest.preferences,
                  UserLocationModel(suburb: location.location.suburb),
                  profileImage.image,
                  profileImage.imageInputAction);
            },
            textButtonHandler: () {},
            sidePadding: 0.0,
            topPadding: 0.0,
            submitButtonRadius: CustomRadius.button,
            labelColor: neutral.shade600,
            inputStyle: TextStyle(
              fontSize: CustomFontSize.lg,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  void submit(
      BuildContext context,
      EditUserModel data,
      List<PreferenceModel> preferences,
      UserLocationModel location,
      File? image,
      ImageInputAction action) async {
    final cubit = context.read<EditUserCubit>();
    await cubit.editUser(data, preferences, location, image, action);
  }
}
