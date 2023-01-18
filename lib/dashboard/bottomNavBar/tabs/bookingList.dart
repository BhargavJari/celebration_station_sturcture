import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../../services/shared_preference.dart';
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

  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingDetails();
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
          'loginid':id?.replaceAll('"', '').replaceAll('"', '').toString(),
          'month' : month
        },
      );
      if(response.statusCode==200){
        var items = jsonDecode(response.body)['\$booking'];
        setState(() {
          getEvent = items;
          isLoading = false;
        });
        print("Booking List Fetched");
      }else{
        setState(() {
          getEvent = [];
          isLoading = false;
        });
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
        print('Booking Canceled');
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
        leading: IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.menu,
            color: Colors.grey,
          ),
          onPressed: () {
            // CustomDrawer();
          },
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
                            'Advance',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Balance',
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
                            'Cancel',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(getEvent.length, (index){
                      return DataRow(cells: [
                        DataCell(Container(width: 75, child: Text(getEvent[index]['CBD_BOOKING_DATE']))),
                        DataCell(Container(child: Text(getEvent[index]['CBD_BOOKING_ADVANCE']))),
                        DataCell(Container(child: Text(getEvent[index]['CBD_BOOKING_AMOUNT']))),
                        DataCell(Container(child: Text(getEvent[index]['CBD_MALE_NAME']))),
                        DataCell(Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, //background color of button
                                elevation: 2,
                                shape: RoundedRectangleBorder( //to set border radius to button
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              onPressed: () {
                                _showCancelEventDialog(getEvent[index]['CBD_BOOKING_DATE'], getEvent[index]['CBD_ID']);
                              },
                              child: Text('Cancel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white
                                ),
                              ),
                            )
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
                  onPressed: () => Navigator.pop(context),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Enter Cancellation reason!!'),
                              duration: Duration(seconds: 2),
                            )
                        );
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
}
