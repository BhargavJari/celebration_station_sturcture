import 'package:celebration_station_sturcture/views/auth/login_screen.dart';
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
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      );
    });
    // return Sizer(
    //     builder: (context, orientation, deviceType){
    //       return MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           themeMode: ThemeMode.system,
    //           home: const SplashScreen(),
    //           builder: (context, child) {
    //             return ScrollConfiguration(  behavior: const _ScrollBehaviorModified(),
    //               child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
    //                 ScreenUtil.init(constraints,
    //                     designSize:
    //                     Size(constraints.maxWidth, constraints.maxHeight));
    //                 child = botToastBuilder(context, child);
    //                 return child ?? const SizedBox.shrink();
    //               },
    //
    //               ),
    //
    //             );
    //           }
    //       );
    //       //  const MaterialApp(
    //       //   debugShowCheckedModeBanner: false,
    //       //   //home: TeamScreen(),
    //       //   home: LoginScreen(),
    //       //   //home: BottomNavBar(),
    //       //  // home: EnquireScreen(),
    //       //
    //       //
    //       // );
    //
    //     }
    //
    // );
  }
}

