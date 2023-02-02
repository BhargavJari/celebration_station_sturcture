import 'dart:convert';
import 'dart:isolate';
import 'package:celebration_station_sturcture/Utils/colors_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../main.dart';
import '../../../services/api_services.dart';
import '../../../services/shared_preference.dart';
import '../../../utils/loder.dart';
import '../../../views/auth/login_screen.dart';
import '../../../views/custom_widget/custom_text_field.dart';
import '../../CustomDrawer.dart';

class BookingList extends StatefulWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {

  List getEvent = [];
  bool isLoading = false;
  var year = DateFormat('yyyy').format(DateTime.now());
  var month = DateFormat('MM').format(DateTime.now());
  final cancelMessageController = TextEditingController();
  final receiveController = TextEditingController();
  final descriptionController = TextEditingController();
   String bid='0';

  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/launcher_icon',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    getBookingDetails();
  }

  getBookingDetails() async{
    Loader.showLoader();
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
          'loginid':id?.replaceAll('"', '').replaceAll('"', '').toString(),
          'month' : month
        },
      );
      if(response.statusCode==200){
        var items = jsonDecode(response.body)['\$booking'];
        setState(() {
          getEvent = items;
        });
        Loader.hideLoader();
        print("Booking List Fetched");
      }else{
        setState(() {
          getEvent = [];
        });
        Loader.hideLoader();
        print("Error");
      }
    }catch(e){
      print(e.toString());
    }
  }

  receivePayment() async{
    Loader.showLoader();
    try{
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response= await post(
        Uri.parse('https://celebrationstation.in/post_ajax/update_receive_payment'),
        // headers: {
        //   'Client-Service':'frontend-client',
        //   'Auth-Key':'simplerestapi',
        //   'User-ID': id.toString(),
        //   'token': token.toString(),
        //   'type': type.toString()
        // },
        body: {
          'amount' : receiveController.text,
          'desc' : descriptionController.text,
          'loginid':id?.replaceAll('"', '').replaceAll('"', '').toString(),
          'bookingid' :bid,
        },
      );
      if(response.statusCode==200){
        print('hi payment');
        Loader.hideLoader();
        Fluttertoast.showToast(msg: 'payment received');
        flutterLocalNotificationsPlugin.show(
            0,
            "Payment Received",
            "Your payment received",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    importance: Importance.high,
                    color: ColorUtils.orange,
                    playSound: true,
                    icon: '@mipmap/launcher_icon')));
      }else{
        Loader.hideLoader();
        print("Error");
      }
    }catch(e){
      print(e.toString());
    }
  }

  void cancelBooking (String bookingDate, String message, String bookingId) async{
    try{
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response= await post(
        Uri.parse('https://celebrationstation.in/post_ajax/cancelled_booking'),
        headers: {
          'Client-Service':'frontend-client',
          'Auth-Key':'simplerestapi',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {
          'booking_date': bookingDate,
          'loginid':id?.replaceAll('"', '').replaceAll('"', '').toString(),
          'message': message,
          'booking_id': bookingId,
        },
      );

      if(response.statusCode==200){
        var data = json.decode(response.body);
        print(data);
        Fluttertoast.showToast(
          msg: 'Booking Cancelled',
          backgroundColor: Colors.grey,
        );
        flutterLocalNotificationsPlugin.show(
            0,
            "Booking canceled",
            "Your booking cancelled of ${bookingDate}",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    importance: Importance.high,
                    color: ColorUtils.orange,
                    playSound: true,
                    icon: '@mipmap/launcher_icon')));
        getBookingDetails();
      }else{
        var data = json.decode(response.body.toString());
        print(data);
        print('FAILED');
      }
    }catch(e){
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
              CupertinoIcons.bell,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body:Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Text(
                "Booking List",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.pink.shade50),
                    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade50),
                    headingRowHeight: 80,
                    border: TableBorder.all(width: 1),
                    columnSpacing: 20,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Date',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Total Amount',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Advance',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Refer By',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Pay Now',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(getEvent.length, (index){
                      setState(() {
                       bid=getEvent[index]['CBD_BOOKING_ID'];
                      });

                      return DataRow(cells: [
                        DataCell(SizedBox(width: 75, child: Text(getEvent[index]['CBD_BOOKING_DATE']))),
                        DataCell(Center(child: Text(getEvent[index]['CBD_BOOKING_AMOUNT']))),
                        DataCell(Center(child: Text(getEvent[index]['CBD_BOOKING_ADVANCE']))),

                        DataCell(Center(child: Text(getEvent[index]['CBD_MALE_NAME']))),
                        DataCell(Center(
                            child: IconButton(
                                onPressed: () {
                                  _showReceiveEventDialog(getEvent[index]['CBD_BOOKING_DATE'], getEvent[index]['CBD_ID']);
                                },
                                icon: Icon(Icons.payment_outlined, color: ColorUtils.green, size: 4.h,))
                          ),
                        ),
                        DataCell(Center(
                            child: IconButton(
                                onPressed: () {
                                  _showCancelEventDialog(getEvent[index]['CBD_BOOKING_DATE'], getEvent[index]['CBD_ID']);
                                },
                                icon: Icon(Icons.cancel, color: ColorUtils.redColor, size: 4.h,))
                        ),
                        ),
                      ]);
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showCancelEventDialog(String bookingDate, String bookingId) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Cancel Booking ?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  controller: cancelMessageController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Cancellation Reason',
                  )
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: const Text(
                    'No',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                    child: const Text(
                      'Yes',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    onPressed: ()async {
                      if(cancelMessageController.text.isEmpty){
                        Fluttertoast.showToast(msg: 'Enter Cancellation Reason!!');
                        return;
                      }else{
                        cancelBooking(bookingDate, cancelMessageController.text.toString(),bookingId);
                        getBookingDetails();
                      }
                      Navigator.pop(context);
                      cancelMessageController.clear();
                      setState(() {

                      });
                    }
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showReceiveEventDialog(String bookingDate, String bookingId) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Pay Pending Amount',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintName: "Enter Amount.",
                fieldController: receiveController,
                keyboard: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter mobile number ';
                  }
                },
              ),
              SizedBox(height: 2.h,),
              CustomTextField(
                hintName: "Enter Description.",
                fieldController: descriptionController,
                keyboard: TextInputType.text,
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  onPressed: () {
                    descriptionController.clear();
                    receiveController.clear();
                    Navigator.pop(context);},
                  child: const Text(
                    'No',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                    child: const Text(
                      'Yes',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    onPressed: ()async {
                      if(receiveController.text.isEmpty){
                        Fluttertoast.showToast(msg: 'Enter Amount!!');
                        return;
                      }else{
                        receivePayment();
                        getBookingDetails();
                      }
                      Navigator.pop(context);
                      receiveController.clear();
                      descriptionController.clear();

                    }
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
