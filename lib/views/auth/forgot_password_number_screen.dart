

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/api_services.dart';
import '../../utils/loder.dart';
import '../custom_widget/custom_text_field.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordNumberScreen extends StatefulWidget {
  const ForgotPasswordNumberScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordNumberScreen> createState() => _ForgotPasswordNumberScreenState();

}

class _ForgotPasswordNumberScreenState extends State<ForgotPasswordNumberScreen> {
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "asset/images/logo.png",
                    scale: 2,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           border: Border.all(color: Colors.black, width: 1.5),
                  //           borderRadius: BorderRadius.circular(25.0)),
                  //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  //       child: Center(
                  //         child: Text("+91"),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       child: CustomTextField(
                  //         hintName: "Enter phone no.",
                  //         fieldController: phone,
                  //         keyboard: TextInputType.phone,
                  //         validator: (value) {
                  //           if (value!.isEmpty) {
                  //             return 'Please enter mobile number ';
                  //           } else if (value.length != 10) {
                  //             return 'Mobile Number must be of 10 digit';
                  //           } else {
                  //             return null;
                  //           }
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  CustomTextField(
                    hintName: "Enter phone no.",
                    fieldController: phone,
                    keyboard: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter mobile number ';
                      } else if (value.length != 10) {
                        return 'Mobile Number must be of 10 digit';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // CustomButton(
                  //   onTap: () async{
                  //     if (_formKey.currentState!.validate()) {
                  //       ApiService().mobileVerify(context,
                  //           data: data(), mobile: "${phone.text.trim()}");
                  //     }
                  //   },
                  //   buttonText: "set the code",
                  //   height: 5.h,
                  //
                  //   textStyle: FontTextStyle.poppinsS14W4WhiteColor,
                  // ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lime,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ApiService().mobileVerify(context,
                                data: data(), mobile: "${phone.text.trim()}").then((value) {
                                  if (value?.count == 1) {
                                    Loader.hideLoader();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OtpVerificationScreen(
                                                  phoneNumber: "${phone.text}",status: "1",
                                                )));
                                  } else if (value?.count == 0) {
                                    Loader.hideLoader();
                                    Fluttertoast.showToast(
                                      msg: 'Your number is not registered ...',
                                      backgroundColor: Colors.grey,
                                    );
                                  }
                            });


                          }
                        },
                        child: Text("Send the code")),
                  )
                ],
              ),
            )),
      ),
    );
  }

  FormData data() {
    return FormData.fromMap({
      "mobile": phone.text.trim(),
    });
  }
}
