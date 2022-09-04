import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/auth/logout/bloc/logout_cubit.dart';
import 'package:flutter_boilerplate/auth/logout/bloc/logout_state.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/date_parser.dart';
import 'package:flutter_boilerplate/event/bloc/events_by_me_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/events_by_me_state.dart';
import 'package:flutter_boilerplate/event/components/event_card_small.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/event/data/events_by_me_repository.dart';
import 'package:flutter_boilerplate/page/edit_profile.dart';
import 'package:flutter_boilerplate/page/landing.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/bloc/user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/user_state.dart';
import 'package:flutter_boilerplate/user/data/user_repository.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserRepository userRepository = UserRepositoryImpl();
  final EventsByMeRepository _eventsByMeRepository = EventsByMeRepositoryImpl();
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
        BlocProvider<EventsByMeCubit>(
          create: (BuildContext context) =>
              EventsByMeCubit(_eventsByMeRepository)..getEventsByMe(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PageAppBar(
          title: "My Profile",
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
                  return BuildProfilePage(user: state.user);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BuildProfilePage extends StatefulWidget {
  final UserModel user;

  const BuildProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<BuildProfilePage> createState() => _BuildProfilePageState();
}

class _BuildProfilePageState extends State<BuildProfilePage> {
  int eventCount = 12;
  late UserModel updatedUser;
  bool updated = false;

  @override
  void initState() {
    super.initState();
    updatedUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: CustomPadding.body),
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: CustomPadding.body,
            right: CustomPadding.body,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 52.5,
                child: Image.asset(
                    'lib/common/assets/images/CircleAvatarDefault.png'),
              ),
              const SizedBox(
                width: 22.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      updated
                          ? "${updatedUser.firstName} ${updatedUser.lastName}"
                          : "${widget.user.firstName} ${widget.user.lastName}",
                      overflow: TextOverflow.fade,
                      softWrap: false,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomPadding.base),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(CustomRadius.xxl)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                              fontSize: CustomFontSize.base,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomPadding.md),
                      decoration: BoxDecoration(
                        color: eventCount > 20
                            ? Colors.amber
                            : eventCount > 10
                                ? const Color(0xFFC0C0C0)
                                : const Color.fromARGB(255, 189, 52, 2),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(CustomRadius.xxl)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
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
                          fontSize: CustomFontSize.base,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildField("First Name",
            updated ? updatedUser.firstName : widget.user.firstName),
        buildField(
            "Last Name", updated ? updatedUser.lastName : widget.user.lastName),
        buildField("Username", widget.user.username),
        buildField("Email", widget.user.email),
        buildField("Birth Date",
            updated ? updatedUser.birthDate : widget.user.birthDate),
        buildField(
            "Location",
            updated
                ? updatedUser.location.suburb
                : widget.user.location.suburb),
        const SizedBox(height: 38.0),
        Padding(
          padding: const EdgeInsets.only(
            left: CustomPadding.body,
            right: CustomPadding.body,
          ),
          child: Text(
            "Interest",
            style: TextStyle(
              fontSize: CustomFontSize.base,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: CustomPadding.body,
            right: CustomPadding.body,
          ),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 0.0,
            children: buildInterest(
                updated ? updatedUser.preferences : widget.user.preferences),
          ),
        ),
        const SizedBox(height: 34.0),
        BlocBuilder<EventsByMeCubit, EventsByMeState>(
            builder: (context, state) {
          return HomeContent(
            title: "Events by Me",
            contentWidgets: state is EventsByMeSuccessState
                ? state.events.events.map((event) {
                    List<String> splittedDate =
                        DateParser.parseEventDate(event.date);
                    return EventCardSmall(
                        eventID: event.eventID,
                        title: event.eventName,
                        distance: event.distance,
                        month: splittedDate[0].substring(0, 3),
                        date: splittedDate[1].substring(0, 2),
                        image: 'lib/common/assets/images/SmallEventTest.png');
                  }).toList()
                : List.filled(
                    3,
                    const EventCardSmall.loading(),
                  ),
          );
        }),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: CustomPadding.body,
            right: CustomPadding.body,
          ),
          child: CustomButton(
            label: "Edit Profile",
            type: ButtonType.primary,
            onPressedHandler: () async {
              UserModel? response =
                  await Navigator.pushNamed(context, EditProfile.routeName)
                      as UserModel?;
              if (response != null) {
                setState(() {
                  updatedUser = response;
                  updated = true;
                });
              }
            },
            cornerRadius: CustomRadius.button,
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(
            left: CustomPadding.body,
            right: CustomPadding.body,
          ),
          child: BlocListener<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccessState) {
                Navigator.pushReplacementNamed(context, Landing.routeName);
              }
            },
            child: CustomButton(
              label: "Sign Out",
              type: ButtonType.red,
              onPressedHandler: () {
                logout(context);
              },
              cornerRadius: 32.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(
        left: CustomPadding.body,
        right: CustomPadding.body,
      ),
      child: Column(
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
      ),
    );
  }

  List<Widget> buildInterest(List<PreferenceModel> preferences) {
    List<Widget> widgets = preferences.map((preference) {
      return PreferenceButton(
        stringInput: preference.preferenceName,
        useStringInput: true,
        onPressedHandler: () {},
      );
    }).toList();
    return widgets;
  }

  void logout(BuildContext context) async {
    final cubit = context.read<LogoutCubit>();
    await cubit.logout();
  }
}
