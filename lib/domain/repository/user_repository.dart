import 'package:onlinebozor/data/model/user/user_information_response.dart';

abstract class UserRepository {
  Future<UserInformationResponse> getUserInformation();

}
