import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'add_card_cubit.freezed.dart';

part 'add_card_state.dart';

@injectable
class AddCardCubit extends BaseCubit<AddCardBuildable, AddCardListenable> {
  AddCardCubit() : super(const AddCardBuildable());

  void setCardPosition(int position) {
    updateState((buildable) => buildable.copyWith(selectedCard: position));
  }

  void setCardName(String name) {
    updateState((buildable) => buildable.copyWith(cardName: name));
  }

  void setCardNumber(String number) {
    updateState((buildable) => buildable.copyWith(cardNumber: number));
  }

  void setExpiredDate(String expired) {
    updateState((buildable) => buildable.copyWith(cardExpired: expired));
  }

  void setMainCard(bool isMainCard) {
    updateState((buildable) => buildable.copyWith(isMain: isMainCard));
  }

  Future<void> addCard() async {}
}
