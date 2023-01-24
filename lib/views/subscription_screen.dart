import 'package:celebration_station_sturcture/services/api_services.dart';
import 'package:celebration_station_sturcture/utils/colors_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../Utils/fontFamily_utils.dart';
import '../services/shared_preference.dart';
import '../utils/show_toast.dart';

class SubscriptionScreen extends StatefulWidget {
  final String? userPhoneNumber;
  final String? userEmail;
  const SubscriptionScreen({Key? key, this.userEmail, this.userPhoneNumber})
      : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late var _razorpay;
  String? paymentId;
  var amountController = TextEditingController();
  String? loginId;

  @override
  void initState() {
    amountController.text = "${499}";

    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
    print("Payment Id here := ${response.paymentId}");
    setState(() {
      paymentId = response.paymentId;
    });
    print("SEND Payment Id here := ${paymentId}");
    ApiService().paymentStatus(context, data: data());
    //payment status change api call
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  FormData data() {
    final currentDate = DateTime.now();
    var compeletedDate = DateFormat('MM-dd-yyyy').format(currentDate);
    return FormData.fromMap({
      "transactionid": paymentId,
      "registrationfee": 499,
      "payment_date": compeletedDate,
      "loginid": loginId,
    });
  }

  Future<void> getLoginId() async {
    String? id = await Preferances.getString("id");
    setState(() {
      loginId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: 38.h,
                        width: double.infinity,
                        child: Image(
                            image: AssetImage(
                                "asset/images/Subscriptionplan.png"))),
                    SizedBox(height: 2.h),
                    Container(
                      height: 25.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorUtils.darkBlueColor, width: 0.5.w),
                          color: ColorUtils.BlueColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
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
                              Razorpay razorpay = Razorpay();
                              Navigator.pop(context);
                              var options = {
                                'key': 'rzp_test_YoriHE0YT6XVEs',
                                'amount':
                                    int.parse(amountController.text) * 100,
                                'name': 'Celebration Station',
                                'description': 'subscription plan',
                                'send_sms_hash': true,
                                'prefill': {
                                  'contact': '${widget.userPhoneNumber}',
                                  'email': '${widget.userEmail}'
                                },
                              };

                              razorpay.open(options);
                              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                  _handlePaymentSuccess);
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

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
