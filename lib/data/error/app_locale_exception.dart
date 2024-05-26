import 'package:onlinebozor/data/error/app_exception.dart';

abstract class AppLocalException implements AppException {}

class NotAuthorizedException implements AppLocalException {}

class NotIdentifiedException implements AppLocalException {}