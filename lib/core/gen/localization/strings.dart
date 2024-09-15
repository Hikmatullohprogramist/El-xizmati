import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_generator/easy_localization_generator.dart';

part 'strings.g.dart';

// LINK FOR THE GOOGLE SHEET
// https://docs.google.com/spreadsheets/d/1kK1eXqORw-lKWkzznIAVhoqef70vgcnbxAk4bNtWto8/edit?gid=0#gid=0

// ignore: unused_element
@SheetLocalization(
  docId: '1kK1eXqORw-lKWkzznIAVhoqef70vgcnbxAk4bNtWto8',
  version: 1,
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
