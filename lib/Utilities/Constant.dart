import 'string.dart';

class Constants{
  /// FOR LAYOUT
  static const double appBarTitleFontSize = 25.0;
  static const double appBarPreferredSize = 54.0;
  static const double appBarBottomSize = 80.0;
  static const double appBarBottomFontSize = 18.0;

  static const double labelTextSize = 20.0;
  static const double boxBorderRadius = 9.0;

  static const double headingFontSize = 40.0;
  static const double normalFontSize = 20.0;

  static const double columnRatio = 0.08;
  static const int rowCount = 3;

  static const slitLampTabNumber = 4;
  static const consultationTabNumber = 5;

  /// FOR BUILDING TESTPAGES
  static const List<String> visionTest = [Strings.vision_bareEyeSight, Strings.vision_eyeGlasses, Strings.vision_hole];
  static const List<String> optometry =[Strings.opto_diopter, Strings.opto_astigmatism, Strings.opto_astigmatismaxis];

  // slit lamp
  static const List<String> eyelid = [Strings.choice_normal, Strings.choice_upperLidDrooping, Strings.con_trichiasis, Strings.choice_MGD, Strings.choice_others];
  static const List<String> conjunctiva = [Strings.choice_normal, Strings.choice_bloodFilled,Strings.choice_pterygium, Strings.choice_others];
  static const List<String> cornea = [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_others];
  static const List<String> lens = [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_absent, Strings.choice_IOL, Strings.choice_others];
  static const List<String> chamber = [Strings.choice_centerAxis, Strings.choice_nearAxis, Strings.choice_others];

  // Eye photo
  static const List<String> eyePhoto = [Strings.choice_normal, Strings.choice_notNormal, Strings.choice_others];

  // hirschberg
  static const List<String> hirschbergTest = [Strings.choice_normal, Strings.choice_lookoutward, Strings.choice_lookinward, Strings.choice_lookupward, Strings.choice_notabletostare];
  static const List<String> exchange = [Strings.choice_notmoving, Strings.choice_outsidetomiddle, Strings.choice_insidetomiddle, Strings.choice_uppertomiddle, Strings.choice_inneruppertomiddle, Strings.choice_outeruppertomiddle];
  static const List<String> eyeballShivering = [Strings.choice_nothing, Strings.choice_shown, Strings.choice_notshown, Strings.choice_both];

  // consultation
  static const List<String> consultation = [Strings.con_normaleyesight, Strings.con_abonormaldiopter, Strings.con_strabismus, Strings.con_trichiasis, Strings.con_conjunctivitis, Strings.con_cataract, Strings.choice_pterygium, Strings.con_glaucosis, Strings.con_DR, Strings.choice_MGD, Strings.choice_others];

  /// FOR CONNECTING TO SERVER
  
  /// SIGHT server
  //static const URL_STU = 'https://api.sightseeing.projects.sight.ust.hk/students';
  //static const URL_RECORD = 'https://api.sightseeing.projects.sight.ust.hk/check-record';
  
  /// Hospital Server
  static const URL_STU = 'http://sight.jsiec.org/students';
  static const URL_RECORD = 'http://sight.jsiec.org/check-record';
  static const URL_AUTH = 'http://sight.jsiec.org/authentication/';

  /// Local server
  // static const URL_STU = 'http://localhost:8080/students';
  // static const URL_RECORD = 'http://localhost:8080/check-record';
  // static const URL_AUTH = 'http://localhost:8080/authentication';
}