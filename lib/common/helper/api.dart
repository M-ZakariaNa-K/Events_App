import 'package:dio/dio.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;

var _dio = Dio();

class DioHelper {
  //init function should invoke in main function before runApp()
  // static init() {
  //   _dio = Dio(BaseOptions(
  //     //this URL is Our API and we will write it here and just here
  //     //every method in this class has a base url parameter (this API)
  //     baseUrl: "http://10.0.2.2:8000/api/",
  //     receiveDataWhenStatusError: true,
  //   ));
  // }

//   Future<Response> getData({
//     required String path,
//     Map<String, dynamic>? query,
//     Map<String, dynamic>? body,
//     String? token,
//   }) async {
//     dio.options.headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
//     return await dio.get(path, data: body).catchError((e) {
//       if (e.response.statusCode == 401) {
//       } else {}
//     });
//   }

// //=================================================================================
//   static Future<Response> postData({
//     token,
//     required String url,
//     required Map<String, dynamic> data,
//   }) async {
//     print("....");
//     dio.options.headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
//     return dio
//         .post(
//       url,
//       data: data,
//     )
//         // ignore: body_might_complete_normally_catch_error
//         .catchError((e) {
//       if (e.response.statusCode == 401) {
//         //Get.off(const LoginScreen());
//       } else {}
//     });
//   }
// //=================================================================================
  //=====================================================================================
  static Future<dynamic> get({
    required String url,
  }) async {
    try {
      final headers = <String, dynamic>{
        if (token != "") 'Authorization': 'Bearer $token',
        'Connection': 'Keep-Alive',
        'Accept': 'application/json'
      };

      final response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      print(response.data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'There is a problem with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          GET.Get.snackbar("Opps....", "${e.response?.data["message"]}");
          print('DioError: ${e.response?.data["message"]}');
          print('DioError: ${e.response?.data}');
        } else {
          print('DioError: ${e.message}');
        }
      } else {
        print('Error: $e');
      }
      // throw Exception('Failed to post data');
    }
  }

  //=====================================================================================
  static Future<dynamic> post({
    required String url,
    required dynamic body,
  }) async {
    try {
      final headers = <String, dynamic>{
        if (token != "") 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final response =
          await _dio.post(url, data: body, options: Options(headers: headers));
      print('Request body: $body');
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        GET.Get.snackbar("Gongrats🎉", "${response.data["message"]}");
        return response.data;
      } else {
        GET.Get.snackbar("Opps....", "${response.data["message"]}");
        throw Exception(
            'There is a problem with status code ${response.statusCode} with body ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          GET.Get.snackbar("Opps....", "${e.response?.data["message"]}");
          print('DioError: ${e.response?.data["message"]}');
          print('DioError: ${e.response?.data}');
        } else {
          print('DioError: ${e.message}');
        }
      } else {
        print('Error: $e');
      }
      // throw Exception('Failed to post data');
    }
  }

  //=====================================================================================
  static Future<void> delete({
    required String url,
  }) async {
    try {
      final headers = <String, dynamic>{
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
          followRedirects: true,
          maxRedirects: 5, // Set the maximum number of redirects
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      print('response: ${response}');

      if (response.statusCode == 200) {
        print(response.data);
        print('Item deleted successfully');
      } else {
        print('Failed to delete order. Status Code: ${response.statusCode}');
        print('Response Body: ${response.data}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to delete order');
    }
  }

  //=====================================================================================
  static Future<Response> postDataWithAuth({
    token,
    required String url,
    required Map<String, dynamic> data,
  }) async {
    _dio.options.headers = {
      'Accept': 'application/json',
    };

    return _dio
        .post(
      url,
      data: data,
    )
        // ignore: body_might_complete_normally_catch_error
        .catchError((e) {
      if (e.response.statusCode == 401) {
        //Get.off(const LoginScreen());
      } else if (e.response.statusCode == 422) {
        print("zak ${e.response}");
        print(e.response['message']);
        print(e.response.statusCode);

        // showToast(text: e.response['message'], state: ToastStates.ERROR);
      } else {
        print(e.response.statusCode);
      }
      return 0;
    });
  }

  static Future<Response> putData(
      {required String baseURL,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = "en",
      String? token}) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // 'lang': lang,
      'Authorization': token ?? ''
    };
    return _dio.put(baseURL, queryParameters: query, data: data);
  }

  // Future<Response> deletData(
  //     {required String path,
  //     Map<String, dynamic>? query,
  //     Map<String, dynamic>? body,
  //     String? token}) async {
  //   dio.options.headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   return await dio.delete(path, data: body).catchError((e) {
  //     if (e.response != null) {
  //     } else {}
  //   });
  // }
}
