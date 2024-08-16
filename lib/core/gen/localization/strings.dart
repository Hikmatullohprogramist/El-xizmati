import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_generator/easy_localization_generator.dart';

part 'strings.g.dart';

// LINK FOR THE GOOGLE SHEET
// https://docs.google.com/spreadsheets/d/14H9f5eQWz2aH71NH9cGqEuy_BvgDyo_VMo-AlznFsfY/edit#gid=0
// file owner on cloud is realsoftllc.developers@gmail.com

// ignore: unused_element
@SheetLocalization(
  docId: '14H9f5eQWz2aH71NH9cGqEuy_BvgDyo_VMo-AlznFsfY',
  version: 142,
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
