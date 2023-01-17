import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _Terms();
}

class _Terms extends State<Terms> {
  String shortDesc='';
  String longDesc='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    privacyPolicy();
  }

  void privacyPolicy() async{
    try{
      Response response= await post(
        Uri.parse('https://celebrationstation.in/get_ajax/get_company_profile/'),
        headers: {
          'Client-Service':'frontend-client',
          'Auth-Key':'simplerestapi',
        },
      );

      if(response.statusCode == 200){
        //var data = jsonDecode(response.body);
        Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
        print(data['detail']['ORG_TERMS_CONDITION_SHORT_DESC']);
        print(data['detail']['ORG_TERMS_CONDITIONS_2']);
        shortDesc=data['detail']['ORG_TERMS_CONDITION_SHORT_DESC'];
        longDesc=data['detail']['ORG_TERMS_CONDITIONS_2'];
        print('Fetch Terms Data');
      }else{
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Failed to fetch Terms Data');
      }
    }catch(e){
      print(e.toString());
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
                "Terms & Conditions",
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
                    Text(
                      shortDesc,
                    ),
                    SizedBox(height: 10 ),
                    Text(
                      longDesc,
                    )
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
