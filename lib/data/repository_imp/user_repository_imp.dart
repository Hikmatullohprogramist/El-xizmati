import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/user_api.dart';
import 'package:onlinebozor/data/model/user/user_information_response.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImp extends UserRepository {
  final UserApi _api;

  UserRepositoryImp(this._api);

  @override
  Future<UserInformationResponse> getUserInformation() async {
    final response =await _api.getUserInformation();
    final result =UserInformationRootResponse.fromJson(response.data).data;
    return result;
  }
}
