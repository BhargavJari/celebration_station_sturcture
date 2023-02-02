import 'package:celebration_station_sturcture/Utils/colors_utils.dart';
import 'package:celebration_station_sturcture/views/auth/forgot_password_number_screen.dart';
import 'package:celebration_station_sturcture/views/custom_widget/custom_text_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/fontFamily_utils.dart';
import '../../services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../services/shared_preference.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.appBgColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.maxFinite,
            color: ColorUtils.whiteColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    "asset/images/logo.png",
                    scale: 2,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    child: Text(
                      "Login Here",
                      style: FontTextStyle.poppinsS24W7BlackColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 3.h),
                          CustomTextField(
                              prefixIcon: const Icon(Icons.phone),
                              hintName: "Enter Phone No",
                              fieldController: phoneController,
                              keyboard: TextInputType.phone,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              validator: (str) {
                                if (str!.isEmpty) {
                                  return '* Is Required';
                                } else if (str.length != 10) {
                                  return '* Phone number must be of 10 digit';
                                }
                              }),
                          SizedBox(
                            height: 3.h,
                          ),
                          CustomTextField(
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                child: obscurePassword
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            obscureText: obscurePassword,
                            prefixIcon: const Icon(Icons.password),
                            fieldController: passwordController,
                            fieldName: "Password",
                            hintName: " Password",
                            keyboard: TextInputType.visiblePassword,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            validator: (str) {
                              if (str!.isEmpty) {
                                return '* Is Required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 3.h),
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
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      ApiService()
                                          .login(context, data: data())
                                          .then((value) async {
                                        String? token = await FirebaseMessaging
                                            .instance
                                            .getToken();
                                        Preferances.setString(
                                            "notificationToken", token);
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: FontTextStyle.poppinsS16W7BlackColor,
                                  ),
                                )),
                          ),
                          SizedBox(height: 2.h,),

                        ],
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context) =>ForgotPasswordNumberScreen()));},
                  child: Text("Forgot Password",style: FontTextStyle.poppinsS12W7BlackColor,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  FormData data() {
    return FormData.fromMap({"user_id": phoneController.text.trim(),"password":passwordController.text.trim()});
  }
}
