import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OurService extends StatefulWidget {
  const OurService({Key? key}) : super(key: key);

  @override
  State<OurService> createState() => _HomeState();
}

class _HomeState extends State<OurService> {
  List services = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchServices();
  }

  fetchServices() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await post(
        //Uri.parse('https://reqres.in/api/login'),
        Uri.parse('https://celebrationstation.in/get_ajax/get_all_services/'),
        headers: {
          'Client-Service': 'frontend-client',
          'Auth-Key': 'simplerestapi4qw',
          'User-ID': '1',
          'token': '94P9d.7uf7o6c',
          'type': '1'
        },
        body: {},
      );
      if (response.statusCode == 200) {
        var items = jsonDecode(response.body)['users'];
        setState(() {
          services = items;
          isLoading = false;
        });
        print("Services Fetched");
      } else {
        setState(() {
          services = [];
          isLoading = false;
        });
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
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "img/celebrationstation.png",
          height: 60,
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const ContactUs()));
            },
            icon: Icon(
              CupertinoIcons.bell,
              color: Colors.grey,
            ),
          ),
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
    if(services.contains(null) || services.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lime),));
    }
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
            onPressed: () {},
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

