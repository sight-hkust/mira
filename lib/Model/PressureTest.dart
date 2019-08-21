import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:myapp/Utilities/Constant.dart';

Future<PressureTest> createPressureTest(String patientID, {Map<String, dynamic> body}) async {
  try{
    final response = await http.patch('${Constants.URL_RECORD}?patientIDCard=${patientID}', body: body);

    if (response.statusCode == 200){
      final rep = json.decode(response.body);
      final repJson = rep[0];
      return PressureTest.fromJson(repJson);
    }
    else{
      return null;
    }
  }catch(e) {
    return null;
  }
}

class PressureTest{
  final String left_eye_pressure;
  final String right_eye_pressure;

  PressureTest({this.left_eye_pressure, this.right_eye_pressure});

  factory PressureTest.fromJson(Map<String, dynamic> json){
    return PressureTest(
      left_eye_pressure: json["left_eye_pressure"],
      right_eye_pressure: json["right_eye_pressure"]
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();

    map['left_eye_pressure'] = left_eye_pressure;
    map['right_eye_pressure'] = right_eye_pressure;

    return map;
  }
}