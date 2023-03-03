import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/colors_utils.dart';
import 'auth/login_screen.dart';
import 'auth/signUp.dart';

class SignupType extends StatefulWidget {
  const SignupType({Key? key}) : super(key: key);

  @override
  State<SignupType> createState() => _SignupTypeState();
}

class _SignupTypeState extends State<SignupType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: BackButton(
          color: ColorUtils.blackColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 4.h),
                Image.asset(
                  "asset/images/logo.png",
                  scale: 2,
                ),
                SizedBox(height: 3.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 2.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(100, 0, 0, 0),
                          ),
                        ],
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                            text: ' Celebration Station',
                            style: TextStyle(letterSpacing: 2.0))
                      ]),
                ),
                SizedBox(height: 60),
                Center(
                  child: SizedBox(
                      height: 50, //height of button
                      width: double.infinity, //width of button
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                          Colors.lime[200], //background color of button
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp(userType: "3")),
                          );
                        },
                        child: Text(
                          "Signup as a Customer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black),
                        ),
                      )),
                ),
                SizedBox(height: 15.0),
                Center(
                  child: Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Center(
                  child: SizedBox(
                      height: 50, //height of button
                      width: double.infinity, //width of button
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.lime),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp(userType: "2",)),
                          );
                        },
                        child: Text(
                          "Signup as a Business",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
