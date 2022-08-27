import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/auth/logout/bloc/logout_cubit.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/bloc/user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/user_state.dart';
import 'package:flutter_boilerplate/user/data/user_repository.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  int eventCount = 12;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogoutCubit>(
          create: (BuildContext context) =>
              LogoutCubit(RepositoryProvider.of<AuthRepository>(context)),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) =>
              UserCubit(userRepository)..getUser(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: Colors.black, size: 35.0),
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
                  return buildProfile(context, state.user);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfile(BuildContext context, UserModel user) {
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
        CustomForm(
          inputs: [firstName, lastName, username, email, birthDate, interest],
          submitTitle: "Save",
          submitHandler: () {},
          textButtonHandler: () {},
          sidePadding: 0.0,
          topPadding: 0.0,
          labelColor: Theme.of(context).colorScheme.tertiary,
          inputStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  List<Widget> buildInterest(List<PreferenceModel> preferences) {
    List<Widget> widgets = preferences.map((preference) {
      return IntrinsicWidth(
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
                preference.preferenceName,
                style: const TextStyle(fontSize: 15.0),
              )
            ],
          ),
        ),
      );
    }).toList();
    return widgets;
  }

  void logout(BuildContext context) async {
    final cubit = context.read<LogoutCubit>();
    await cubit.logout();
  }
}
