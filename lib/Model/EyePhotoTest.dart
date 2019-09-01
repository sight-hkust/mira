import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../Utilities/Constant.dart';

Future<EyePhotoTest> createEyePhotoTest(String patientID, Map body) async {
  try {
    return http.patch('${Constants.URL_RECORD}?patientIDCard=${patientID}', body: body).then((http.Response response){
      final int statusCode = response.statusCode;

      //print(statusCode);
      //print(response.body);

      if (statusCode < 200 || statusCode > 400 || json == null){
        return null;
      }
      final rep = json.decode(response.body);
      final repJson = rep[0];
      return EyePhotoTest.fromJson(repJson);
    });
  } catch(e) {
    return null;
  }
}

class EyePhotoTest{
  final String left_eye_photo;
  final String right_eye_photo;

  EyePhotoTest({this.left_eye_photo, this.right_eye_photo});

  factory EyePhotoTest.fromJson(Map<String, dynamic> json) {
    return EyePhotoTest(
      left_eye_photo: json['left_eye_photo'],
      right_eye_photo: json['right_eye_photo'],
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['left_eye_photo'] = left_eye_photo;
    map['right_eye_photo'] = right_eye_photo;
    return map;
  }
}