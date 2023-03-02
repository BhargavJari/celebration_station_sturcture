import 'dart:async';

import 'package:celebration_station_sturcture/views/auth/registration_screen.dart';
import 'package:celebration_station_sturcture/views/auth/reset_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../model/auth_result.dart';
import '../../services/functions.dart';
import '../../utils/loder.dart';
import 'login_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String status;
  final String? userType;
  const OtpVerificationScreen({Key? key, required this.phoneNumber,required this.status, this.userType})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController _controller = TextEditingController(text: "");
  int pinLength = 6;
  int _seconds = -1;
  Timer? _timer;
  String _verificationId = '';

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await sendCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/images/logo.png",
                scale: 2,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter 6 digit code sent to your phone number ${widget.phoneNumber}',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: PinCodeTextField(
                  autofocus: false,
                  controller: _controller,
                  hideCharacter: false,
                  highlight: false,
                  highlightColor: Theme.of(context).cardColor,
                  defaultBorderColor: Theme.of(context).cardColor,
                  hasTextBorderColor: Theme.of(context).cardColor,
                  highlightPinBoxColor: Theme.of(context).cardColor,
                  pinBoxColor: Theme.of(context).cardColor,
                  maxLength: pinLength,
                  onDone: (text) {
                    _controller.text = text;
                  },
                  pinBoxWidth: 45,
                  pinBoxHeight: 55,
                  hasUnderline: false,
                  pinBoxRadius: 10,
                  wrapAlignment: WrapAlignment.spaceAround,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 22.0),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                  highlightAnimationBeginColor: Theme.of(context).cardColor,
                  highlightAnimationEndColor: Theme.of(context).cardColor,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lime,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                     if(_controller.text == ""){

                       CommonFunctions.toast("please enter OTP !!");
                     }else{
                       print("co_controller.text:=${_controller.text}");
                       AuthResult result = await _verify(_controller.text);
                       if (result.status) {
                         //Navigator.of(context).pop();
                       }
                     }
                    },
                    child: Text("Verify")),
              ),
              SizedBox(height: 40),
              if (_timer?.isActive ?? false)
                Text(
                  _seconds.toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              else if (_seconds != -1)
                GestureDetector(
                  onTap: () async => sendCode(),
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${"+91"}${widget.phoneNumber}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'web-context-cancelled') {
          throw e.message ?? 'Error';
        } else {
          throw e.message ?? 'Error';
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        setState(() {});
        _startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        print("verificationId:=$verificationId");
        print("_verificationId_verificationId:=$_verificationId");

        setState(() {});
      },
    );
  }

  Future _verify(String smsCode) async {
    Loader.showLoader();
    try {
      final PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      if(widget.status=="0"){
        CommonFunctions.toast("Register successfully !!");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegistrationScrenn(
                  mobileNumber: widget.phoneNumber,
                  userType: widget.userType,
                )));
      }else{
        CommonFunctions.toast("otp verify successfully !!");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>ResetPasswordScreen(
                  mobileNumber: widget.phoneNumber,
                )));
      }

      Loader.hideLoader();
      return AuthResult(status: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      Loader.hideLoader();
      debugPrint('inside catch : ${e.message}');
      AuthResult result = AuthResult(status: false, message: e.message);

      switch (e.code) {
        case 'invalid-verification-code':
          result.message = 'Your SMS code is invalid.';
          break;
        case 'provider-already-linked':
          result.message = 'This phone number is already registered.';
          break;
        default:
      }
      if (result.message != null) {
        _controller.clear();
        CommonFunctions.toast(result.message!);
      }
      return AuthResult(status: false);
    }
  }
}
