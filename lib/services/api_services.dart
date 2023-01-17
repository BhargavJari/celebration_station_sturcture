import 'dart:convert';
import 'package:celebration_station_sturcture/dashboard/bottomNavBar/bottom_nav_bar.dart';
import 'package:celebration_station_sturcture/services/shared_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dashboard/bottomNavBar/tabs/ourServices-1.dart';
import '../model/LoginModel.dart';
import '../model/get_profile_record_model.dart';
import '../views/updateProfile.dart';
import 'api_endpoint.dart';
import 'dio_client.dart';

Dio dio = Dio();
class ApiService {
  ApiClient apiClient = ApiClient();

  Future<LoginModel?> login(BuildContext context, {
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
      LoginModel responseData =
      LoginModel.fromJson(response.data);
      if (responseData.message == "ok") {
        var cookies = response.headers['set-cookie'];
        print("cookies:=${cookies![0].split(';')[0]}");

        debugPrint('login data  ----- > ${response.data}');

        Preferances.setString("id", responseData.id);
        Preferances.setString("token", responseData.token);
        Preferances.setString("type", responseData.type);
        Preferances.setString("PROFILE_STATUS", responseData.pROFILESTATUS);
        Preferances.setString("cookie",cookies[0].split(';')[0]);
        if(responseData.pROFILESTATUS=='0'){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const UpdateProfile()), (Route<dynamic> route) => false);
        }else if(responseData.pROFILESTATUS=='1'){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const BottomNavBar()), (Route<dynamic> route) => false);
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
    }
  }

  Future updateProfile(BuildContext context, {
    FormData? data,
  }) async {
    try {
      String? id = await Preferances.getString("id");
      String? token = await Preferances.getString("token");
      String? type = await Preferances.getString("type");
      String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      Response response;
      response = await dio.post(ApiEndPoints.updateProfileApi,
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => OurServices(),));
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

  Future<GetProfileRecord?> getProfileRecord(BuildContext context, {
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
        'id': id?.replaceAll('"', '').replaceAll('"', '').toString(),
      });
      response = await dio.post(ApiEndPoints.getProfileRecordApi,
          options: Options(headers: {
            'Client-Service': 'frontend-client',
            'Auth-Key': 'simplerestapi',
            'User-ID': id,
            'Authorization': token,
            'type': type
          }),
          data: formData);
      GetProfileRecord responseData =
      GetProfileRecord.fromJson(response.data);
      if (responseData.message == "ok") {
        print("if");

        debugPrint('login data  ----- > ${response.data}');


        Fluttertoast.showToast(
          msg: 'Login Sucessfully...',
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

  Future addEnquiry(BuildContext context, {
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => OurServices(),));
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
}
