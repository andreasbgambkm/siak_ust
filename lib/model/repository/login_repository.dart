import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:siak/core/constants/constants.dart';
class LoginRepository {

  Future<http.Response> login(String id, String password){
    return http.post(
      Uri.parse("$BASE_URL$LOGIN"),
      headers: <String, String>{
        'Content-Type': "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      {
            'id': id,
            'password': password
      }
      )

    );
  }
}