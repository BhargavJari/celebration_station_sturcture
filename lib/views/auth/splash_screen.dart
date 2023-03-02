import 'dart:async';
import 'package:celebration_station_sturcture/dashboard/bottomNavBarCustomer/bottom_nav_bar_customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../dashboard/bottomNavBar/bottom_nav_bar.dart';
import '../../services/shared_preference.dart';
import '../home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      String? id = await Preferances.getString("id");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      String? userType = await Preferances.getString("USER_TYPE");
      print("userId:=${id}");
      print("ps:=${profileStatus}");
      print("User Type:=${userType.toString()}");
      if (id != null ) {
        if(userType?.replaceAll('"', '').replaceAll('"', '').toString() == "2"){
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const BottomNavBar(
                      index: 0,
                    )),
            (Route<dynamic> route) => false);
        }else if(userType?.replaceAll('"', '').replaceAll('"', '').toString() == "3"){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const BottomNavBarCustomer(
                    index: 0,
                  )),
                  (Route<dynamic> route) => false);
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(
          child: Image.asset(
        "asset/images/logo.png",
        scale: 2,
      )),
    ));
  }
}
