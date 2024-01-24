part of 'user_review_orders_cubit.dart';

@freezed
class UserReviewOrdersBuildable with _$UserReviewOrdersBuildable {
  const factory UserReviewOrdersBuildable(
          {@Default("") String keyWord,
          @Default(LoadingState.loading) LoadingState userOrderState,
          PagingController<int, UserOrderResponse>?
              userOrderPagingController,
          @Default(OrderType.buy) OrderType orderType}) =
      _UserReviewOrdersBuildable;
}

@freezed
class UserReviewOrdersListenable with _$UserReviewOrdersListenable {
  const factory UserReviewOrdersListenable() = _UserReviewOrdersListenable;
}
