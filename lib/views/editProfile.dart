import 'package:celebration_station_sturcture/Utils/colors_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/GetAllProfileModel.dart';
import '../model/GetDistrict.dart';
import '../model/GetState.dart';
import '../model/getAllbusineesType.dart';
import '../services/api_services.dart';
import '../services/shared_preference.dart';
import 'custom_widget/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  final String userId;
  final String token;
  final String type;

  const EditProfile({Key? key,required this.userId,required this.token,required this.type}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
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
  List<dynamic> StateItemList = [];
  String dropdownState = "";

  String selectedDistrictValue = "";
  List<dynamic> DistrictItemList = [];
  String dropdownDistrict = "";

  String selectedStateRefer = "";

  getAllBusinessType? gabt;
  getState? gs;
  getDistrict? gd;
  ProfileDetails? profileDetails;


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

  Future<void> _getAllStates({
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> formdata = ({});
      final response = await Dio().post(
        'https://celebrationstation.in/get_ajax/get_all_states/',
        options: Options(headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': widget.userId,
          'Authorization': widget.token,
          'type': widget.type
        }),
        queryParameters: formdata,
      );

      print("get State  Api response data :- ");
      print(response.data);

      gs = getState.fromJson(response.data);
      setState(() {
        gs;

      }


      );
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getAllDistrict({
    required BuildContext context,required FormData? data
  }) async {
    try {
      Map<String, dynamic> formdata = ({});


      final response = await Dio().post(
        'https://celebrationstation.in/get_ajax/get_all_district/',
        // options: Options(headers: {
        //   'Client-Service': 'frontend-client',
        //   'Auth-Key': 'simplerestapi',
        //   'User-ID': id,
        //   'Authorization': token,
        //   'type': type
        // }),
        data: data,
        queryParameters: formdata,
      );

      print("get District  Api response data :- ");
      print(response.data);

      gd = getDistrict.fromJson(response.data);
      setState(() {
        gd;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    ApiService().getProfileRecord(context).then((value) {
      if(value!.message == "ok"){
        print("hhiii");
        setState(() {
          profileDetails = value.detail!;
          businessName.text = value.detail!.bRANCHFIRMNAME!;
          ownerName.text = value.detail!.bRANCHNAME!;
          selectedState = value.detail!.bRANCHSTATE!;
          selectedDistrict = value.detail!.bRANCHCITY!;
          selectedBusinessType = value.detail!.bRANCHBUSINESSTYPE!;
          pinCode.text = value.detail!.bRANCHPINCODE!;
          address.text = value.detail!.bRANCHADDRESS!;
          whatsappNo.text = value.detail!.bRANCHCONTACT!;
          emailid.text = value.detail!.bRANCHEMAIL!;
        });
        print('model:$profileDetails');
      }
    });
    _getAllBusinessType(context: context);
    _getAllStates(context: context);
    //_getAllDistrict(context: context);

  }

  String selectedBusinessType = 'Select Business Type';
  String selectedState = 'Select State';
  String selectedDistrict = 'Select District';



  // _fetchLoginData() async {
  //   id = await Preferances.getString("id");
  //   token = await Preferances.getString("token");
  //   type = await Preferances.getString("type");
  //   profileStatus = await Preferances.getString("PROFILE_STATUS");
  //   print("id here my :=$id");
  // }

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
        leading: BackButton(color: ColorUtils.blackColor),
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
              const Center(
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                  hintName: "Enter Bussiness Name",
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
              const SizedBox(height: 15.0),
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
              const SizedBox(height: 15.0),
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
              const SizedBox(height: 15.0),
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
                      onPressed: () async {
                        FormData data() {
                          print(widget.userId);
                          return FormData.fromMap({
                            "business_name": businessName.text.toString(),
                            "owner_name": ownerName.text.toString(),
                            "state": selectedStateName,
                            "district": selectedCityName,
                            "business_type": selectedBusinessType,
                            "pincode": pinCode.text.toString(),
                            "address": address.text.toString(),
                            "whats_app": whatsappNo.text.toString(),
                            "loginid": widget.userId.toString(),
                            "email": emailid.text.toString(),
                          });
                        }
                        print(data);
                        await ApiService().updateProfile(context, data: data());
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
      hint: Text("$selectedBusinessType"),
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
  String? stateName;
  String? cityName;
  String? selectedCityName;
  String? selectedStateName;

  Widget dropdownstatebutton() {
    List<DropdownMenuItem<String>>? dropdownstateList = [];
    if (gs != null && gs?.states != null) {
      for (int i = 0; i < gs!.states!.length; i++) {
        // print("hello ${gs!.states![i].sTATENAME!}");
        DropdownMenuItem<String> item = DropdownMenuItem<String>(
          value: gs!.states![i].sTATEID!.toString(),
          child: Row(
            children: <Widget>[
              Text(gs!.states![i].sTATENAME!),
            ],
          ),
        );

        dropdownstateList.add(item);
      }
    }
    return DropdownButton<String>(
      value: stateName,
      isExpanded: true,
      underline: Container(),

      hint: Text("$selectedState"),
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
      ),
      borderRadius: BorderRadius.circular(19),
      focusColor: Colors.black,
      // Array list of items
      items: dropdownstateList,

      onChanged: (newValue) async {
        // setState(() async {
        //   // print("newvalue:=$newValue");
        //   //
        //   // selectedState = newValue!;
        //   // selectedStateRefer = newValue;
        //   // print("selectedRefer:=$selectedState");
        //
        //   ////////
        //
        // });
        print(newValue.toString() + 'DDD');
        selectedStateName = newValue;
        print("selectedStateName:=${selectedStateName}");
        DistrictItemList = [];
        cityName = null;
        stateName = newValue;
        FormData data() {
          return FormData.fromMap({"stateid": newValue,});
        }
        await _getAllDistrict(context: context,data: data());
        print("${newValue}");
        setState(() {});
        cityName = null;
        print("selectedStateName :- ${stateName}");
      },
    );
  }

  Widget dropdowndistrictbutton() {
    List<DropdownMenuItem<String>>? dropdowndistrictList = [];
    if (gd != null && gd?.district != null) {
      for (int i = 0; i < gd!.district!.length; i++) {
        DropdownMenuItem<String> item = DropdownMenuItem<String>(
          child: Row(
            children: <Widget>[
              Text(gd!.district![i].dISTRICTNAME!),
            ],
          ),
          value: gd!.district![i].dISTRICTID!.toString(),
        );

        dropdowndistrictList.add(item);
      }
    }
    return DropdownButton<String>(
      value: cityName,
      isExpanded: true,
      underline: Container(),
      hint: Text("$selectedDistrict"),
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
      ),
      borderRadius: BorderRadius.circular(19),
      focusColor: Colors.black,
      // Array list of items
      items: dropdowndistrictList,

      onChanged: (newValue) {
        setState(() {

          cityName = newValue;
          setState(() {});
          print("selectedCityName :- ${newValue}");
          setState(() {
            selectedCityName = newValue!;
          });
        });
      },
    );
  }
}
