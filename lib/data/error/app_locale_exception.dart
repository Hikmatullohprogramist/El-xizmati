import 'package:onlinebozor/data/error/app_exception.dart';

abstract class AppLocalException implements AppException {}

class UserNotAuthorizedException implements AppLocalException {}

class UserNotIdentifiedException implements AppLocalException {}