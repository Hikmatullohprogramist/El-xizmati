import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../widgets/app_bar/default_app_bar.dart';

@RoutePage()
class LanguageThemePage extends StatefulWidget {
  const LanguageThemePage({super.key});

  @override
  State<LanguageThemePage> createState() => _LanguageThemeState();
}

class _LanguageThemeState extends State<LanguageThemePage> {
  int _selectedLanguage = 0;
  int _selectedMode = 0;
  final Map<int, String> languages = {
    0:'Uzbek (Latin)',
    1:'Узбек (Кирил)',
    2:'English',
    3:'Русский',
  };
  final Map<int, String> mode = {
    0:'Avtomatik',
    1:'Qora rangli',
    2:'Oq rangli',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "Til va rang",
        titleTextColor: context.colors.primary,
        backgroundColor: Colors.white,
        onBackPressed: () {
          context.router.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tizim tilini tanlang",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = index;
                    });
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        _selectedLanguage != index ?Icon(Icons.radio_button_off, color: Colors.grey,size: 20,):Icon(Icons.radio_button_checked, color: context.colors.buttonPrimary,size: 20,),
                        SizedBox(width: 10),
                        Text(languages[index]!)
                      ],
                    ),
                  ),
                );
              },
              itemCount: languages.length,
            ),
            SizedBox(height: 16),
            Text(
              "Tizim rangini tanlang",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedMode = index;
                    });
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        _selectedMode != index ?Icon(Icons.radio_button_off, color: Colors.grey,size: 20,):Icon(Icons.radio_button_checked, color: context.colors.buttonPrimary,size: 20,),
                        SizedBox(width: 10),
                        Text(mode[index]!)
                      ],
                    ),
                  ),
                );
              },
              itemCount: mode.length,
            ),
          ],
        ),
      ),
    );
  }
}
