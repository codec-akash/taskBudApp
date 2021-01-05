import 'dart:convert';

import 'package:Taskbud/api/api_call.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/models/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  LoginResponse loginResponse;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> login(String email, String password) async {
    final url = "user/login";
    Map<String, dynamic> payload = {
      "email": email,
      "password": password.trim(),
    };
    try {
      Map<String, dynamic> response = await ApiCall().postNoAuth(url, payload);
      if (response["error"] != null) {
        loginResponse = LoginResponse.fromJson(response["error"]);
        throw HttpException(loginResponse.message);
      }
      loginResponse = LoginResponse.fromJson(response["result"]);
      _token = loginResponse.token;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'token': _token});
      prefs.setString('userToken', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(
      {String email, String password, String name, String phoneNumber}) async {
    final url = "user/register";
    Map<String, dynamic> payload = {
      "email": email.trim(),
      "password": password.trim(),
      "first_name": name.trim(),
      "phonenumber": phoneNumber.trim(),
    };
    try {
      Map<String, dynamic> response = await ApiCall().postNoAuth(url, payload);
      if (response["error"] != null) {
        loginResponse = LoginResponse.fromJson(response["error"]);
        throw HttpException(loginResponse.message);
      }
      loginResponse = LoginResponse.fromJson(response["result"]);
      _token = loginResponse.token;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'token': _token});
      prefs.setString('userToken', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> resetPassword(String oldPassword, String password) async {
    final url = "user/resetPassword";
    Map<String, dynamic> payload = {
      "oldPassword": oldPassword.trim(),
      "password": password.trim(),
    };
    try {
      Map<String, dynamic> response =
          await ApiCall().patchAuth(url, token, payload);
      if (response["error"] != null) {
        loginResponse = LoginResponse.fromJson(response["error"]);
        print("HELLO WORLD ${loginResponse.message}");
        throw HttpException(loginResponse.message ?? "Error Occured");
      }
      loginResponse = LoginResponse.fromJson(response["result"]);
      print(loginResponse.message);
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userToken')) as Map<String, Object>;

    _token = extractedData['token'];
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
