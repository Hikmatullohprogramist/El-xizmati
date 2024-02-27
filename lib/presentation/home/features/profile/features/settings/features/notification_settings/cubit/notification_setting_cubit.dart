import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'notification_setting_cubit.freezed.dart';
part 'notification_setting_state.dart';

@injectable
class NotificationSettingCubit extends BaseCubit<NotificationSettingBuildable,
    NotificationSettingListenable> {
  NotificationSettingCubit() : super(const NotificationSettingBuildable());

  setSmsNotification() {
    updateState((buildable) =>
        buildable.copyWith(smsNotification: !buildable.smsNotification));
  }

  setTelegramNotification() {
    updateState((buildable) => buildable.copyWith(
        telegramNotification: !buildable.telegramNotification));
  }

  setEmailNotification() {
    updateState((buildable) =>
        buildable.copyWith(emailNotification: !buildable.emailNotification));
  }

  Future<void> openTelegram() async {
    try {
      var url = Uri.parse("https://t.me/online_bozor_rs_bot");
      await launchUrl(url);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
