part of 'set_language_cubit.dart';

@freezed
class SetLanguageState with _$SetLanguageState {
  const factory SetLanguageState() = _SetLanguageState;
}

@freezed
class SetLanguageEvent with _$SetLanguageEvent {
  const factory SetLanguageEvent() = _SetLanguageEvent;
}
// return Scaffold(
// appBar: AppBar(
// backgroundColor: context.backgroundWhiteColor,
// elevation: 0,
// ),
// backgroundColor: context.backgroundWhiteColor,
// resizeToAvoidBottomInset: false,
// body: SafeArea(
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Assets.images.pngImages.appLogo.image(width: 64, height: 64),
// Text("el xizmati").w(700).s(32).c(Color(0xFF703EDB)),
// Text("ishchilar jamiyati").w(300).s(18).c(Color(0xFF2A174E)),
// SizedBox(height: 50),
// Text(
// "Interfeys\ntilini tanlang",
// textAlign: TextAlign.center,
// ).w(800).s(32).c(Color(0xFF2A174E)),
// Spacer(),
// CustomElevatedButton(
// text: Strings.languageUzLat,
// onPressed: () {
// HapticFeedback.lightImpact();
// cubit(context).setLanguage(Language.uzbekCyrill);
// EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
// },
// ),
// SizedBox(height: 12),
// CustomElevatedButton(
// text: Strings.languageRus,
// onPressed: () {
// HapticFeedback.lightImpact();
// cubit(context).setLanguage(Language.uzbekCyrill);
// EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
// },
// ),
// SizedBox(height: 12),
// CustomElevatedButton(
// text: Strings.languageUzCyr,
// onPressed: () {
// HapticFeedback.lightImpact();
// cubit(context).setLanguage(Language.uzbekCyrill);
// EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZK'));
// },
// ),
// ],
// ),
// ),
// ),
// );