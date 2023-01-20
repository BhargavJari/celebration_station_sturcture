
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/tabs/bookingList.dart';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/tabs/eventCalender.dart';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/tabs/ourServices-1.dart';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/tabs/profile/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  final index;
  const BottomNavBar({Key? key,required this.index}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final controller = PageController();
  var selectedIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index != 0){
      selectedIndex = widget.index;
    }
  }

  List pages = [
    OurServices(),
    EventCalendarScreen(),
    BookingList(),
    ProfileScreen()
  ];

  void onTap(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomBar(
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: selectedIndex,
        onTap: onTap,
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.lime.shade800,
            activeTitleColor: Colors.lime.shade800,
          ),
          BottomBarItem(
            icon: Icon(Icons.add),
            title: Text('New Booking'),
            activeColor: Colors.lime.shade800,
            activeTitleColor: Colors.lime.shade800,
          ),
          BottomBarItem(
            icon: Icon(Icons.list_alt),
            title: Text('Booking List'),
            backgroundColorOpacity: 0.1,
            activeColor: Colors.lime.shade800,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Colors.lime.shade800,
            activeTitleColor: Colors.lime.shade800,
          ),
        ],
      ),
      /*bottomNavigationBar: SlidingClippedNavBar(

        backgroundColor: Colors.grey.shade100,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          controller.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        iconSize: 30,
        activeColor: Colors.lime.shade800,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.add,
            title: 'Add',
          ),
          BarItem(
            icon: Icons.search,
            title: 'Search',
          ),
          BarItem(
            icon: Icons.shopping_cart,
            title: 'Cart',
          ),
        ],
      ),*/
    );
  }
}
