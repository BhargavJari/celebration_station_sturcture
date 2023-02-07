import 'package:bot_toast/bot_toast.dart';
import 'package:celebration_station_sturcture/utils/screen_utils.dart';

import 'package:celebration_station_sturcture/views/auth/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
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
        home: SplashScreen(),
       // LoginScreen(),
        //RegistrationScrenn(),
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
