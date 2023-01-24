import 'dart:convert';
import 'package:celebration_station_sturcture/Utils/colors_utils.dart';
import 'package:celebration_station_sturcture/Utils/fontFamily_utils.dart';
import 'package:celebration_station_sturcture/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../model/GetAllProfileModel.dart';
import '../../../services/shared_preference.dart';
import '../../../utils/loder.dart';
import '../../../views/subscription_screen.dart';
import '../../CustomDrawer.dart';
import '../bottom_nav_bar.dart';

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
  Map<String, dynamic> myDateSelectedEvents = {};
  var dateList;
  var getData = [];
  var getEvent = [];
  List<dynamic> getDateEvent = [];
  var paymentStatus;

  final titleController = TextEditingController();
  final bookingAmountController = TextEditingController();
  final advanceController = TextEditingController();
  final maleNameController = TextEditingController();
  final femaleNameController = TextEditingController();
  final descpController = TextEditingController();
  final phoneController = TextEditingController();
  final cancelMessageController = TextEditingController();
  ProfileDetails? profileDetails;

  var client = http.Client();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
    loadPreviousEvents();
    getprofile();
  }

  getprofile() {
    ApiService().getProfileRecord(context).then((value) {
      if (value!.message == "ok") {
        print("hhiii");
        setState(() {
          profileDetails = value.detail!;
          paymentStatus = value.detail!.pAYMENTSTATUS;
        });
        //print('model:$profileDetails');
        //print('model:${profileDetails?.pAYMENTSTATUS}');
        //print("paymentStatus:=${paymentStatus}");
      }
    });
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
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse('https://celebrationstation.in/post_ajax/add_new_booking'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {
          'booking_date': date,
          'loginid': id?.replaceAll('"', '').replaceAll('"', '').toString(),
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
        loadPreviousEvents();
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
        getBookingDetails(DateFormat('yyyy').format(_selectedDate!),
            DateFormat('MM').format(_selectedDate!));
        print(data);
        print('Booking Canceled');

      }else{
        var data = json.decode(response.body.toString());
        print(data);
        print('FAILED');
      }
    }catch(e){
      print(e.toString());
    }
  }

  getBookingDetails(String year, String month) async {
    try {
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse(
            'https://celebrationstation.in/get_ajax/get_booking_month_details'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {
          'year': year,
          'loginid': id?.replaceAll('"', '').replaceAll('"', '').toString(),
          'month': month
        },
      );

      if (response.statusCode == 200) {
        var items = jsonDecode(response.body)['\$booking'];
        getEvent = items;
        /*events = getEvent[index]['CBD_BOOKING_DATE'];*/
        setState(() {
          for (var i = 0; i < getEvent.length; i++) {
            mySelectedEvents.addEntries([
              MapEntry(getEvent[i]['CBD_BOOKING_DATE'].toString(), [
                {
                  "eventTitle": getEvent[i]['CBD_TITLE'],
                  "eventDescp": getEvent[i]['CBD_DESC'],
                  "bookingAmount": getEvent[i]['CBD_BOOKING_AMOUNT'],
                  "advance": getEvent[i]['CBD_BOOKING_ADVANCE'],
                  "maleName": getEvent[i]['CBD_MALE_NAME'],
                  "femaleName": getEvent[i]['CBD_FEMALE_NAME']
                },
              ])
            ]);
          }
        });
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

  getDateBookingDetails(String date) async {
    Loader.showLoader();
    try {
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse(
            'https://celebrationstation.in/get_ajax/get_booking_by_date/'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi',
          'User-ID': id.toString(),
          'token': token.toString(),
          'type': type.toString()
        },
        body: {
          'date': date,
          'loginid': id?.replaceAll('"', '').replaceAll('"', '').toString(),
        },
      );

      if (response.statusCode == 200) {
        var items = jsonDecode(response.body)['\$booking'];
        getDateEvent = items;
        //Loader.hideLoader();
        print(getDateEvent.length);
        Loader.hideLoader();
        print("Booking Date List Fetched");
      } else {
        setState(() {
          getDateEvent =[];
        });
        Loader.hideLoader();
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
    // return getEvent;
  }

  loadPreviousEvents() {
    getBookingDetails(DateFormat('yyyy').format(_selectedDate!),
        DateFormat('MM').format(_selectedDate!));

    /*mySelectedEvents = {
      "2023-01-12": [
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
                  /*addBooking(DateFormat('yyyy-MM-dd').format(_selectedDate!).toString(),
                      titleController.text.toString(),
                      descpController.text.toString(),
                    bookingAmountController.text.toString(),
                    advanceController.text.toString(),
                    maleNameController.text.toString(),
                    femaleNameController.text.toString(),
                    phoneController.text.toString()
                  );*/
                  //addBooking();
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
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
                    loadPreviousEvents();
                    /*mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDescp": descpController.text,
                      "bookingAmount" : bookingAmountController.text,
                      "advance" : advanceController.text,
                      "maleName" : maleNameController.text,
                      "femaleName" : femaleNameController.text,
                    });*/
                  } else {
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
                    loadPreviousEvents();
                    /*mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDescp": descpController.text,
                        "bookingAmount" : bookingAmountController.text,
                        "advance" : advanceController.text,
                        "maleName" : maleNameController.text,
                        "femaleName" : femaleNameController.text,
                      }
                    ];*/
                  }
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
  _showEventDetailDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Event Details \n\n Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.pink.shade50),
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade50),
                headingRowHeight: 50,
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
                        'Title',
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
                        'Male Name',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Female Name',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Description',
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
                rows: List.generate(getDateEvent.length, (index){
                  return DataRow(cells: [
                    DataCell(Container(child: Text(getDateEvent[index]['CBD_BOOKING_DATE']))),
                    DataCell(Container(child: Text(getDateEvent[index]['CBD_TITLE']))),
                    DataCell(Container(child: Text(getDateEvent[index]['CBD_BOOKING_ADVANCE']))),
                    DataCell(Container(child: Text(getDateEvent[index]['CBD_BOOKING_AMOUNT']))),
                    DataCell(Container(child: Text(getDateEvent[index]['CBD_MALE_NAME']))),
                    DataCell(Container(child: Text(getDateEvent[index]['CBD_FEMALE_NAME']))),
                    DataCell(Container(child: Text(getDateEvent[index]['CBD_DESC']))),
                    DataCell(Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, //background color of button
                            elevation: 2,
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          onPressed: () {
                            _showCancelEventDialog(getDateEvent[index]['CBD_BOOKING_DATE'], getDateEvent[index]['CBD_ID']);
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

        ],
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
                        getBookingDetails(DateFormat('yyyy').format(_selectedDate!),
                            DateFormat('MM').format(_selectedDate!));
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
                  /*calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) => events.isNotEmpty
                        ? Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.lightBlue,
                      ),
                      child: Text(
                        '${events.length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                        : null,
                  ),*/
                  onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDate, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                      if (mySelectedEvents[DateFormat('yyyy-MM-dd')
                              .format(_selectedDate!)] !=
                          null) {
                        _isVisible = true;
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
                (myEvents) {
                  getDateBookingDetails(DateFormat('yyyy-MM-dd').format(_selectedDate!));
                  //print("myEvent length:=${myEvents}");
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        primary: Colors.lime[200], //background color of button
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          //to set border radius to button
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        _showEventDetailDialog();
                      },
                      child: const Text(
                        "View Event Details",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black
                        ),
                      ),
                    ),
                  );
                  /*return ListTile(
                    leading: const Icon(
                      Icons.done,
                      color: Colors.teal,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                          'Booking Details: \n \n ${myEvents['eventTitle']}'),
                    ),
                    subtitle: Text(' Description:  ${myEvents['eventDescp']}'
                        '\n Booking Amount : ${myEvents['bookingAmount']}'
                        '\n Advance : ${myEvents['advance']}'
                        '\n Male Name : ${myEvents['maleName']}'
                        '\n Female Name : ${myEvents['femaleName']}'),
                  );*/
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton.extended(
          backgroundColor: ColorUtils.primaryColor,
          foregroundColor: ColorUtils.blackColor,
          extendedTextStyle: FontTextStyle.poppinsS12W7BlackColor,
          onPressed: () {
            if (paymentStatus == "0") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SubscriptionScreen(
                            userEmail: profileDetails?.bRANCHEMAIL,
                            userPhoneNumber: profileDetails?.bRANCHCONTACT,
                          ))).then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBar(
                              index: 1,
                            )),
                    (Route<dynamic> route) => false);
              });
            } else {
              _showAddEventDialog();
            }
          },
          // paymentStatus != 0 ? _showAddEventDialog() :Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionScreen(),)) ,
          label: const Text('Add Event'),
        ),
        /*replacement: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
            onPressed: () => _showCancelEventDialog(),
            label: const Text('Cancel Event'),
          ),
        ),*/
      ),
    );
  }
}
