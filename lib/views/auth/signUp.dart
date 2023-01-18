import 'package:flutter/material.dart';

import '../custom_widget/custom_text_field.dart';
import 'otp_verification_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

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
                'img/celebrationstation.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(25.0)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Center(
                      child: Text("+91"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
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
                  ),
                ],
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //// first check number register or not api call
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpVerificationScreen(
                                      phoneNumber: "${phone.text.trim()}",
                                    )));
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
}
