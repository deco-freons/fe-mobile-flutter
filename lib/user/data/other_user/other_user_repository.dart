import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_model.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_request_model.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_data_provider.dart';

abstract class OtherUserRepository extends BaseRepository {
  Future<OtherUserModel> getUserProfile(OtherUserRequestModel data);
}

class OtherUserRepositoryImpl extends OtherUserRepository {
  final OtherUserDataProvider _profileDataProvider = OtherUserDataProvider();
  @override
  Future<OtherUserModel> getUserProfile(OtherUserRequestModel data) async {
    final response = await _profileDataProvider.getUserProfile(data);
    return OtherUserModel.fromJson(response["user"]);
  }
}
