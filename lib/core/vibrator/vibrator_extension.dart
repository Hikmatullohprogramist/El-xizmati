import 'package:vibration/vibration.dart';

Future<void> vibrateAsHapticFeedback() async {
  if (await Vibration.hasCustomVibrationsSupport() == true) {
    Vibration.vibrate(duration: 5, amplitude: 40);
  }
}

Future<void> vibrate() async {
  if (await Vibration.hasVibrator() == true) {
    Vibration.vibrate(duration: 50); // Vibrate for 50 milliseconds
  }
}
