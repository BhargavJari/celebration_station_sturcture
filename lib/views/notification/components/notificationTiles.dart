import 'package:celebration_station_sturcture/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class NotificationTiles extends StatelessWidget {
  final String title, subtitle;
  final Function onTap;
  final bool enable;
  const NotificationTiles({
    Key ?key, required this.title, required this.subtitle, required this.onTap, required this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('asset/images/logo.png'), fit: BoxFit.cover))),
      title: Text(title, style: TextStyle(color: ColorUtils.blackColor)),
      subtitle: Text(subtitle,
          style: TextStyle(color: ColorUtils.blackColor)),
      onTap: () {
      },
      enabled: enable,
    );
  }
}