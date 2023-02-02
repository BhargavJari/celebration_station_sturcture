import 'package:celebration_station_sturcture/Utils/colors_utils.dart';
import 'package:celebration_station_sturcture/utils/fontfamily_utils.dart';
import 'package:flutter/material.dart';

import 'components/defaultAppBar.dart';
import 'components/defaultBackButton.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: DefaultAppBar(
        title: 'Notification',
        child: DefaultBackButton(),
      ),
      body: FittedBox(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: ColorUtils.whiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [BoxShadow(color: ColorUtils.skyBlueColor, blurRadius: 2.0)]),
          child: Column(
            children: [
              Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: FontTextStyle.poppinsS12W7BlackColor),
              SizedBox(height: 16.0),
              Image(image: NetworkImage('https://images.pexels.com/photos/1485894/pexels-photo-1485894.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
              SizedBox(height: 16.0),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  style: TextStyle(color: ColorUtils.blackColor)),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: Text('11/Feb/2021 04:42 PM',
                    style: TextStyle(color: ColorUtils.blackColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
