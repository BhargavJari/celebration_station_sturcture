import 'package:celebration_station_sturcture/services/api_services.dart';
import 'package:celebration_station_sturcture/views/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../custom_widget/custom_text_field.dart';
import '../ourService.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String mobileNumber;
  const ResetPasswordScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool? check1 = false;
  TextEditingController _password = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                Image.asset("asset/images/logo.png",
                  scale: 2,),
                SizedBox(height: 30),
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
                      children: <TextSpan>[
                        TextSpan(text: 'Reset Password',style: TextStyle(letterSpacing: 2.0)),

                      ]
                  ),
                ),
                const SizedBox(height: 25.0),
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
                  fieldController: _password,
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
                const SizedBox(height: 15.0),
                CustomTextField(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                      child: obscureConfirmPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  obscureText: obscureConfirmPassword,
                  prefixIcon: const Icon(Icons.password),
                  fieldName: "Password",
                  hintName: "Confirm Password",
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
                SizedBox(height: 25.0),
                Center(
                  child: SizedBox(
                      height:50, //height of button
                      width:double.infinity, //width of button
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lime[200], //background color of button
                          elevation: 3,
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        onPressed: (){
                          // if(_formKey.currentState!.validate()) {
                          //
                          // }
                          ApiService().resetPassword(
                              context, data: data());
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()),
                          );
                        },
                        child: const Text("Reset Password",
                          style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  FormData data() {
    return FormData.fromMap({"phone": widget.mobileNumber,"password":_password.text.trim()});
  }
}
