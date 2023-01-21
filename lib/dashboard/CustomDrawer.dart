import 'dart:convert';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/bottom_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/GetAllProfileModel.dart';
import '../services/api_services.dart';
import '../services/shared_preference.dart';
import '../views/auth/login_screen.dart';
import '../views/contactUs.dart';
import '../views/editProfile.dart';
import '../views/faq.dart';
import '../views/ourService.dart';
import '../views/subscription_screen.dart';
import 'bottomNavBar/tabs/ourServices-1.dart';

class CustomDrawer extends StatefulWidget {
  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  ProfileDetails? profileDetails;
  var formData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getProfileRecord(context).then((value) {
      if (value!.message == "ok") {
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
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text(
                    "${profileDetails?.bRANCHNAME != null ? profileDetails?.bRANCHNAME : ""}"),
                accountEmail: Text(
                    "${profileDetails?.bRANCHEMAIL != null ? profileDetails?.bRANCHEMAIL : ""}"),
                currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white))),
                decoration: BoxDecoration(color: Colors.lime)),
            ListTile(
                leading: Icon(Icons.person, color: Colors.lime),
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return BottomNavBar(
                      index: 0,
                    );
                  }));
                }),
            ListTile(
              leading: Icon(Icons.person, color: Colors.lime),
              title: Text('My Acount'),
              onTap: () async {
                String? id = await Preferances.getString("id");
                String? token = await Preferances.getString("token");
                String? type = await Preferances.getString("type");
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return BottomNavBar(
                    index: 3,
                  ); //EditProfile(userId: '${id}', token: '${token}', type: '${type}',);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.fitness_center, color: Colors.lime),
              title: Text('Event Details'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return BottomNavBar(
                    index: 2,
                  );
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month, color: Colors.lime),
              title: Text('Event Booking'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return BottomNavBar(
                    index: 1,
                  );
                }));
              },
            ),
            Divider(color: Colors.lime, indent: 20.0),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined, color: Colors.lime),
              title: Text('Privacy Policy'),
              onTap: () async {
                var url = Uri.parse(
                    "https://celebrationstation.in/privacy-policy.html");

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.lime),
              title: Text('Payment Refund'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SubscriptionScreen();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer_outlined, color: Colors.lime),
              title: Text('FAQ'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return faqScreen();
                    }));
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page, color: Colors.lime),
              title: Text('Contact us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ContactUs();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.lime),
              title: Text('Terms & Condition'),
              onTap: () async {
                var url = Uri.parse(
                    "https://celebrationstation.in/terms-conditions.html");

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.lime),
              title: Text('About'),
              onTap: () async {
                var url = Uri.parse(
                    "https://celebrationstation.in/about-us.html");

                if (await canLaunchUrl(url)) {
                await launchUrl(url);
                } else {
                throw 'Could not launch $url';
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.lime),
              title: Text('Logout'),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
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
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.clear();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (Route<dynamic> route) => false);
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
