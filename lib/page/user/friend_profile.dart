import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/components/layout/page_app_bar.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/common/event_list.dart';
import 'package:flutter_boilerplate/user/bloc/other_user/other_user_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/other_user/other_user_state.dart';
import 'package:flutter_boilerplate/user/components/profile_field.dart';
import 'package:flutter_boilerplate/user/components/user_interests_chips.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_repository.dart';

class FriendProfile extends StatelessWidget {
  static const routeName = "friend-profile";
  final OtherUserRepository _profileRepository = OtherUserRepositoryImpl();
  final int userID;

  FriendProfile({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget spacing = const SizedBox(
      height: 38,
    );
    return BlocProvider(
      create: (context) =>
          OtherUserCubit(_profileRepository)..getUserProfile(userID),
      child: BlocConsumer<OtherUserCubit, OtherUserState>(
        listener: (context, state) {
          if (state is OtherUserErrorState) {
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
              title: state is OtherUserSuccessState
                  ? '${state.profile.firstName} ${state.profile.lastName}'
                  : "",
              hasLeadingWidget: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: CustomPadding.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildAvatar(state),
                  state is OtherUserSuccessState
                      ? buildField("Username", state.profile.username, false)
                      : buildField("Username", "", true),
                  state is OtherUserSuccessState
                      ? buildField("Location",
                          state.profile.location?.suburb ?? "", false)
                      : buildField("Location", "", true),
                  spacing,
                  buildInterests(state),
                  spacing,
                  EventList(
                    title:
                        'Events by ${state is OtherUserSuccessState ? state.profile.username : ""}',
                    isLoading: state is! OtherUserSuccessState,
                    events: state is OtherUserSuccessState
                        ? state.profile.eventCreated
                        : [],
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAvatar(OtherUserState state) {
    return Center(
      child: state is OtherUserSuccessState
          ? NetworkImageAvatar(
              imageUrl: state.profile.userImage?.imageUrl,
              radius: 75,
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

  Widget buildInterests(OtherUserState state) {
    return Padding(
      padding: bodyPadding,
      child: state is OtherUserSuccessState
          ? UserInterestChips(
              preferences: state.profile.preferences
                  .map((preference) => preference)
                  .toList())
          : const UserInterestChips.loading(),
    );
  }
}
