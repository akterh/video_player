import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static Future<BaseOptions> _options(String token) async {
    return BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {
        'Authorization': 'Bearer $token',
        'AuthorizationKey': 'ABC',
        'DeviceType': 'Mobile'
      },
    );
  }

  static Future<Dio> _dioClient(String token) async {
    Dio dio = Dio(await _options(token));
    dio.interceptors.add(dioLoggerInterceptor);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (io.HttpClient client) {
      client.badCertificateCallback =
          (io.X509Certificate cert, String host, int port) => true;
    };
    return dio;
  }

  static Future<dynamic> get(
      String url, {
        String token = '',
      }) async {
    try {
      Dio dio = await _dioClient(token);
      Response response = await dio.get(url);
      return jsonDecode(response.toString());
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> post(String url, dynamic body,
      {String token = ''}) async {
    try {
      Dio dio = await _dioClient(token);
      Response response = await dio.post(url, data: body);
      if(response.statusCode==200){
        return jsonDecode(response.toString());
      }else {

        if (kDebugMode) {
          print("data not getting from remote");
        }
      }

    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> delete(String url, {String token = ''}) async {
    try {
      Dio dio = await _dioClient(token);
      Response response = await dio.post(url);
      return jsonDecode(response.toString());
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> upload(String url, dynamic body,
      {String token = ''}) async {
    try {
      Dio dio = await _dioClient(token);
      Response response = await dio.post(
        url,
        data: FormData.fromMap(body),
      );
      return jsonDecode(response.toString());
    } catch (e) {
      rethrow;
    }
  }
}