import 'package:flutter/services.dart';

class ErrorHandler {
  String code;
  String message;
  ErrorHandler({this.code, this.message});

  static ErrorHandler handleError(e) {
    if (e is PlatformException) {
      print(e.message);
      return new ErrorHandler(code: e.code, message: e.message);
    }
    if (e is String) {
      print(e);
      return new ErrorHandler(message: e);
    }
    print(e.runtimeType);
    return new ErrorHandler(
        message:
            "Se produjo en error. Lo intentaremos solucionar a la brevedad");
  }
}
