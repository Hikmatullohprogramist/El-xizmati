part of 'my_balance_cubit.dart';
@freezed
class MyBalanceState with _$MyBalanceState{
  const factory MyBalanceState({
    @Default('') String balance
}) = _MyBalanceState;
}