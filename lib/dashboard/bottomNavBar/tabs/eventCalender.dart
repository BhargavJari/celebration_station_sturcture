import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../CustomDrawer.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({Key? key}) : super(key: key);

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  bool _isVisible = true;
  Map<String, List<dynamic>> mySelectedEvents = {};
  var getData;
  var getEvent = [];

  final titleController = TextEditingController();
  final bookingAmountController = TextEditingController();
  final advanceController = TextEditingController();
  final maleNameController = TextEditingController();
  final femaleNameController = TextEditingController();
  final descpController = TextEditingController();
  final phoneController = TextEditingController();

  var client = http.Client();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
    loadPreviousEvents();
    //this.getBookingDetails(DateFormat('yyyy').format(_selectedDate!), DateFormat('MM').format(_selectedDate!));
    /*getBookingDetails(DateFormat('yyyy').format(_selectedDate!), DateFormat('MM').format(_selectedDate!)).then((value) {
      if(value!.message == "ok"){
        setState(() {
          getEvent = value.users!;
        });
      }
    });*/
  }

  void addBooking(
      String date,
      String title,
      String desc,
      String bookingAmount,
      String advance,
      String maleName,
      String femaleName,
      String customerPhone) async {
    try {
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse('https://celebrationstation.in/post_ajax/add_new_booking'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': '1',
          'token': '94P9d.7uf7o6c',
          'type': '1'
        },
        body: {
          'booking_date': date,
          'loginid': '1',
          'booking_amount': bookingAmount,
          'booking_advance': advance,
          'male_name': maleName,
          'female_name': femaleName,
          'description': desc,
          'customer_phone': customerPhone,
          'title_name': title
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Event Added');
      } else {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('FAILED');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  /*void addBooking() async {
    var url="https://celebrationstation.in/post_ajax/add_new_booking";
    var data={
      "booking_date" : DateFormat('yyyy-MM-dd').format(_selectedDate!).toString(),
      "loginid" : 1.toString(),
      "booking_amount" : bookingAmountController.text,
      "booking_advance" : advanceController.text,
      "male_name" : maleNameController.text,
      "female_name" : femaleNameController.text,
      "description" : descpController.text,
      "customer_phone" : 9714825938.toString()
    };
    var body=jsonEncode(data);
    var urlParse = Uri.parse(url);
    http.Response response = (await http.post(
      urlParse,
      headers: {
        "Client-Service": "frontend-client",
        "Auth-Key" : "simplerestapi",
        "User-ID" : "1",
        "token" : "32ZzvzhrbcJmc",
        "type" : "1"
      },
      body: body
    ));
    var statuscode = response.statusCode;
    if(response.statusCode == 200){
      print("Passed");
      var dataa=jsonDecode(response.body.toString());
      //print(DateFormat('yyyy-MM-dd').format(_selectedDate!).toString());
      print(dataa);
    }else{
      print(statuscode);

    }

  }*/
  /*Future<void> addBooking() async {
    try{
        var headers = {'Client-Service': 'frontend-client',
                      'Auth-Key' : 'simplerestapi',
                      'User-ID' : '1',
                      'token' : '14LBqS7Dlcnfo',
                      'type' : '1'};
        //var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndcpoints.addNewBooking);
        var url = Uri.parse('https://celebrationstation.in/post_ajax/add_new_booking');
        Map body = {
          "booking_date" : _selectedDate.toString(),
          "loginid" : "1",
          "booking_amount" : bookingAmountController.text,
          "booking_advance" : advanceController.text,
          "male_name" : maleNameController.text,
          "female_name" : femaleNameController.text,
          "description" : descpController.text,
          "customer_name" : "9856858585"
        };

        http.Response response = await http.post(url, headers: headers, body: jsonEncode(body));

        if(response.statusCode == 200){
          final json = jsonDecode(response.body);
          print(json);
          if(json['code'] == 0){
            var token = json['token'];
            print(token);
            final SharedPreferences? prefs = await _prefs;
            await prefs?.setString('token',token);
          }
        }else{
          print(_selectedDate.toString());
          throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
        }
    }catch(e){
      print(e.toString());
    }
  }*/

  getBookingDetails(String year, String month) async {
    try {
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse(
            'https://celebrationstation.in/get_ajax/get_booking_month_details'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': '1',
          'token': '94P9d.7uf7o6c',
          'type': '1'
        },
        body: {
          'year': DateFormat('yyyy').format(_selectedDate!),
          'loginid': '1',
          'month': DateFormat('MM').format(_selectedDate!)
        },
      );

      if (response.statusCode == 200) {
        var items = jsonDecode(response.body)['\$booking'];
        getEvent = items;
        /*events = getEvent[index]['CBD_BOOKING_DATE'];*/
        setState(() {
          for (var i = 0; i < getEvent.length; i++) {
            mySelectedEvents.addEntries([
              MapEntry(
                getEvent[i]['CBD_BOOKING_DATE'].toString(),
                [
                  {
                    "eventTitle": getEvent[i]['CBD_TITLE'],
                    "eventDescp": getEvent[i]['CBD_DESC'],
                    "bookingAmount": getEvent[i]['CBD_BOOKING_AMOUNT'],
                    "advance": getEvent[i]['CBD_BOOKING_ADVANCE'],
                    "maleName": getEvent[i]['CBD_MALE_NAME'],
                    "femaleName": getEvent[i]['CBD_FEMALE_NAME']
                  },
                ],
              )
            ]);
          }
        });
        print(getEvent);
      } else {
        setState(() {
          getEvent = [];
        });
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
    // return getEvent;
  }

  /*Future getBookingDetails(BuildContext context, {
    Map? data,
  }) async {
    try {
      var url = "https://celebrationstation.in/get_ajax/get_booking_month_details/";
      Response response = await post(
        Uri.parse(url),
        body: {
      'year' : DateFormat('yyyy').format(_selectedDate!),
      'loginid':'1',
      'month' : DateFormat('MM').format(_selectedDate!)
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          getEvent = response.body;
          print("1st done");
        });
        debugPrint('add account  ----- > ${response.body}');
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint('Dio E  $e');
    }*/

  loadPreviousEvents() {
    getBookingDetails(DateFormat('yyyy').format(_selectedDate!),
        DateFormat('MM').format(_selectedDate!));
    /*for(var i=0;i<mySelectedEvents.length;i++){
      mySelectedEvents = {
        getEvent[i]['CBD_BOOKING_DATE'].toString():[
          {"eventDescp": getEvent[i]['CBD_DESC'], "bookingAmount" : getEvent[i]['CBD_BOOKING_AMOUNT'], "advance":getEvent[i]['CBD_BOOKING_ADVANCE'], "maleName" : getEvent[i]['CBD_MALE_NAME'], "femaleName" : getEvent[i]['CBD_FEMALE_NAME']},
        ],
      };
    }*/
    /* mySelectedEvents = {
      "2022-12-12": [
        {"eventDescp": "HELLLO", "bookingAmount" : "20000", "advance":"2000", "maleName" : "ABC", "femaleName" : "XYZ"},
      ],
      "2023-01-12": [
        {"eventDescp": "HELLLO", "bookingAmount" : "20000", "advance":"2000", "maleName" : "ABC", "femaleName" : "XYZ"},
      ]
    };*/
    print("loadPrevious");
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                controller: bookingAmountController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Booking Amount'),
              ),
              TextFormField(
                controller: advanceController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Advance'),
              ),
              TextFormField(
                controller: maleNameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Male Name'),
              ),
              TextFormField(
                controller: femaleNameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Female Name'),
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
              ),
              TextFormField(
                controller: descpController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.newline,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              if (titleController.text.isEmpty ||
                  descpController.text.isEmpty ||
                  bookingAmountController.text.isEmpty ||
                  advanceController.text.isEmpty ||
                  maleNameController.text.isEmpty ||
                  femaleNameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  phoneController.text.length != 10) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter all the data correctly'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                setState(() {
                  addBooking(
                      DateFormat('yyyy-MM-dd')
                          .format(_selectedDate!)
                          .toString(),
                      titleController.text.toString(),
                      descpController.text.toString(),
                      bookingAmountController.text.toString(),
                      advanceController.text.toString(),
                      maleNameController.text.toString(),
                      femaleNameController.text.toString(),
                      phoneController.text.toString());
                  //addBooking();
                  /*if (mySelectedEvents[
                  DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDescp": descpController.text,
                      "bookingAmount" : bookingAmountController.text,
                      "advance" : advanceController.text,
                      "maleName" : maleNameController.text,
                      "femaleName" : femaleNameController.text,
                    });
                  } else {
                    mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDescp": descpController.text,
                        "bookingAmount" : bookingAmountController.text,
                        "advance" : advanceController.text,
                        "maleName" : maleNameController.text,
                        "femaleName" : femaleNameController.text,
                      }
                    ];
                  }*/
                });
                _isVisible = false;
                print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}");
                titleController.clear();
                bookingAmountController.clear();
                advanceController.clear();
                maleNameController.clear();
                femaleNameController.clear();
                descpController.clear();
                phoneController.clear();
                Navigator.pop(context);
                return;
              }
            },
          ),
        ],
      ),
    );
  }

  _showCancelEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Cancel Event ?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
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
                    onPressed: () {
                      setState(() {
                        _listOfDayEvents(_selectedDate!).removeAt(0);
                      });
                      _isVisible = true;
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
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
        title: Image.asset(
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Search Booking",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TableCalendar(
                firstDay: DateTime.utc(2022) /*DateTime.now()*/,
                lastDay: DateTime(2024),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDate, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                      if (mySelectedEvents[DateFormat('yyyy-MM-dd')
                              .format(_selectedDate!)] !=
                          null) {
                        _isVisible = false;
                      } else {
                        _isVisible = true;
                      }
                    });
                  }
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                eventLoader: _listOfDayEvents,
              ),
              ..._listOfDayEvents(_selectedDate!).map(
                (myEvents) => ListTile(
                  leading: const Icon(
                    Icons.done,
                    color: Colors.teal,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: /*List.generate(getEvent.length, (index){
                      return ListView()
                    })*/
                        Text(
                            'Booking Details: \n \n ${myEvents['eventTitle']}'),
                  ),
                  subtitle: Text(' Description:  ${myEvents['eventDescp']}'
                      '\n Booking Amount : ${myEvents['bookingAmount']}'
                      '\n Advance : ${myEvents['advance']}'
                      '\n Male Name : ${myEvents['maleName']}'
                      '\n Female Name : ${myEvents['femaleName']}'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new Visibility(
        visible: _isVisible,
        child: FloatingActionButton.extended(
          onPressed: () {
            ///if payment first time then call first payment

            /// then call add event

            //_showAddEventDialog();
          },
          label: const Text('Add Event'),
        ),
        replacement: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
            onPressed: () => _showCancelEventDialog(),
            label: const Text('Cancel Event'),
          ),
        ),
      ),
    );
  }
}
