import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_back_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/components/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/bloc/edit_user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/edit_user_state.dart';
import 'package:flutter_boilerplate/user/bloc/user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/user_state.dart';
import 'package:flutter_boilerplate/user/data/edit_user_model.dart';
import 'package:flutter_boilerplate/user/data/edit_user_repository.dart';
import 'package:flutter_boilerplate/user/data/user_repository.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  final EditUserRepositoryImpl editUserRepository = EditUserRepositoryImpl();
  int eventCount = 12;

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
          hasBackButton: true,

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
    CustomFormInput firstName = CustomFormInput(
      label: "First Name",
      type: TextFieldType.string,
      initialValue: user.firstName,
    );
    CustomFormInput lastName = CustomFormInput(
      label: "Last Name",
      type: TextFieldType.string,
      initialValue: user.lastName,
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
        preferences: user.preferences);

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
        BlocListener<EditUserCubit, EditUserState>(
          listener: (context, state) {
            if (state is EditUserSuccessState) {
              Navigator.pop(context, state.user);
            }
          },
          child: CustomForm(
            inputs: [firstName, lastName, username, email, birthDate, interest],
            submitTitle: "Save",
            submitHandler: () {
              List<String> newPreferences = interest.preferences
                  .map((pref) => pref.preferenceID)
                  .toList();
              EditUserModel data = EditUserModel(
                  firstName: firstName.controller.text,
                  lastName: lastName.controller.text,
                  birthDate: birthDate.controller.text,
                  preferences: newPreferences);
              submit(context, data, interest.preferences);
            },
            textButtonHandler: () {},
            sidePadding: 0.0,
            topPadding: 0.0,
            labelColor: Theme.of(context).colorScheme.tertiary,
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

  Widget buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 38.0),
        Text(
          label,
          style: TextStyle(
            fontSize: CustomFontSize.base,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: CustomFontSize.lg,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  List<Widget> buildInterest(List<PreferenceModel> preferences) {
    List<Widget> widgets = preferences.map((preference) {
      return IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomPadding.base),
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
                preference.preferenceName,
                style: const TextStyle(fontSize: CustomFontSize.base),
              )
            ],
          ),
        ),
      );
    }).toList();
    return widgets;
  }

  void submit(BuildContext context, EditUserModel data,
      List<PreferenceModel> preferences) async {
    final cubit = context.read<EditUserCubit>();
    await cubit.editUser(data, preferences);
  }
}
