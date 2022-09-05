import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/auth/logout/bloc/logout_cubit.dart';
import 'package:flutter_boilerplate/auth/logout/bloc/logout_state.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/bloc/events_by_me_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/events_by_me_state.dart';
import 'package:flutter_boilerplate/event/components/event_list.dart';
import 'package:flutter_boilerplate/event/data/events_by_me_repository.dart';
import 'package:flutter_boilerplate/page/edit_profile.dart';
import 'package:flutter_boilerplate/page/landing.dart';
import 'package:flutter_boilerplate/profile/components/event_count_badge.dart';
import 'package:flutter_boilerplate/profile/components/profile_field.dart';
import 'package:flutter_boilerplate/profile/components/tier_badge.dart';
import 'package:flutter_boilerplate/profile/components/user_interests_chips.dart';
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
      padding: const EdgeInsets.symmetric(vertical: CustomPadding.base),
      children: [
        Padding(
          padding: bodyPadding,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 52.5,
                backgroundImage: AssetImage(
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
                        fontSize: CustomFontSize.title,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    EventCountBadge(eventCount: eventCount),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TierBadge(eventCount: eventCount),
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
        const SizedBox(height: 38.0),
        buildInterests(),
        const SizedBox(height: 28.0),
        BlocBuilder<EventsByMeCubit, EventsByMeState>(
            builder: (context, state) {
          return EventList(
              events:
                  state is EventsByMeSuccessState ? state.events.events : [],
              onPressed: () {},
              isLoading: state is! EventsByMeSuccessState,
              title: "Events by Me");
        }),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: bodyPadding,
          child: CustomButton(
            label: "Edit Profile",
            type: ButtonType.primary,
            onPressedHandler: () async {
              UserModel response =
                  await Navigator.pushNamed(context, EditProfile.routeName)
                      as UserModel;
              setState(() {
                updatedUser = response;
                updated = true;
              });
            },
            cornerRadius: CustomRadius.button,
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: bodyPadding,
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

  Widget buildInterests() {
    return Padding(
      padding: bodyPadding,
      child: UserInterestChips(
          preferences:
              updated ? updatedUser.preferences : widget.user.preferences),
    );
  }

  Widget buildField(String label, String value) {
    return Padding(
        padding: bodyPadding, child: ProfileField(label: label, value: value));
  }

  void logout(BuildContext context) async {
    final cubit = context.read<LogoutCubit>();
    await cubit.logout();
  }
}
