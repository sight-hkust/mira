import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:myapp/Utilities/Constant.dart';

Future<ConsultRecord> createConsultRecord(String patientID, Map body) async{
   try{
     return http.patch('${Constants.URL_RECORD}?patientIDCard=${patientID}', body: body).then((http.Response response){
       final int statusCode = response.statusCode;

       if (statusCode < 200 || statusCode > 400 || json == null){
         return null;
       }
       final rep = json.decode(response.body);
       final repJson = rep[0];
       return ConsultRecord.fromReturnJson(repJson);
     });
   } catch (e){
     return null;
   }
}

Future<ConsultRecord> getConsultRecord(String patientID) async{
  try{
    final response = await http.get('${Constants.URL_RECORD}?patientIDCard=${patientID}', headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      return ConsultRecord.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  } catch (e){
    return null;
  }
}

class ConsultRecord{
  final String problemOther;
  final String problemNormaleyesight;
  final String problemAbonormaldiopter;
  final String problemStrabismus;
  final String problemTrichiasis;
  final String problemConjunctivitis;
  final String problemCataract;
  final String problemPterygium;
  final String problemGlaucosis;
  final String problemDR;
  final String problemMGD;
  final String handle;
  final String furtherreview;
  final String furtheropt;
  final String cataractOpt;
  final String cataractNoOpt;


  ConsultRecord({this.handle, this.furtheropt, this.furtherreview, this.problemOther, this.problemNormaleyesight, this.problemAbonormaldiopter, this.problemStrabismus, this.problemTrichiasis, this.problemConjunctivitis, this.problemCataract, this.problemDR, this.problemMGD, this.problemGlaucosis, this.problemPterygium, this.cataractOpt, this.cataractNoOpt});

  factory ConsultRecord.fromJson(Map<String, dynamic> json){
    return ConsultRecord(
      handle: json['data'][0]['handle'],
      furtherreview: json['data'][0]['furtherreview'],
      furtheropt: json['data'][0]['furtheropt'],
      problemOther: json['data'][0]['problemOther'],
      problemNormaleyesight: json['data'][0]['problemNormaleyesight'],
      problemAbonormaldiopter: json['data'][0]['problemAbonormaldiopter'],
      problemStrabismus: json['data'][0]['problemStrabismus'],
      problemTrichiasis: json['data'][0]['problemTrichiasis'],
      problemConjunctivitis: json['data'][0]['problemConjunctivitis'],
      problemCataract: json['data'][0]['problemCataract'],
      problemDR: json['data'][0]['problemDR'],
      problemMGD: json['data'][0]['problemMGD'],
      problemGlaucosis: json['data'][0]['problemGlaucosis'],
      problemPterygium: json['data'][0]['problemPterygium'],
      cataractOpt: json['data'][0]['cataractOpt'],
      cataractNoOpt: json['data'][0]['cataractNoOpt'],
    );
  }

  factory ConsultRecord.fromReturnJson(Map<String, dynamic> json){
    return ConsultRecord(
      handle: json['handle'],
      furtherreview: json['furtherreview'],
      furtheropt: json['furtheropt'],
      problemOther: json['problemOther'],
      problemNormaleyesight: json['problemNormaleyesight'],
      problemAbonormaldiopter: json['problemAbonormaldiopter'],
      problemStrabismus: json['problemStrabismus'],
      problemTrichiasis: json['problemTrichiasis'],
      problemConjunctivitis: json['problemConjunctivitis'],
      problemCataract: json['problemCataract'],
      problemDR: json['problemDR'],
      problemMGD: json['problemMGD'],
      problemGlaucosis: json['problemGlaucosis'],
      problemPterygium: json['problemPterygium'],
      cataractOpt: json['cataractOpt'],
      cataractNoOpt: json['cataractNoOpt'],
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();

    map['handle'] = handle;
    map['furtheropt'] = furtheropt;
    map['furtherreview'] = furtherreview;
    map['problemOther'] = problemOther;
    map['problemNormaleyesight'] = problemNormaleyesight;
    map['problemAbonormaldiopter'] = problemAbonormaldiopter;
    map['problemStrabismus'] = problemStrabismus;
    map['problemTrichiasis'] = problemTrichiasis;
    map['problemConjunctivitis'] = problemConjunctivitis;
    map['problemCataract'] = problemCataract;
    map['problemDR'] = problemDR;
    map['problemMGD'] = problemMGD;
    map['problemGlaucosis'] = problemGlaucosis;
    map['problemPterygium'] = problemPterygium;
    map['cataractOpt'] = cataractOpt;
    map['cataractNoOpt'] = cataractNoOpt;

    return map;
  }
}

// Updated
