import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Centralizing the error handling logic in a method
    var dioError = err.copyWith(error: _getErrorMessage(err));
    
    // Passing the modified error to the next handler
    return handler.next(dioError);
  }

  // Centralized method to generate error messages based on the error type
  String _getErrorMessage(DioException err) {
    switch (err.type) {
      case DioExceptionType.cancel:
        return 'Request to API server was cancelled';
      case DioExceptionType.connectionTimeout:
        return 'Connection to API server timed out';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with API server';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with API server';
      case DioExceptionType.badResponse:
        if (err.response != null) {
          if (err.response!.statusCode == 404) {
            return '404: Resource not found.';
          }
          if (err.response!.statusCode == 500) {
            return '500: Internal server error.';
          }
          return '${err.response!.statusCode}: ${err.response!.data}';
        }
        return 'Received invalid status code: ${err.response?.statusCode}';
      case DioExceptionType.badCertificate:
        return 'Certificate validation failed';
      case DioExceptionType.connectionError:
        return 'Connection to API server failed due to internet connection';
      case DioExceptionType.unknown:
        return 'Connection to API server failed due to unknown error';
      default:
        return 'An unknown error occurred';
    }
  }
}
