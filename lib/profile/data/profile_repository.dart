import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/profile/data/models/profile_model.dart';
import 'package:flutter_boilerplate/profile/data/models/profile_request_model.dart';
import 'package:flutter_boilerplate/profile/data/profile_data_provider.dart';

abstract class ProfileRepository extends BaseRepository {
  Future<ProfileModel> getUserProfile(ProfileRequestModel data);
}

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDataProvider _profileDataProvider = ProfileDataProvider();
  @override
  Future<ProfileModel> getUserProfile(ProfileRequestModel data) async {
    final response = await _profileDataProvider.getUserProfile(data);
    return ProfileModel.fromJson(response["user"]);
  }
}
