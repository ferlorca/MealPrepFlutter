import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealprepapp/models/models/error.dart';
import 'package:mealprepapp/utilities/constants.dart';
import 'package:mealprepapp/utilities/network_helper.dart';

class AuthData with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  bool _loading = false;
  ErrorHandler _error;
  String _role;
  IdTokenResult _token;

  bool get loading => _loading;
  ErrorHandler get error => _error;
  FirebaseUser get user => _user;
  String get role => _role;
  String get token => _token.token;

  Future<FirebaseUser> getCurrentUserFromFirebase() async {
    setLoading(true);
    try {
      if (_user == null) _user = await _auth.currentUser();
    } catch (e) {
      _error = ErrorHandler.handleError(e);
    }
    setLoading(false);
    notifyListeners();
    return _user;
  }

  Future<FirebaseUser> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      setLoading(true);
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user == null) {
        _error =
            ErrorHandler.handleError("error al registrarse el nuevo usuario");
      } else {
        _user = user.user;
        updateAuthDataWithUser(_user);
      }
    } catch (e) {
      _error = ErrorHandler.handleError(e);
    }
    setLoading(false);
    notifyListeners();
    return _user;
  }

  Future<FirebaseUser> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      setLoading(true);
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user == null) {
        _error = ErrorHandler.handleError("error al ingresar");
      } else {
        _user = user.user; //await _auth.currentUser();
        updateAuthDataWithUser(_user);
      }
    } catch (e) {
      _error = ErrorHandler.handleError(e);
    }
    setLoading(false);
    notifyListeners();
    return _user;
  }

  void setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

  void singOut() {
    _auth.signOut();
    _error = null;
    _token = null;
    NetworkHelper().token = null;
    _user = null;
    _role = null;
    notifyListeners();
  }

  void getRole() async {
    try {
      final String url = kURLApi + "/role";
      final response = await NetworkHelper().get(url: url);
      _role = response['role'];
      notifyListeners();
    } catch (e) {
      _error = ErrorHandler.handleError(e);
    }
  }

  Future updateAuthDataWithUser(FirebaseUser _user) async {
    setLoading(true);
    if (_token == null) {
      _token = await _user.getIdToken();
      NetworkHelper().token = token;
    }
    getRole();
    setLoading(false);
  }
}
