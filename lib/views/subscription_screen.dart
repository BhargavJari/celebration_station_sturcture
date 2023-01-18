import 'package:celebration_station_sturcture/utils/colors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/fontFamily_utils.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor:ColorUtils.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title:  Image.asset(
          "asset/images/logo.png",
          height: 60,
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: ()
            {},
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5,right: 15,left: 15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [

                    SizedBox(
                      height: 38.h,
                        width: double.infinity,
                        child: Image(image: AssetImage("asset/images/Subscriptionplan.png"))
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 25.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorUtils.darkBlueColor,width: 0.5.w),
                          color: ColorUtils.BlueColor,
                          borderRadius: const BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Only ₹499',
                            style: FontTextStyle.poppinsS24W7RedColor,
                          ),
                          Text(
                            '(5 Years)',
                            style: FontTextStyle.poppinsS24W7RedColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Center(
                      child: SizedBox(
                          height: 50, //height of button
                          width: double.infinity, //width of button
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                              Colors.lime[200], //background color of button
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () async {
                            },
                            child: Text(
                              "Subscribe Now",
                              style: FontTextStyle.poppinsS16W7BlackColor,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
