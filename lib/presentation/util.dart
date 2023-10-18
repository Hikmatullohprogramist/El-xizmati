import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var textMaskFormatter = MaskTextInputFormatter(
    mask: '+998 __ ___ __ __',
    filter: {"_": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);
