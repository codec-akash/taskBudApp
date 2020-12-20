import 'dart:convert';

import 'package:Taskbud/api/api_response_handler.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  static const BASE_URL = "https://testbudhelp.herokuapp.com/";

  Future<Map<String, dynamic>> getCall(String endPoint) async {
    var client = new http.Client();
    String url = BASE_URL + endPoint;
    try {
      var uriResponse = await client.get(
        url,
        headers: {},
      );
      return ApiResponseHandler.output(uriResponse);
    } catch (error) {
      return ApiResponseHandler.outputError();
    }
  }

  Future<Map<String, dynamic>> postNoAuth(String endPoint, payload) async {
    var client = new http.Client();
    String url = BASE_URL + endPoint;
    print(url);
    try {
      var uriResponse = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );
      print("objectAPI");
      print(uriResponse.body);
      return ApiResponseHandler.output(uriResponse);
    } catch (error) {
      return ApiResponseHandler.outputError();
    }
  }
}
