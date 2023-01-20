import 'dart:convert';

import 'package:celebration_station_sturcture/Utils/fontFamily_utils.dart';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/tabs/profile/components/profilePic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../model/GetAllProfileModel.dart';
import '../../../../../services/api_services.dart';
import '../../../../../services/shared_preference.dart';
import '../../../../../views/auth/login_screen.dart';
import '../../../../../views/contactUs.dart';
import '../../../../../views/editProfile.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  ProfileDetails? profileDetails;
  String? id = '';
  String? token = '';
  String? type = '';
  var formData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getProfileRecord(context).then((value) {
      if(value!.message == "ok"){
        print("hhiii");
        setState(() {
          profileDetails = value.detail!;
        });
        print('model:$profileDetails');
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            Text("${profileDetails?.bRANCHNAME}", style: FontTextStyle.poppinsS16W7BlackColor,),
            SizedBox(height: 20),
            ProfileMenu(
              icon: CupertinoIcons.profile_circled,
              text: "Edit Profile",
              press: () async{
                String? id = await Preferances.getString("id");
                String? token = await Preferances.getString("token");
                String? type = await Preferances.getString("type");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditProfile(userId: '${id}', token: '${token}', type: '${type}',)));
              },
            ),
            ProfileMenu(
              icon: CupertinoIcons.mail,
              text: "Contact us",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            ProfileMenu(
              icon: Icons.note_outlined,
              text: "Terms & Condition",
              press: () async{
                var url =Uri.parse("https://celebrationstation.in/terms-conditions.html");

                if (await canLaunchUrl(url)){
                  await launchUrl(url);
                }else{
                  throw 'Could not launch $url';
                }
              },
            ),
            ProfileMenu(
              icon: Icons.privacy_tip_outlined,
              text: "Privacy Policy",
              press: () async{
                var url =Uri.parse("https://celebrationstation.in/privacy-policy.html");

                if (await canLaunchUrl(url)){
                  await launchUrl(url);
                }else{
                  throw 'Could not launch $url';
                }

              },
            ),
            ProfileMenu(
              icon: CupertinoIcons.person,
              text: "Log Out",
              press: () {
                showDialog(
                    context: context,
                    builder: (ctx) =>
                    AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are You Sure ?"),
                      actions: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(14),
                                child: const Text("Cancel"),
                              ),
                            ),
                            TextButton(
                              onPressed: ()async {
                                SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                                sharedPreferences.clear();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) =>
                                    const LoginScreen()), (
                                    Route<dynamic> route) => false);
                              },
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(14),
                                child: const Text("okay"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.grey.shade200,
        ),
        onPressed: press,
        child: Row(
          children: [
            IconButton(
              iconSize: 28,
              icon: Icon(
                icon,
                color: Colors.lime,
              ),
              onPressed: () {

              },
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                text  ,
                style: FontTextStyle.poppinsS12W7BlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

