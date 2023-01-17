import 'package:fluttertoast/fluttertoast.dart';

class ApiResponseModel<T> {
  int? status;
  String? message;

  ApiResponseModel({

    required this.message,

    required this.status,
  });

  factory ApiResponseModel.fromJson(String message, int statusCode) {
    return ApiResponseModel(

      message: message,

      status: statusCode,
    );
  }

  static errorShow(dynamic apiResponse) {
    if (apiResponse["error"] != null) {
      Fluttertoast.showToast(msg: apiResponse["error"]);
    } else if (apiResponse["message"] != null) {
      Fluttertoast.showToast(msg: apiResponse["message"]);
    } else if (apiResponse["msg"] != null) {
      Fluttertoast.showToast(msg: apiResponse["msg"]);
    } else if (apiResponse["errors"] != null) {
      Fluttertoast.showToast(msg: apiResponse["errors"].toString());
    } else if (apiResponse.reasonPhrase != null) {
      Fluttertoast.showToast(msg: apiResponse.reasonPhrase);
    }
  }
}

