import 'dart:convert';

import 'package:celebration_station_sturcture/dashboard/CustomDrawer.dart';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/tabs/profile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../CustomDrawer.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title:  Image.asset(
          "asset/images/logo.png",
          height: 60,
        ),
        leading: Builder(
            builder: (context) {
              return IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }
        ),
      ),
      body: const Body(),
    );
  }
}
