import 'package:celebration_station_sturcture/views/auth/login_screen.dart';
import 'package:celebration_station_sturcture/views/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return Sizer(builder: (context, orientation, deviceType) {
    //   // return MaterialApp(
    //   //   debugShowCheckedModeBanner: false,
    //   //   home: const SplashScreen(),
    //   // );
    //
    // });
    return Sizer(
        builder: (context, orientation, deviceType){
          return const MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.system,
              home: SplashScreen(),
          );
        }
    );
  }
}
