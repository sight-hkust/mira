import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../Utilities/Constant.dart';

Future<bool> login(String userName, String password) async{
  try{
    return http.post(Constants.URL_AUTH, body: {
      'strategy': 'local',
      'userName': userName,
      'password': password
    }).then(
      // response is the response we get after async wait
      (http.Response response){
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode >= 400 || json == null){
          return false;
        }
        
        // If it is valid login
        return true;

      }
    );
  }
  catch(e){
    return false;
  }
}