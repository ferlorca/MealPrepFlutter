import 'package:flutter/cupertino.dart';
import 'package:mealprepapp/models/models/error.dart';

class PruebaData with ChangeNotifier {
  ErrorHandler _error = ErrorHandler(code: "", message: "");
  ErrorHandler get error => _error;
  void testWork() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      _error = ErrorHandler.handleError(
          "esto es una prueba de error que se completa dsp de 500 ms");
      notifyListeners();
    });
  }
}
