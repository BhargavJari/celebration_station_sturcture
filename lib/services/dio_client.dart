import 'dart:io';
import 'package:dio/dio.dart';
import 'api_responsemodel.dart';
import 'api_endpoint.dart';
import 'functions.dart';
import 'app_exception.dart';


class ApiClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseUrl,
    connectTimeout: 50000,
    receiveTimeout: 50000,
  ));

  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    //Check Internet...

    bool internetStatus = await CommonFunctions.checkConnectivity();

    if (internetStatus) {
      try {
        final Response response = await dio.post(
          uri,
          data: data,

          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        ApiResponseModel responseData =
        await apiResponseModel(response.data, response.statusCode);

        return responseData;
      } on SocketException {
        throw NoInternetException(
            "Something went wrong with server connection, please check after some time");
      } on DioError catch (e) {
        throw e.error;
      }
    } else {
      return apiResponseModel({'message': '', 'status': 0, 'data': ''}, 1001);
    }
  }

  Future<ApiResponseModel> apiResponseModel(
      dynamic response, statusCode) async {
    ApiResponseModel apiResponseModel =
    ApiResponseModel.fromJson(response, statusCode);
    return apiResponseModel;
  }
}
