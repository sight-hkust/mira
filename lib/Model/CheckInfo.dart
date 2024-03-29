import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../Utilities/Constant.dart';

Future<CheckInfo> getCheckInfo(bool isLeft, String patientID) async{

  try {
    final response = await http.get(
        '${Constants.URL_RECORD}?patientIDCard=${patientID}',
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      return CheckInfo.fromJson(json.decode(response.body), isLeft);
    } else {
      return null;
    }
  } catch (e){
    return null;
  }
}

class CheckInfo{
  final String vision_livingEyeSight;
  final String vision_bareEyeSight;
  final String vision_eyeGlasses;
  final String vision_bestEyeSight;
  final String vision_hole;
  final String opto_diopter;
  final String opto_astigmatism;
  final String opto_astigmatismaxis;
  final String slit_eyelid;
  final String slit_conjunctiva;
  final String slit_cornea;
  final String slit_lens;
  final String slit_Hirschbergtest;
  final String slit_chamber;
  final String eye_pressure;

  CheckInfo({this.vision_livingEyeSight, this.vision_bareEyeSight, this.vision_eyeGlasses, this.vision_bestEyeSight, this.vision_hole, this.opto_diopter, this.opto_astigmatism, this.opto_astigmatismaxis, this.slit_conjunctiva, this.slit_cornea, this.slit_eyelid, this.slit_Hirschbergtest, this.slit_lens, this.slit_chamber, this.eye_pressure});

  factory CheckInfo.fromJson(Map<String, dynamic> json, bool isLeft) {
    if (isLeft){
      return CheckInfo(
          vision_livingEyeSight: json['data'][0]['left_vision_livingEyeSight'],
          vision_bareEyeSight: json['data'][0]['left_vision_bareEyeSight'],
          vision_eyeGlasses: json['data'][0]['left_vision_eyeGlasses'],
          vision_bestEyeSight: json['data'][0]['left_vision_bestEyeSight'],
          vision_hole: json['data'][0]['left_vision_hole'],
          opto_diopter: json['data'][0]['left_opto_diopter'],
          opto_astigmatism: json['data'][0]['left_opto_astigmatism'],
          opto_astigmatismaxis: json['data'][0]['left_opto_astigmatismaxis'],
          slit_cornea: json['data'][0]['left_slit_cornea'],
          slit_conjunctiva: json['data'][0]['left_slit_conjunctiva'],
          slit_eyelid: json['data'][0]['left_slit_eyelid'],
          slit_Hirschbergtest: json['data'][0]['left_slit_Hirschbergtest'],
          slit_lens: json['data'][0]['left_slit_lens'],
          slit_chamber: json['data'][0]['left_slit_chamber'],
          eye_pressure: json['data'][0]['left_eye_pressure']
        //// TODO: Add the slit_exchage and slit_eyeball
      );
    }
    else{
      return CheckInfo(
          vision_livingEyeSight: json['data'][0]['right_vision_livingEyeSight'],
          vision_bareEyeSight: json['data'][0]['right_vision_bareEyeSight'],
          vision_eyeGlasses: json['data'][0]['right_vision_eyeGlasses'],
          vision_bestEyeSight: json['data'][0]['right_vision_bestEyeSight'],
          vision_hole: json['data'][0]['right_vision_hole'],
          opto_diopter: json['data'][0]['right_opto_diopter'],
          opto_astigmatism: json['data'][0]['right_opto_astigmatism'],
          opto_astigmatismaxis: json['data'][0]['right_opto_astigmatismaxis'],
          slit_conjunctiva: json['data'][0]['right_slit_conjunctiva'],
          slit_cornea: json['data'][0]['right_slit_cornea'],
          slit_eyelid: json['data'][0]['right_slit_eyelid'],
          slit_Hirschbergtest: json['data'][0]['right_slit_Hirschbergtest'],
          slit_lens: json['data'][0]['right_slit_lens'],
          slit_chamber: json['data'][0]['right_slit_chamber'],
          eye_pressure: json['data'][0]['right_eye_pressure']
      );
    }
  }
}
