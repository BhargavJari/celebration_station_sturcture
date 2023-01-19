import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/GetDistrict.dart';
import '../model/GetState.dart';
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
  TextEditingController emailid = TextEditingController();

  String? id = '';
  String? token = '';
  String? type = '';
  String? profileStatus = "";
  String selectedValue = "";
  List<dynamic> categoryItemList = [];
  String dropdowncategory = "";

  String selectedStateValue = "";
  List<dynamic> stateItemList = [];
  String dropdownstate = "";

  String selectedDistrictValue = "";
  List<dynamic> districtItemList = [];
  String dropdowndistrict = "";

  getAllBusinessType? gabt;
  getState? gs;
  getDistrict? gd;

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

  Future<void> _getAllState({
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> formdata = ({});
      final response = await Dio().post(
        'https://celebrationstation.in/get_ajax/get_states/',
        queryParameters: formdata,
      );

      print("get Api response data State:- ");
      print(response.data);

      gs = getState.fromJson(response.data);
      setState(() {
        gs;
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
    _getAllState(context: context);
  }

  String selectedBusinessType = 'Select Business Type';
  String selectedState = 'Select State';
  String selectedDistrict = 'Select District';

  _fetchLoginData() async {
    setState(() async {
      id = await Preferances.getString("id");
      token = await Preferances.getString("token");
      type = await Preferances.getString("type");
      profileStatus = await Preferances.getString("PROFILE_STATUS");
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
        title: Image.asset(
          "asset/images/logo.png",
          height: 60,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Center(
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
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
              SizedBox(height: 15.0),
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
              SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Email id",
                  fieldController: emailid,
                  keyboard: TextInputType.emailAddress,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }
                  }),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 58,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: dropdownstatebutton(),
              ),
              // CustomTextField(
              //     hintName: "Select State",
              //     fieldController: state,
              //     maxLines: 1,
              //     textInputAction: TextInputAction.next,
              //     validator: (str) {
              //       if (str!.isEmpty) {
              //         return '* Is Required';
              //       }
              //     }),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 58,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: dropdowndistrictbutton(),
              ),
              // CustomTextField(
              //     hintName: "Select District",
              //     fieldController: district,
              //     maxLines: 1,
              //     textInputAction: TextInputAction.next,
              //     validator: (str) {
              //       if (str!.isEmpty) {
              //         return '* Is Required';
              //       }
              //     }),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 58,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: dropdowncategorybutton(),
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Enter Pincode",
                  fieldController: pinCode,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  keyboard: TextInputType.number,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return '* Is Required';
                    }else if (str.length != 6) {
                      return '* Pin code must be of 6 digit';
                    }
                  }),
              SizedBox(height: 15.0),
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
              SizedBox(height: 15.0),
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
                      return '* Phone number must be of 10 digit';
                    }
                  }),
              SizedBox(height: 15.0),
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
                            "loginid": id!.replaceAll('"', '').replaceAll('"', '').toString(),
                            "email": emailid.text.toString(),
                          });
                        }
                        // Map<String,dynamic> data = {
                        //   'business_name': businessName.text.trim(),
                        //   'owner_name': ownerName.text.trim(),
                        //   'state': state.text.trim(),
                        //   'district': district.text.trim(),
                        //   'business_type': selectedBusinessType,
                        //   'pincode': pinCode.text.trim(),
                        //   'address': address.text.trim(),
                        //   'whats_app': whatsappNo.text.trim(),
                        //   'loginid': id!.replaceAll('"', '').replaceAll('"', '').toString(),
                        // };
                        print(data);
                      ApiService().updateProfile(context, data: data());
                      },
                      child: Text(
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

  Widget dropdownstatebutton() {
    List<DropdownMenuItem<String>>? dropdownStateList = [];
    if (gs != null) {
      for (int i = 0; i < gs!.sTATENAME!.length; i++) {
        DropdownMenuItem<String> item = DropdownMenuItem<String>(
          child: Row(
            children: <Widget>[
              Text(gs!.sTATENAME![i]),
            ],
          ),
          value: gs!.sTATEID![i].toString(),
        );

        dropdownStateList.add(item);
      }
    }
    return DropdownButton<String>(
      value: dropdownstate.isEmpty ? null : dropdownstate,
      isExpanded: true,
      underline: Container(),
      hint: Text("${selectedState}"),
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
      ),
      borderRadius: BorderRadius.circular(19),
      focusColor: Colors.black,
      // Array list of items
      items: dropdownStateList,

      onChanged: (newValue) {
        setState(() {
          print("newvalue:=$newValue");

          selectedState = newValue!;
          print("selectedRefer:=$selectedState");
          // dropdowncategory = newValue!;
        });
      },
    );
  }

  Widget dropdowndistrictbutton() {
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
}

// InputDecoration buildInputDecoration(String hinttext) {
//   return InputDecoration(
//     hintText: hinttext,
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(25.0),
//         borderSide: const BorderSide(color: Colors.green, width: 1.5)),
//     border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(25.0),
//         borderSide: const BorderSide(color: Colors.lime, width: 1.5)),
//     enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(25.0),
//         borderSide: const BorderSide(color: Colors.black, width: 1.5)),
//   );
// }
