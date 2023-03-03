import 'package:celebration_station_sturcture/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/colors_utils.dart';
import '../../Utils/fontFamily_utils.dart';
import '../../utils/loder.dart';
import '../custom_widget/custom_text_field.dart';
import 'otp_verification_screen.dart';

class SignUp extends StatefulWidget {
  final userType;
  const SignUp({Key? key, required this.userType}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("User Ty:- ${widget.userType}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: BackButton(
          color: ColorUtils.blackColor,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8.h),
              Image.asset(
                "asset/images/logo.png",
                scale: 2,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Sign Up",
                style: FontTextStyle.poppinsS24W7BlackColor,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5.h,
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
                height: 3.h,
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
                            data: data(), mobile: phone.text.trim()).then((value){
                          if (value?.count == 0) {
                            Loader.hideLoader();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpVerificationScreen(
                                      phoneNumber: "${phone.text}",status: "0",userType: widget.userType,
                                    )));
                          } else if (value?.count == 1) {
                            Loader.hideLoader();
                            Fluttertoast.showToast(
                              msg: 'Your number is already register please login',
                              backgroundColor: Colors.grey,
                            );
                          }
                        });
                      }
                    },
                    child: const Text("Send the code")),
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
