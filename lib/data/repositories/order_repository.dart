import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/services/cart_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';

class OrderRepository {
  final AuthPreferences _authPreferences;
  final CartRepository _cartRepository;
  final CartService _cartService;
  final UserPreferences _userPreferences;
  final UserEntityDao _userEntityDao;

  OrderRepository(
    this._authPreferences,
    this._cartRepository,
    this._cartService,
    this._userEntityDao,
    this._userPreferences,
  );

  Future<void> orderCreate({
    required int adId,
    required int amount,
    required int paymentTypeId,
    required int tin,
    required int? servicePrice,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    var user = await _userEntityDao.getUser();
    var neighborhoodId = user?.neighborhoodId ?? 0;

    await _cartService.orderCreate(
      productId: adId,
      amount: amount,
      paymentTypeId: paymentTypeId,
      tin: tin,
      neighborhoodId: neighborhoodId,
      servicePrice: servicePrice,
    );

    await removeOrder(tin: tin);
    await _cartRepository.removeFromCart(adId);
  }

  Future<void> removeOrder({required int tin}) async {
    _cartService.removeOrder(tin: tin);
    return;
  }
}
