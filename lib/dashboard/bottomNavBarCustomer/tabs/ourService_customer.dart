import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/colors_utils.dart';
import '../../../Utils/fontFamily_utils.dart';
import '../../../services/shared_preference.dart';
import '../../../utils/loder.dart';
import '../../../views/custom_widget/dialogs/location_dialog.dart';
import '../../CustomDrawer.dart';
import '../../CustomDrawerCustomer.dart';
import '../bottom_nav_bar_customer.dart';
import '../../bottomNavBarCustomer/tabs/eventCalender_customer.dart';

class OurServiceCustomer extends StatefulWidget {
  const OurServiceCustomer({Key? key}) : super(key: key);

  @override
  State<OurServiceCustomer> createState() => _HomeState();
}

class _HomeState extends State<OurServiceCustomer> {
  List services = [];
  var cityName;
  var cityId;
  String? state, city, stateId;

  @override
  void initState() {
    super.initState();
    this.fetchServices();
    getDistrictName();
    callApi();
  }

  Future<void> callApi() async {
    state = await Preferances.getString("stateName");
    city = await Preferances.getString("cityName");
    stateId = await Preferances.getString("stateId");
    if (stateId == null) {
      stateId = "0";
    }
  }

  getDistrictName() async {
    Loader.showLoader();
    try {
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? cityid = await Preferances.getString("cityName");
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse(
            'https://celebrationstation.in/get_ajax/get_district_name/'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {
          'districtid': cityid == null ? " " :cityid.replaceAll('"', '').toString(),
        },
      );
      if (response.statusCode == 200) {
        var items = jsonDecode(response.body);
        cityName = items['district']['DISTRICT_NAME'];
        //Loader.hideLoader();
        Loader.hideLoader();
        /*print("City NAme = ${cityName}");*/
      } else {
        /*setState(() {
          getDateEvent = [];
        });*/
        Loader.hideLoader();
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
    // return getEvent;
  }

  fetchServices() async {
    String? id = await Preferances.getString("id");
    String? token = await Preferances.getString("token");
    String? type = await Preferances.getString("type");
    String? cityid = await Preferances.getString("cityName");
    Loader.showLoader();
    try {
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse('https://celebrationstation.in/get_ajax/get_all_services/'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi4qw',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {},
      );
      if (response.statusCode == 200) {
        var items = jsonDecode(response.body)['users'];
        setState(() {
          services = items;
          cityId = cityid;
        });
        Loader.hideLoader();
        print("Services Fetched");
        //print("CityIDD==${cityId}");
      } else {
        setState(() {
          services = [];
        });
        Loader.hideLoader();
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawerCustomer(),
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
        leading: Builder(builder: (context) {
          return IconButton(
            iconSize: 30,
            icon: Icon(
              Icons.menu,
              color: Colors.grey,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: [
          IconButton(
              iconSize: 30,
              onPressed: () {
                LocationDailog.show(context).then((value) {
                  setState(() async {
                    state = value.state;
                    city = value.city;
                    stateId = value.stateId;
                  });
                });
              },
              icon: Icon(
                Icons.location_on,
                color: ColorUtils.grey,
              )),
              state != null && city != null ?
                Container(
                  margin: EdgeInsets.only(top: 3.5.h, right: 3.w),
                  child: Text(
                      "${cityName == null ? "" : cityName}",
                    style: FontTextStyle.poppinsS14HintColor
              ),
                )
              : SizedBox.shrink()
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Text(
                "Our Services",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Center(
              child: getBody(),
            ),
          ],
        ),
      ),

      /*Expanded(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Center(
              child: Text(
                "Our Services",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ),
      ),*/
    );
  }

  Widget getBody() {
    return SizedBox(
      height: 550,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
          itemCount: services.length,
          itemBuilder: (context, index) {
            return getCard(services[index]);
          }),
    );
  }

  Widget getCard(index) {
    var serviceName = index['GAS_NAME'];
    var serviceId = index['GAS_ID'];
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
          height: 50, //height of button
          width: double.infinity, //width of button
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lime[200], //background color of button
              elevation: 3,
              shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            onPressed: () {
              if(cityId.toString() == "null"){
                LocationDailog.show(context).then((value) {
                  setState(() async {
                    state = value.state;
                    city = value.city;
                    stateId = value.stateId;
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        BottomNavBarCustomer(index: 1)), (Route<dynamic> route) => false);
                  });
                });
                Fluttertoast.showToast(
                  msg: 'Please set your State and City first',
                  //msg: cityId.toString(),
                  backgroundColor: Colors.grey,
                );
              }else{
                //LocationDailog.show(context);
                /*Fluttertoast.showToast(
                  //msg: 'Please set your State and City first',
                  msg: cityId.toString(),
                  backgroundColor: Colors.grey,
                );*/
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventCalendarCustomerScreen(serviceId: serviceId)));
              }
            },
            child: Text(serviceName.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black
              ),
            ),
          )
      ),
    );
  }

}

