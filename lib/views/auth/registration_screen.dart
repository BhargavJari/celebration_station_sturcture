import 'package:celebration_station_sturcture/views/auth/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';
import '../../Utils/colors_utils.dart';
import '../../Utils/fontFamily_utils.dart';
import '../../services/api_services.dart';
import '../custom_widget/custom_text_field.dart';

class RegistrationScrenn extends StatefulWidget {
  final String? mobileNumber;
  final userType;

  const RegistrationScrenn({Key? key, this.mobileNumber, required this.userType}) : super(key: key);

  @override
  State<RegistrationScrenn> createState() => _RegistrationScrennState();
}

class _RegistrationScrennState extends State<RegistrationScrenn> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  String? mtoken = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getToken();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("Token:-${mtoken}");
      });
    });
  }
  /*@override
  void setState(VoidCallback fn) {}*/

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
                      "Register Here",
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
                            hintName: "${widget.mobileNumber}",
                            // fieldController: phoneController,
                            keyboard: TextInputType.phone,
                            readonly: true,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          // CustomTextField(
                          //   suffixIcon: GestureDetector(
                          //       onTap: () {
                          //         setState(() {
                          //           obscurePassword = !obscurePassword;
                          //         });
                          //       },
                          //       child: obscurePassword
                          //           ? const Icon(Icons.visibility_off)
                          //           : const Icon(Icons.visibility)),
                          //   obscureText: obscurePassword,
                          //   prefixIcon: const Icon(Icons.password),
                          //   fieldController: passwordController,
                          //   fieldName: "Password",
                          //   hintName: " Password",
                          //   keyboard: TextInputType.visiblePassword,
                          //   maxLines: 1,
                          //   textInputAction: TextInputAction.done,
                          //   validator: (str) {
                          //     if (str!.isEmpty) {
                          //       return '* Is Required';
                          //     }
                          //     return null;
                          //   },
                          // ),
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
                            hintName: "Password",
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
                          CustomTextField(
                            prefixIcon: const Icon(Icons.people),
                            hintName: "Referral Code (Optional)",
                            fieldController: referralController,
                            keyboard: TextInputType.text,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 3.h),
                          Center(
                            child: SizedBox(
                                height: 50, //height of button
                                width: double.infinity, //width of button
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .lime[200], //background color of button
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      ApiService()
                                          .addAccount(context, data: data());
                                    }
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: FontTextStyle.poppinsS16W7BlackColor,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FormData data() {
    return FormData.fromMap({
      "referal_code": referralController.text.trim(),
      "phone": widget.mobileNumber,
      "password": passwordController.text.trim(),
      "profile_type": widget.userType,
      "token": mtoken,
    });
  }
}
