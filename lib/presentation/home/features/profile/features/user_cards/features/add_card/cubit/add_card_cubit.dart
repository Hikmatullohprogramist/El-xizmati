import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'add_card_cubit.freezed.dart';

part 'add_card_state.dart';

@injectable
class AddCardCubit extends BaseCubit<AddCardBuildable, AddCardListenable> {
  AddCardCubit() : super(const AddCardBuildable());

  void setCardPosition(int position) {
    updateState((state) => state.copyWith(selectedCard: position));
  }

  void setCardName(String name) {
    updateState((state) => state.copyWith(cardName: name));
  }

  void setCardNumber(String number) {
    updateState((state) => state.copyWith(cardNumber: number));
  }

  void setExpiredDate(String expired) {
    updateState((state) => state.copyWith(cardExpired: expired));
  }

  void setMainCard(bool isMainCard) {
    updateState((state) => state.copyWith(isMain: isMainCard));
  }

  Future<void> addCard() async {}
}
