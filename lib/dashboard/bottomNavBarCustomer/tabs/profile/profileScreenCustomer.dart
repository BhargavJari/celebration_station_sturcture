import 'package:celebration_station_sturcture/dashboard/bottomNavBarCustomer/tabs/profile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../CustomDrawerCustomer.dart';


class ProfileScreenCustomer extends StatefulWidget {
  const ProfileScreenCustomer({Key? key}) : super(key: key);

  @override
  State<ProfileScreenCustomer> createState() => _ProfileScreenCustomerState();
}

class _ProfileScreenCustomerState extends State<ProfileScreenCustomer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerCustomer(),
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
      ),
      body: const Body(),
    );
  }
}
