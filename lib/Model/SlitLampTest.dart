import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:myapp/Utilities/Constant.dart';

Future<SlitlampTest> createSlitLampTest(String patientID, Map body) async{
  try{
    return http.patch('${Constants.URL_RECORD}?patientIDCard=${patientID}', body: body).then((http.Response response){
      final int statusCode = response.statusCode;

      //print(statusCode);
      //print(response.body);

      if (statusCode < 200 || statusCode > 400 || json == null){
        return null;
      }
      final rep = json.decode(response.body);
      final repJson = rep[0];
      return SlitlampTest.fromJson(repJson);
    });
  } catch(e){
    return null;
  }
}

class SlitlampTest{
  final String left_slit_eyelid;
  final String right_slit_eyelid;
  final String left_slit_conjunctiva;
  final String right_slit_conjunctiva;
  final String left_slit_cornea;
  final String right_slit_cornea;
  final String left_slit_lens;
  final String right_slit_lens;
  final String left_slit_Hirschbergtest;
  final String right_slit_Hirschbergtest;
  final String left_slit_chamber;
  final String right_slit_chamber;
  final String left_slit_chamber_center;
  final String left_slit_chamber_near;
  final String right_slit_chamber_center;
  final String right_slit_chamber_near;
  final String slit_exchange;
  final String slit_eyeballshivering;

  SlitlampTest({this.left_slit_conjunctiva, this.left_slit_cornea, this.left_slit_eyelid, this.left_slit_Hirschbergtest, this.left_slit_lens, this.right_slit_conjunctiva, this.right_slit_cornea, this.right_slit_eyelid, this.right_slit_Hirschbergtest, this.right_slit_lens, this.slit_exchange, this.slit_eyeballshivering, this.left_slit_chamber, this.right_slit_chamber, this.left_slit_chamber_center, this.left_slit_chamber_near, this.right_slit_chamber_center, this.right_slit_chamber_near});

  factory SlitlampTest.fromJson(Map<String, dynamic> json){
    return SlitlampTest(
      left_slit_eyelid: json['left_slit_eyelid'],
      right_slit_eyelid: json['right_slit_eyelid'],
      left_slit_conjunctiva: json['left_slit_conjunctiva'],
      right_slit_conjunctiva: json['right_slit_conjunctiva'],
      left_slit_cornea: json['left_slit_cornea'],
      right_slit_cornea: json['right_slit_cornea'],
      left_slit_lens: json['left_slit_lens'],
      right_slit_lens: json['right_slit_lens'],
      left_slit_Hirschbergtest: json['left_slit_Hirschbergtest'],
      right_slit_Hirschbergtest: json['right_slit_Hirschbergtest'],
      left_slit_chamber: json['left_slit_chamber'],
      right_slit_chamber: json['right_slit_chamber'],
      slit_exchange: json['slit_exchange'],
      slit_eyeballshivering: json['slit_eyeballshivering'],
      left_slit_chamber_center: json['left_slit_chamber_center'],
      left_slit_chamber_near: json['left_slit_chamber_near'],
      right_slit_chamber_center: json['right_slit_chamber_center'],
      right_slit_chamber_near: json['right_slit_chamber_near']
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['left_slit_eyelid'] = left_slit_eyelid;
    map['right_slit_eyelid'] = right_slit_eyelid;
    map['left_slit_conjunctiva'] = left_slit_conjunctiva;
    map['right_slit_conjunctiva'] = right_slit_conjunctiva;
    map['left_slit_cornea'] = left_slit_cornea;
    map['right_slit_cornea'] = right_slit_cornea;
    map['left_slit_lens'] = left_slit_lens;
    map['right_slit_lens'] = right_slit_lens;
    map['left_slit_Hirschbergtest'] = left_slit_Hirschbergtest;
    map['right_slit_Hirschbergtest'] = right_slit_Hirschbergtest;
    map['left_slit_chamber'] = left_slit_chamber;
    map['right_slit_chamber'] = right_slit_chamber;
    map['slit_exchange'] = slit_exchange;
    map['slit_eyeballshivering'] = slit_eyeballshivering;
    map['left_slit_chamber_center'] = left_slit_chamber_center;
    map['left_slit_chamber_near'] = left_slit_chamber_near;
    map['right_slit_chamber_center'] = right_slit_chamber_center;
    map['right_slit_chamber_near'] = right_slit_chamber_near;

    return map;
  }
}
