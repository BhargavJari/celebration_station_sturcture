import 'package:celebration_station_sturcture/utils/colors_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:getwidget/getwidget.dart';
import '../Utils/fontFamily_utils.dart';
import '../model/FaqModel.dart';
import '../../../utils/loder.dart';


class faqScreen extends StatefulWidget {
  final String? userPhoneNumber;
  final String? userEmail;
  const faqScreen({Key? key, this.userEmail, this.userPhoneNumber})
      : super(key: key);

  @override
  State<faqScreen> createState() => _faqScreenState();
}

class _faqScreenState extends State<faqScreen> {
  faqModel? faq;

  Future<void> _getAllFaq({
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> formdata = ({});
      final response = await Dio().post(
        'https://celebrationstation.in/get_ajax/get_all_fquestion/',
        // options: Options(headers: {
        //   'Client-Service': 'frontend-client',
        //   'Auth-Key': 'simplerestapi',
        //   'User-ID': widget.userId,
        //   'Authorization': widget.token,
        //   'type': widget.type
        // }),
        queryParameters: formdata,
      );

      print("get State  Api response data :- ");
      print(response.data);

      faq = faqModel.fromJson(response.data);
      setState(() {
        faq;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _getAllFaq(context: context);
    super.initState();
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
                        height: 25.h,
                        width: double.infinity,
                        child:
                            Image(image: AssetImage("asset/images/faq.png"))),
                    SizedBox(height: 2.h),
                    for (var i = 0; i < faq!.fquestion!.length; i++) ...{
                      GFAccordion(
                        textStyle: FontTextStyle.poppinsS16W7BlackColor,
                          title: faq?.fquestion![i].fQUESTION ?? "",
                          content: faq?.fquestion![i].fANSWER ?? "",
                          // collapsedIcon: Icon(Icons.add),
                          // expandedIcon: Icon(Icons.minimize)
                      ),
                    }
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
