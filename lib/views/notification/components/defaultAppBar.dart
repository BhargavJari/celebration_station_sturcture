import 'package:celebration_station_sturcture/Utils/colors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Widget child;
  final action;
  const DefaultAppBar({
    Key? key, required this.title, required this.child, this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: ColorUtils.whiteColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        "asset/images/logo.png",
        height: 60,
      ),
      leading: BackButton(color: ColorUtils.blackColor),
      actions: [
        IconButton(
          iconSize: 30.0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.bell,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}