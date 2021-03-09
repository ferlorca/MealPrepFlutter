import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  static final NetworkHelper _networkHelper = NetworkHelper._internal();

  factory NetworkHelper() {
    return _networkHelper;
  }

  String _token = "";
  Map<String, String> header;

  set token(String newToken) {
    this._token = newToken;
    this.header = {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }

  Future<dynamic> get({String url}) async {
    final uri = Uri.parse(url);
    try {
      http.Response response = await http.Client().get(uri, headers: header);
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print(response);
        throw "error en http";
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> post({String url, body}) async {
    final uri = Uri.parse(url);
    try {
      http.Response response = await http.Client().post(
        uri,
        headers: header,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        throw PlatformException(
          code: response.statusCode.toString(),
          message: jsonDecode(response.body).message,
        );
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> patch({String url, body}) async {
    final uri = Uri.parse(url);
    try {
      http.Response response = await http.Client().patch(
        uri,
        headers: header,
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        throw PlatformException(
          code: response.statusCode.toString(),
          message: jsonDecode(response.body).message,
        );
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> delete({String url}) async {
    final uri = Uri.parse(url);
    try {
      http.Response response = await http.Client().delete(
        uri,
        headers: header,
      );

      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        throw PlatformException(
          code: response.statusCode.toString(),
          message: jsonDecode(response.body).message,
        );
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  NetworkHelper._internal();
}
