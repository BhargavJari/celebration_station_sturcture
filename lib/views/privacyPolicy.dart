import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../dashboard/bottomNavBar/tabs/profile/profileScreen.dart';

class privacyPolicy extends StatefulWidget {
  const privacyPolicy({Key? key}) : super(key: key);

  @override
  State<privacyPolicy> createState() => _privacyPolicyState();
}

class _privacyPolicyState extends State<privacyPolicy> {

  Future<void> _launchURL(String url) async{
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )){
      throw "can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title:  Image.asset(
          "img/celebrationstation.png",
          height: 60,
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: ()
            {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
            icon: Icon(
              CupertinoIcons.bell,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 25),
              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  decoration: TextDecoration.underline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    SizedBox(height: 25 ),
                    GestureDetector(
                      child: TextButton(onPressed: (){
                        _launchURL("https://celebrationstation.in/privacy-policy.html");
                      },
                          child: Text(
                            'See Privacy Policy'
                          ),
                      ),
                    )
                    // GestureDetector(
                    //   onTap: (){
                    //     _launchURL("https://celebrationstation.in/privacy-policy.html");
                    //   },
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
