import 'dart:convert';

import 'package:celebration_station_sturcture/dashboard/bottomNavBar/tabs/profile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String id = "";
  var data;
  void get_profile_record(id) async{
    try{
      Response response= await post(
        Uri.parse('https://celebrationstation.in/get_ajax/get_profile_record/'),
        headers: {
          'Client-Service':'frontend-client',
          'Auth-Key':'simplerestapi',
        },
        // body: jsonEncode(<String, String>{'email': phone, 'password': password}),
        // body: {
        //   'email': phone,
        //   'password': password,
        // },
        body: {
          'loginid':id,
        },
      );

      if(response.statusCode == 200){
        data = new Map.from(json.decode(response.body));
        print(data);
        print('Data got');
      }else{
        print('Failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchLoginData();

  }

  _fetchLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('id') ?? '');
    });
    get_profile_record(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: const Body(),
    );
  }
}
