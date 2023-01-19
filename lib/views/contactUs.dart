import 'dart:convert';
import 'package:celebration_station_sturcture/Utils/colors_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../services/api_services.dart';
import 'custom_widget/custom_text_field.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUs();
}

class _ContactUs extends State<ContactUs> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _message = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String id = '';
  String token = '';
  String type = '';

  //   void addEnquiry(
  //     String cusName,
  //     String cusPhone,
  //     String cusSubject,
  //     String cusMessage
  //     ) async {
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse('https://celebrationstation.in/post_ajax/add_enquiry/'),
  //       headers: {
  //         'Client-Service': 'frontend-client',
  //         'Auth-Key': 'simplerestapi',
  //         'User-ID': id,
  //         'Authorization': token,
  //         'type': type
  //       },
  //       body: {
  //         'name': cusName,
  //         'phone': cusPhone,
  //         'subject': cusSubject  ,
  //         'message': cusMessage,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body.toString());
  //       print(data);
  //       print('Add enquiry');
  //       _name.clear();
  //       _phone.clear();
  //       _subject.clear();
  //       _message.clear();
  //     } else {
  //       var data = jsonDecode(response.body.toString());
  //       print(data);
  //       print('FAILED');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchLoginData();
  }

  _fetchLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('id') ?? '');
      token = (prefs.getString('token') ?? '');
      type = (prefs.getString('type') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title:  Image.asset(
          "asset/images/logo.png",
          height: 60,
        ),
        leading: BackButton(color: ColorUtils.blackColor),
        actions: [
          IconButton(
            iconSize: 30.0,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: ()
            {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
            },
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 25),
                const Text(
                    "Contact Us",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      SizedBox(height: 25.0),
                      CustomTextField(
                          hintName: "Name",
                          fieldController: _name,
                          keyboard: TextInputType.text,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          validator: (str) {
                            if (str!.isEmpty) {
                              return '* Is Required';
                            }
                          }),
                      SizedBox(height: 2.h),
                      CustomTextField(
                          hintName: "Phone Number",
                          fieldController: _phone,
                          keyboard: TextInputType.phone,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          validator: (str) {
                            if (str!.isEmpty) {
                              return '* Is Required';
                            }else if (str.length != 10) {
                              return '* Phone number must be of 10 digit';
                            }
                          }),
                      SizedBox(height: 2.h),
                      CustomTextField(
                          hintName: "Subject",
                          fieldController: _subject,
                          keyboard: TextInputType.text,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          validator: (str) {
                            if (str!.isEmpty) {
                              return '* Is Required';
                            }
                          }),
                      SizedBox(height: 2.h),
                      CustomTextField(
                          hintName: "Message",
                          fieldController: _message,
                          keyboard: TextInputType.text,
                          maxLines: 7,
                          textInputAction: TextInputAction.done,
                          validator: (str) {
                            if (str!.isEmpty) {
                              return '* Is Required';
                            }
                          }),
                      SizedBox(height: 3.h),
                      SizedBox(
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
                              if(_formKey.currentState!.validate()) {
                                ApiService().addEnquiry(
                                    context, data: data());
                              }
                            },
                            child: Text("SUBMIT",
                              style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black
                              ),
                            ),
                          )
                      ),
                    ],
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
    return FormData.fromMap({"name": _name.text.trim(),"phone":_phone.text.trim(),"subject":_subject.text.trim(),"message":_message.text.trim()});
  }
}

InputDecoration buildInputDecoration(String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.green, width: 1.5)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.lime, width: 1.5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.black, width: 1.5)),
  );
}
