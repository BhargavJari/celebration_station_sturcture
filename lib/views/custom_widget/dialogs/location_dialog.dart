import 'package:celebration_station_sturcture/dashboard/bottomNavBarCustomer/bottom_nav_bar_customer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Utils/fontFamily_utils.dart';
import '../../../model/GetDistrict.dart';
import '../../../model/GetState.dart';
import '../../../services/shared_preference.dart';
import '../../../utils/screen_utils.dart';
import '../../../utils/validation_mixin.dart';

class LocationDailog extends StatefulWidget {
  LocationDailog({
    super.key,
  });

  static Future show(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LocationDailog(),
    );
  }

  @override
  State<LocationDailog> createState() => _LocationDailogState();
}

class _LocationDailogState extends State<LocationDailog> with ValidationMixin {
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  SetLocationModel setLocationModel = SetLocationModel();

  List<dynamic> DistrictItemList = [];
  String selectedState = 'Select State';
  String selectedDistrict = 'Select District';
  getState? gs;
  getDistrict? gd;
  String dropdowncategory = '';

  Future<void> _getAllStates({
    required BuildContext context,
  }) async {
    try {
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      Map<String, dynamic> formdata = ({});
      final response = await Dio().post(
        'https://celebrationstation.in/get_ajax/get_all_states/',
        options: Options(headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': id,
          'Authorization': token,
          'type': type
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllStates(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Dialog(
          insetPadding: const EdgeInsets.all(20),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: ScreenUtil().screenHeight / 1.6,
            width: ScreenUtil().screenWidth / 1.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 28),
                  Text("Set location", style: FontTextStyle.poppinsS20W7BlackColor),
                  SizedBox(height: 14),
                  Text("Please select state and city and set your location",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: FontTextStyle.poppinsS14HintColor
                  ),
                  SizedBox(height: 28),
                  Text("Select State", style: FontTextStyle.poppinsS12W7BlackColor),
                  SizedBox(height: 8),
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
                  SizedBox(height: 14),
                  Text("Select City", style: FontTextStyle.poppinsS12W7BlackColor),
                  SizedBox(height: 8),
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
                  SizedBox(height: 18),
                  SizedBox(
                      height: 50, //height of button
                      width: double.infinity, //width of button
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                          Colors.lime[200], //background color of button
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          setLocationModel.state = stateName;
                          setLocationModel.city = selectedCityName;
                          setLocationModel.stateId = selectedStateName;
                          Navigator.pop(context, setLocationModel);
                          Preferances.setString("stateName", setLocationModel.state);
                          Preferances.setString("stateId", setLocationModel.stateId);
                          Preferances.setString("cityName", setLocationModel.city);
                          Navigator.pushAndRemoveUntil(context , MaterialPageRoute(builder: (context) => BottomNavBarCustomer(index: 1)), (route) => false);
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
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



class SetLocationModel {
  SetLocationModel({
    this.state,
    this.city,
    this.stateId,
  });
  String? state;
  String? city;
  String? stateId;
}
