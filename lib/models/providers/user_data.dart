import 'package:flutter/cupertino.dart';
import 'package:mealprepapp/models/models/error.dart';
import 'package:mealprepapp/models/models/user.dart';
import 'package:mealprepapp/utilities/constants.dart';
import 'package:mealprepapp/utilities/network_helper.dart';

class UserData with ChangeNotifier {
  UserData();

  List<User> _users = [];
  List<String> _roles = [];
  bool _loading = false;
  ErrorHandler _error = ErrorHandler(code: "", message: "");

  /*Getters*/
  bool get loading => _loading;
  ErrorHandler get error => _error;
  List<User> get users => _users;
  List<String> get roles => _roles;

  void getUsers() async {
    try {
      final String url = kURLApi + "/users";
      final response = await NetworkHelper().get(url: url);
      for (Map<String, dynamic> aux in response["users"]) {
        _users.add(User.fromJson(aux));
      }
      _users.sort((a, b) => a.role.compareTo(b.role));
      notifyListeners();
    } catch (e) {
      print(e);
      _error = ErrorHandler.handleError(e);
    }
  }

  void getRoles() async {
    try {
      final String url = kURLApi + "/auth/roles";
      final response = await NetworkHelper().get(url: url);
      for (final aux in response["roles"]) {
        _roles.add(aux["name"]);
      }

      notifyListeners();
    } catch (e) {
      print(e);
      _error = ErrorHandler.handleError(e);
    }
  }

  void setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

  void addOrUpdateUser(User user, Map<String, String> data) async {
    try {
      setLoading(true);
      final bool isNew = user == null;
      if (isNew) {
        addUserToServer(data);
      } else {
        updateUserToServer(user.id, data);
      }
    } catch (e) {
      print(e);
      _error = ErrorHandler.handleError(e);
    }
  }

  /*Server*/
  void addUserToServer(Map<String, String> data) async {
    try {
      final String url = kURLApi + "/users";
      final response = await NetworkHelper().post(url: url, body: data);
      _users.add(User.fromJson(response["user"]));
      _users.sort((a, b) => a.role.compareTo(b.role));
      notifyListeners();
      setLoading(false);
    } catch (e) {
      print(e);
      _error = ErrorHandler.handleError(e);
    }
  }

  void updateUserToServer(String id, Map<String, String> data) async {
    try {
      final String url = kURLApi + "/users/$id";
      await NetworkHelper().patch(url: url, body: data);
      int index = _users.indexWhere((element) => element.id == id);
      _users[index].role = data["role"];
      _users[index].email = data["email"];
      _users[index].displayName = data["displayName"];
      notifyListeners();
      setLoading(false);
    } catch (e) {
      print(e);
      _error = ErrorHandler.handleError(e);
    }
  }

  void deleteUser(String id) async {
    try {
      final String url = kURLApi + "/users/$id";
      await NetworkHelper().delete(url: url);
      int index = _users.indexWhere((element) => element.id == id);
      _users.removeAt(index);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      print(e);
      _error = ErrorHandler.handleError(e);
    }
  }
}
