import 'dart:convert';

import 'package:celebration_station_sturcture/dashboard/CustomDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';

import '../../../services/shared_preference.dart';
import '../../../utils/loder.dart';

class OurServices extends StatefulWidget {
  const OurServices({Key? key}) : super(key: key);

  @override
  State<OurServices> createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  List? images = [];
  bool isLoading = false;
  List getEvent = [];
  var year = DateFormat('yyyy').format(DateTime.now());
  var month = DateFormat('MM').format(DateTime.now());

  initState(){
    super.initState();
    getImages();
    getBookingDetails();
  }

  Future<void> getImages() async{
    setState(() {
      isLoading = true;
    });
    try{
      Loader.showLoader();
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response= await post(
        Uri.parse('https://celebrationstation.in/get_ajax/get_slidder'),
        headers: {
          'Client-Service':'frontend-client',
          'Auth-Key':'simplerestapi',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {},
      );
      if(response.statusCode==200){

        var items = jsonDecode(response.body)['detail'];
        setState(() {
          images = items;
          isLoading = false;
        });
        Loader.hideLoader();
        print("Images Fetched");
      }else{
        setState(() {
          images = [];
          isLoading = false;
        });
        Loader.hideLoader();
        print("Error");
      }
    }catch(e){
      Loader.hideLoader();
      print(e.toString());
    }
  }

  getBookingDetails() async{
    setState(() {
      isLoading = true;
    });
    try{
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response= await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse('https://celebrationstation.in/get_ajax/get_booking_month_details'),
        headers: {
          'Client-Service':'frontend-client',
          'Auth-Key':'simplerestapi',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {
          'year' : year,
          'loginid': id?.replaceAll('"', '').replaceAll('"', '').toString(),
          'month' : month
        },
      );
      if(response.statusCode==200){
        var items = jsonDecode(response.body)['\$booking'];
        setState(() {
          getEvent = items;
        });
        print(getEvent);
      }else{
        setState(() {
          getEvent = [];
        });
        print("Error");
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
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
        leading: Builder(
          builder: (context) {
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
          }
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.location,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Carousel(
                images:[
                  for(var i=0; i<images!.length ; i++)...[
                    Image.network('https://celebrationstation.in/uploads/'+images![i]['IMAGE_URL'])
                  ]
                ],
                //images.map((e) => Image.network('https://celebrationstation.in/uploads/'+images[e]['IMAGE_URL'])).toList(),
                showIndicator: true,
                autoplay: true,
                autoplayDuration: Duration(seconds: 2),
                borderRadius: false,
                moveIndicatorFromBottom: 180.0,
                overlayShadow: true,
                overlayShadowColors: Colors.black,
                overlayShadowSize: 0.4,
                indicatorBgPadding: 5,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Our Services",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: SizedBox(
                  height:50, //height of button
                  width:double.infinity, //width of button
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lime[200], //background color of button
                      elevation: 3,
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    onPressed: (){},
                    child: const Text("Add Booking",
                      style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black
                      ),
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  height:50, //height of button
                  width:double.infinity, //width of button
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lime[200], //background color of button
                      elevation: 3,
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    onPressed: (){

                    },
                    child: Text("Confirm Booking : ${getEvent.length}",
                      style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black
                      ),
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  height:50, //height of button
                  width:double.infinity, //width of button
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lime[200], //background color of button
                      elevation: 3,
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    onPressed: (){
                    },
                    child: const Text("Pending Booking : 0",
                      style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black
                      ),
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  height:50, //height of button
                  width:double.infinity, //width of button
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lime[200], //background color of button
                      elevation: 3,
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    onPressed: (){
                    },
                    child: const Text("Canceled Booking : 20",
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
    );
  }
}
