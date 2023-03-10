import 'package:bot_toast/bot_toast.dart';
import 'package:celebration_station_sturcture/utils/screen_utils.dart';
import 'package:celebration_station_sturcture/views/auth/login_screen.dart';
import 'package:celebration_station_sturcture/views/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: "${SplashScreen()}",
        home: //SplashScreen(),
        LoginScreen(),
        navigatorObservers: [BotToastNavigatorObserver()],
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: const _ScrollBehaviorModified(),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                ScreenUtil.init(constraints,
                    designSize:
                        Size(constraints.maxWidth, constraints.maxHeight));
                child = botToastBuilder(context, child);
                return child ?? const SizedBox.shrink();
              },
            ),
          );
        },
      );
    });
  }
}

class _ScrollBehaviorModified extends ScrollBehavior {
  const _ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
