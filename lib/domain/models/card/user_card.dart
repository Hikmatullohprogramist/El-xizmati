import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class UserCard {
  final String id;
  final double balance;
  final String cardHolder;
  final String cardName;
  final String cardPan;
  final bool isDeposit;
  final SvgGenImage cardLogo;

  UserCard({
    required this.id,
    required this.balance,
    required this.cardHolder,
    required this.cardName,
    required this.cardPan,
    required this.isDeposit,
    required this.cardLogo,
  });
}
