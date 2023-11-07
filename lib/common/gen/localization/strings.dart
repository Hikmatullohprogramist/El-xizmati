import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_generator/easy_localization_generator.dart';

part 'strings.g.dart';

// LINK FOR THE GOOGLE SHEET
// https://docs.google.com/spreadsheets/d/1Dqdash1R4Mlhvh1uuwNKzL3t_OnnHC6YyTwJCokJyE0/edit#gid=0

// ignore: unused_element
@SheetLocalization(
  docId: '1Dqdash1R4Mlhvh1uuwNKzL3t_OnnHC6YyTwJCokJyE0',
  version: 28,
  outDir: 'assets/localization',
  outName: 'translations.csv',
  preservedKeywords: [
    'few',
    'many',
    'one',
    'other',
    'two',
    'zero',
    'male',
    'female',
  ],
)
class _Strings {}