import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int _errorCode;
  String _errorMessage = '';

  ServerError.withError(DioError error) {
    _handleError(error);
  }

  int get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = 'Request was cancelled';
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = 'Connection timeout';
        break;
      case DioErrorType.DEFAULT:
        _errorMessage = 'Connection failed due to internet connection.';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = 'Receive timeout in connection.';
        break;
      case DioErrorType.RESPONSE:
        _errorCode = error.response.statusCode;
        switch (_errorCode) {
          case 401:
            _errorMessage = error.response.data['message'];
            break;
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = 'Receive timeout in send request';
        break;
    }
    return _errorMessage;
  }
}
