import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/preference_model.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/auth/user/bloc/user_cubit.dart';
import 'package:flutter_boilerplate/auth/user/bloc/user_state.dart';
import 'package:flutter_boilerplate/auth/user/data/user_repository.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/page/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  int eventCount = 12;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(userRepository)..getUser(),
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
              "My Profile",
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
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                } else if (state is UserErrorState) {
                  return Text(state.errorMessage);
                } else if (state is UserSuccessState) {
                  return buildProfile(state.user);
                } else {
                  return const Text("initial");
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfile(UserModel user) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 43.0),
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 52.5,
              child: Image.asset(
                  'lib/common/assets/images/CircleAvatarDefault.png'),
            ),
            const SizedBox(
              width: 22.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ImageIcon(
                          const AssetImage(
                              'lib/common/assets/images/TrophyIcon.png'),
                          color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "$eventCount events",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: eventCount > 20
                        ? Colors.amber
                        : eventCount > 10
                            ? const Color(0xFFC0C0C0)
                            : const Color.fromARGB(255, 189, 52, 2),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    eventCount > 20
                        ? "Gold"
                        : eventCount > 10
                            ? "Silver"
                            : "Bronze",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        buildField("First Name", user.firstName),
        buildField("Last Name", user.lastName),
        buildField("Username", user.username),
        buildField("Email", user.email),
        buildField("Birth Date", user.birthDate),
        const SizedBox(height: 38.0),
        Text(
          "Interest",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Wrap(
            spacing: 10.0,
            runSpacing: 16.0,
            children: buildInterest(user.preferences)),
        const SizedBox(height: 34.0),
        CustomButton(
          label: "Edit Profile",
          type: ButtonType.primary,
          onPressedHandler: () {
            Navigator.pushNamed(context, EditProfile.routeName);
          },
          cornerRadius: 32.0,
        ),
        const SizedBox(height: 20.0),
        CustomButton(
          label: "Sign Out",
          type: ButtonType.red,
          onPressedHandler: () {},
          cornerRadius: 32.0,
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
    List<Widget> widgets = [];
    for (PreferenceModel preference in preferences) {
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
                preference.preferenceName,
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
