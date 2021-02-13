import 'package:dio/dio.dart';
import 'package:smart_school/src/utility/constants.dart';

final dioClient = Dio(
  BaseOptions(
    headers: {
      "Client-Service": "smartschool",
      "Auth-Key": "schoolAdmin@",
      "Content-Type": "application/json"
    },
    baseUrl: kApiUrl,
    connectTimeout: 50000,
    receiveTimeout: 50000,
  ),
);
