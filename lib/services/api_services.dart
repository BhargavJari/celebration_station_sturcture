import 'dart:convert';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/bottom_nav_bar.dart';
import 'package:celebration_station_sturcture/services/shared_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dashboard/bottomNavBar/tabs/ourServices-1.dart';
import '../model/GetAllProfileModel.dart';
import '../model/LoginModel.dart';
import '../model/mobile_verify_model.dart';
import '../views/auth/otp_verification_screen.dart';
import '../views/updateProfile.dart';
import 'api_endpoint.dart';
import 'dio_client.dart';
import 'package:http/http.dart' as http;

Dio dio = Dio();

class ApiService {
  ApiClient apiClient = ApiClient();

  Future<LoginModel?> login(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      print("login try");
      Response response;
      response = await dio.post(ApiEndPoints.loginApi,
          options: Options(headers: {
            "Client-Service": 'frontend-client',
            'Auth-Key': 'simplerestapi'
          }),
          data: data);
      LoginModel responseData = LoginModel.fromJson(response.data);
      if (responseData.message == "ok") {
        var cookies = response.headers['set-cookie'];
        print("cookies:=${cookies![0].split(';')[0]}");

        debugPrint('login data  ----- > ${response.data}');

        Preferances.setString("id", responseData.id);
        Preferances.setString("token", responseData.token);
        Preferances.setString("type", responseData.type);
        Preferances.setString("PROFILE_STATUS", responseData.pROFILESTATUS);
        Preferances.setString("cookie", cookies[0].split(';')[0]);
        if (responseData.pROFILESTATUS == '0') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const UpdateProfile()),
              (Route<dynamic> route) => false);
        } else if (responseData.pROFILESTATUS == '1') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
              (Route<dynamic> route) => false);
        }
        Fluttertoast.showToast(
          msg: 'Login Sucessfully...',
          backgroundColor: Colors.grey,
        );
        return responseData;
      } else {
        Fluttertoast.showToast(
          msg: "invalid",
          backgroundColor: Colors.grey,
        );

        throw Exception(response.data);
      }
    } on DioError catch (e) {
      print("dio");
      debugPrint('Dio E  $e');
      debugPrint('Dio E  $e');
    }
  }

  Future updateProfile(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response;
      response = await dio.post(
          "https://celebrationstation.in/post_ajax/update_profile/",
          options: Options(headers: {
            'Client-Service': 'frontend-client',
            'Auth-Key': 'simplerestapi',
            'User-ID': id,
            'Authorization': token,
            'type': type
          }),
          data: data);
      if (response.statusCode == 200) {
        debugPrint('Update profile data  ----- > ${response.data}');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OurServices(),
            ));
        Fluttertoast.showToast(
          msg: 'Updated Sucessfully...',
          backgroundColor: Colors.grey,
        );
      } else {
        Fluttertoast.showToast(
          msg: "invalid",
          backgroundColor: Colors.grey,
        );

        throw Exception(response.data);
      }
    } on DioError catch (e) {
      print("dio");
      debugPrint('Dio E  $e');
    }
  }

  Future<GetAllProfileModel?> getProfileRecord(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      print("try");
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response;
      var formData = FormData.fromMap({
        'loginid': id?.replaceAll('"', '').replaceAll('"', '').toString(),
      });
      // Map<String,dynamic> data = {
      //   'loginid': id?.replaceAll('"', '').replaceAll('"', '').toString()};
      print(formData);
      print(id);
      response = await dio.post(
          "https://celebrationstation.in/get_ajax/get_profile_record/",
          options: Options(headers: {
            'Client-Service': 'frontend-client',
            'Auth-Key': 'simplerestapi',
            'User-ID': id,
            'Authorization': token,
            'type': type
          }),
          data: formData);
      GetAllProfileModel responseData =
          GetAllProfileModel.fromJson(response.data);
      if (responseData.message == "ok") {
        debugPrint('Get Profile data  ----- > ${response.data}');

        Fluttertoast.showToast(
          msg: 'Get Profile Data Sucessfully...',
          backgroundColor: Colors.grey,
        );
        return responseData;
      } else {
        Fluttertoast.showToast(
          msg: "invalid",
          backgroundColor: Colors.grey,
        );

        throw Exception(response.data);
      }
    } on DioError catch (e) {
      print("dio");
      debugPrint('Dio E  $e');
    }
  }

  Future addEnquiry(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response;
      response = await dio.post(ApiEndPoints.addEnquiryApi,
          options: Options(headers: {
            'Client-Service': 'frontend-client',
            'Auth-Key': 'simplerestapi',
            'User-ID': id,
            'Authorization': token,
            'type': type
          }),
          data: data);
      if (response.statusCode == 200) {
        debugPrint('Add Enquiry ----- > ${response.data}');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ));
        Fluttertoast.showToast(
          msg: 'Enquiry Add Sucessfully...',
          backgroundColor: Colors.grey,
        );
      } else {
        Fluttertoast.showToast(
          msg: "invalid",
          backgroundColor: Colors.grey,
        );

        throw Exception(response.data);
      }
    } on DioError catch (e) {
      print("dio");
      debugPrint('Dio E  $e');
    }
  }

  Future<MobileVerifyModel?> mobileVerify(
    BuildContext context, {
    FormData? data,
    String? mobile,
  }) async {
    try {
      print("Register check try:=${mobile}");
      Response response;
      response = await dio.post(ApiEndPoints.mobileVerify,
          options: Options(headers: {
            "Client-Service": 'frontend-client',
            'Auth-Key': 'simplerestapi'
          }),
          data: data);

      MobileVerifyModel responseData =
          MobileVerifyModel.fromJson(response.data);
      print("responseData:=${responseData}");
      print("responseData.status:=${responseData.status}");
      if (responseData.message == "ok") {
        print("responseData.bjjhstatus:=${responseData.status}");
        if (responseData.count == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerificationScreen(
                        phoneNumber: "${mobile}",
                      )));
        } else if (responseData.count == 1) {
          Fluttertoast.showToast(
            msg: 'Your number is already register please login',
            backgroundColor: Colors.grey,
          );
        }

        return responseData;
      } else {
        Fluttertoast.showToast(
          msg: "invalid",
          backgroundColor: Colors.grey,
        );

        throw Exception(response.data);
      }
    } on DioError catch (e) {
      print("dio");
      debugPrint('Dio E  $e');
      debugPrint('Dio E  $e');
    }
  }
}
