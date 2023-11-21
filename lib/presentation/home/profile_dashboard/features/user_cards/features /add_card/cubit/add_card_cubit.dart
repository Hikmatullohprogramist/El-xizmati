import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'add_card_cubit.freezed.dart';
part 'add_card_state.dart';

@injectable
class AddCardCubit extends BaseCubit<AddCardBuildable, AddCardListenable> {
  AddCardCubit() : super(const AddCardBuildable());

  void setCardPosition(int position) {
    build((buildable) => buildable.copyWith(selectedCard: position));
  }

  void setCardName(String name) {
    build((buildable) => buildable.copyWith(cardName: name));
  }

  void setCardNumber(String number) {
    build((buildable) => buildable.copyWith(cardNumber: number));
  }

  void setExpiredDate(String expired) {
    build((buildable) => buildable.copyWith(cardExpired: expired));
  }

  void setMainCard(bool isMainCard) {
    build((buildable) => buildable.copyWith(isMain: isMainCard));
  }

  Future<void> addCard() async {}
}
