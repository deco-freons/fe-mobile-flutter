import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/event_card_small.dart';
import 'package:flutter_boilerplate/event/components/home_content.dart';
import 'package:flutter_boilerplate/profile/bloc/profile_cubit.dart';
import 'package:flutter_boilerplate/profile/bloc/profile_state.dart';
import 'package:flutter_boilerplate/profile/components/profile_field.dart';
import 'package:flutter_boilerplate/profile/components/user_interests_chips.dart';
import 'package:flutter_boilerplate/profile/data/profile_repository.dart';

class FriendProfile extends StatelessWidget {
  static const routeName = "friend-profile";
  final ProfileRepository _profileRepository = ProfileRepositoryImpl();
  final int userID;

  FriendProfile({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget spacing = const SizedBox(
      height: 38,
    );
    return BlocProvider(
      create: (context) =>
          ProfileCubit(_profileRepository)..getUserProfile(userID),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: neutral.shade100,
            appBar: PageAppBar(
              title: state is ProfileSuccessState
                  ? '${state.profile.firstName} ${state.profile.lastName}'
                  : "",
              hasBackButton: true,
            ),
            buildField("Username", "jisoo"),
            buildField("Location", "Brisbane City"),
            spacing,
            buildInterests(),
            spacing,
            HomeContent(
              title: "Events by Me",
              titleBottomSpacing: CustomPadding.sm,
              isPair: true,
              contentWidgets: List.filled(
                3,
                const EventCardSmall.loading(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAvatar(ProfileState state) {
    return Center(
      child: state is ProfileSuccessState
          ? const CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage(
                  'lib/common/assets/images/CircleAvatarDefault.png'),
            )
          : const ShimmerWidget.circular(width: 150, height: 150),
    );
  }

  Widget buildField(String label, String value, bool isLoading) {
    return Padding(
        padding: bodyPadding,
        child: !isLoading
            ? ProfileField(label: label, value: value)
            : const ProfileField.loading());
  }

  Widget buildInterests(ProfileState state) {
    return Padding(
      padding: bodyPadding,
      child: state is ProfileSuccessState
          ? UserInterestChips(
              preferences: state.profile.preferences
                  .map((preference) => preference)
                  .toList())
          : const UserInterestChips.loading(),
    );
  }
}
