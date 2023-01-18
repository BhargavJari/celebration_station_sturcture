import 'package:bot_toast/bot_toast.dart';

class Loader {
  static showLoader() {
    BotToast.showLoading();
  }

  static hideLoader() {
    BotToast.closeAllLoading();
  }
}
