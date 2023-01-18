import 'dart:async';
import 'package:celebration_station_sturcture/views/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dashboard/bottomNavBar/bottom_nav_bar.dart';
import '../../dashboard/bottomNavBar/tabs/ourServices-1.dart';
import '../../services/shared_preference.dart';
import '../home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  initState(){

    // TODO: implement initState
    super.initState();
    getData();
  }

  // Future getData() async{
  //
  //   id = await Preferances.getString("id");
  //   Future.delayed(Duration(seconds: 3)).then((value) async {
  //     print('$id');
  //     if(id != null){
  //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
  //           OurServices()), (Route<dynamic> route) => false);
  //     }else {
  //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
  //       const LoginScreen()), (Route<dynamic> route) => false);
  //     }
  //   });
  // }
  Future getData() async{
    Future.delayed(Duration(seconds: 3)).then((value) async {
      String? id = await Preferances.getString("id");
      print("userId:=${id}");
      if(id != null){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              BottomNavBar()), (Route<dynamic> route) => false);
      }else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const LoginScreen()), (Route<dynamic> route) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          body: Center(child:Image.asset("asset/images/logo.png",scale: 5,)),
        )
    );
  }
}
