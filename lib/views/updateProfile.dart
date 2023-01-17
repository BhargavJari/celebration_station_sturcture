import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../dashboard/bottomNavBar/tabs/ourServices-1.dart';
import '../model/getAllbusineesType.dart';
import '../services/api_services.dart';
import '../services/shared_preference.dart';
import 'custom_widget/custom_text_field.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfile();
}

class _UpdateProfile extends State<UpdateProfile> {
  TextEditingController businessName = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController businessType = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController whatsappNo = TextEditingController();

  String? id = '';
  String? token = '';
  String? type = '';
  String? profileStatus = "";
  String selectedValue = "";
  List<dynamic> categoryItemList = [];
  String dropdowncategory = "";
  getAllBusinessType? gabt;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _getAllBusinessType({
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> formdata = ({});
      final response = await Dio().get(
        'https://celebrationstation.in/get_ajax/get_all_services/',
        queryParameters: formdata,
      );

      print("get  Api response data :- ");
      print(response.data);

      gabt = getAllBusinessType.fromJson(response.data);
      setState(() {
        gabt;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchLoginData();
    _getAllBusinessType(context: context);
  }

  String selectedBusinessType = 'Select Business Type';

  _fetchLoginData() async {
    setState(() async {
      id = await Preferances.getString("id");
      token = await Preferances.getString("token");
      type = await Preferances.getString("type");
      profileStatus = await Preferances.getString("PROFILE_STATUS");
      // id = (prefs.getString('id') ?? '');
      // token = (prefs.getString('token') ?? '');
      // type = (prefs.getString('type') ?? '');
      // profileStatus = (prefs.getString('PROFILE_STATUS') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('$id');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "asset/images/logo.png",
          height: 60,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Center(
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Enter Bussiness Name" + '$id',
                  fieldController: businessName,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }
                  }),
              const SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Enter Owner Name",
                  fieldController: ownerName,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }
                  }),
              const SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Select State",
                  fieldController: state,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }
                  }),
              const SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Select District",
                  fieldController: district,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }
                  }),
              const SizedBox(height: 15.0),
              //   DropdownButton<String>(
              //   value: selectedValue,
              //     hint: Text("Select Business Type"),
              //     items: categoryItemList.map<DropdownMenuItem<String>>((list){
              //       return DropdownMenuItem(
              //         child: Text(list),
              //       );
              //     },).toList(),
              //     onChanged: (value){
              //     setState(() {
              //       selectedValue = value as String;
              //     });
              //     }
              // ),
              Container(
                width: double.infinity,
                height: 58,
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: dropdowncategorybutton(),
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Enter Pincode",
                  fieldController: pinCode,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }else if (str.length != 6) {
                      return '* Pin code must be of 6 digit';
                    }
                  }),
              const SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Enter Address",
                  fieldController: address,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }
                  }),
              const SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "WhatsApp No",
                  fieldController: whatsappNo,
                  keyboard: TextInputType.phone,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }else if (str.length != 10) {
                      return '* Phone number must be of 6 digit';
                    }
                  }),
              const SizedBox(height: 15.0),
              Center(
                child: SizedBox(
                    height: 50, //height of button
                    width: double.infinity, //width of button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lime[200], //background color of button
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        ApiService().updateProfile(context, data: data());
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdowncategorybutton() {
    List<DropdownMenuItem<String>>? dropdownList = [];
    if (gabt != null && gabt?.users != null) {
      for (int i = 0; i < gabt!.users!.length; i++) {
        DropdownMenuItem<String> item = DropdownMenuItem<String>(
          child: Row(
            children: <Widget>[
              Text(gabt!.users![i].gASNAME!),
            ],
          ),
          value: gabt!.users![i].gASID!.toString(),
        );

        dropdownList.add(item);
      }
    }
    return DropdownButton<String>(
      value: dropdowncategory.isEmpty ? null : dropdowncategory,
      isExpanded: true,
      underline: Container(),
      hint: Text("${selectedBusinessType}"),
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
      ),
      borderRadius: BorderRadius.circular(19),
      focusColor: Colors.black,
      // Array list of items
      items: dropdownList,

      onChanged: (newValue) {
        setState(() {
          print("newvalue:=$newValue");

          selectedBusinessType = newValue!;
          print("selectedRefer:=$selectedBusinessType");
          // dropdowncategory = newValue!;
        });
      },
    );
  }

  FormData data() {
    return FormData.fromMap({
      "business_name": businessName.text.toString(),
      "owner_name": ownerName.text.toString(),
      "state": state.text.toString(),
      "district": district.text.toString(),
      "business_type": selectedBusinessType,
      "pincode": pinCode.text.toString(),
      "address": address.text.toString(),
      "whats_app": whatsappNo.text.toString(),
      "loginid": id,
      "status": '1',
    });
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
