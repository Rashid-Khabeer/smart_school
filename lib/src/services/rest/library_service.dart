import 'package:dio/dio.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/library_model.dart';
import 'package:smart_school/src/utility/constants.dart';

class LibraryService {
  final _endPoint = kApiUrl + '/webservice/getLibraryBookIssued';
  final _dio = Dio(
    BaseOptions(
      headers: {
        "Client-Service": "smartschool",
        "Auth-Key": "schoolAdmin@",
        "Content-Type": "application/json",
        "Authorization": AppData().readLastUser().token,
        "User-Id": AppData().readLastUser().userId
      },
      connectTimeout: 50000,
      receiveTimeout: 50000,
    ),
  );

  Future<Response> getData(LibraryRequest request) async {
    final response = await _dio.post(_endPoint, data: request.toJson());
    if (response.statusCode == 200) {
      return response;
    } else
      throw 'No Internet Connection';
  }
}
