import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var phoneMaskFormatter = MaskTextInputFormatter(
  mask: '__ ___ __ __',
  filter: {"_": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var brithMaskFormatter = MaskTextInputFormatter(
  mask: '____-__-__',
  filter: {"_": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var biometricNumberMaskFormatter = MaskTextInputFormatter(
  mask: '___ __ __',
  filter: {"_": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var cardNumberMaskFormatter = MaskTextInputFormatter(
  mask: '____ ____ ____ ____',
  filter: {"_": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var cardExpiredMaskFormatter = MaskTextInputFormatter(
  mask: '__/__',
  filter: {"_": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var amountMaskFormatter = CurrencyTextInputFormatter(
  decimalDigits: 0,
  enableNegative: true,
  inputDirection: InputDirection.right,
  symbol: '',
  name: '',
  turnOffGrouping: false,
  locale: 'uz',
  customPattern: null,
);

var quantityMaskFormatter = CurrencyTextInputFormatter(
  decimalDigits: 0,
  enableNegative: true,
  inputDirection: InputDirection.right,
  symbol: '',
  name: '',
  turnOffGrouping: false,
  locale: 'uz',
  customPattern: null,
);
