import 'package:flutter/material.dart';
import 'package:myapp/Utilities/AppBar.dart';
import 'package:myapp/Utilities/bottomForTestPages.dart';
import 'package:myapp/Utilities/string.dart';
import 'package:myapp/Utilities/Functions.dart';
import 'package:myapp/Utilities/Constant.dart';
import 'package:myapp/Model/EyePhotoTest.dart';

class EyePhoto extends StatefulWidget{
  bool isArgReceived;
  String test;
  String progress;

  String patientName;
  String idNumber;
  String dateOfBirth;

  EyePhoto({Key key}):
    test = Strings.eyePhoto,
    patientName = '',
    idNumber = '',
    dateOfBirth = '',
    isArgReceived = false,
    progress = Strings.confirm,
    super(key:key);

  @override
  _EyePhotoState createState() => _EyePhotoState();
}

class _EyePhotoState extends State<EyePhoto>{
  Map<String, String> radioValue;
  Map<String, TextEditingController> formOtherController;
  Map<String, String> otherValue;

  Future<bool> Function(BuildContext) backPressed = (BuildContext context) => Functions.onBackPressedAlert(context, Functions.backPage, Strings.leavingAlertQuestion,);

  @override
  void initState() {
    radioValue = Map();
    formOtherController = Map();
    otherValue = Map();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    if (!widget.isArgReceived){
      List<String> args = ModalRoute.of(context).settings.arguments;
      widget.idNumber = args[1];
      widget.patientName = args[2];
      widget.dateOfBirth = args[3];
      widget.isArgReceived = true;
    }

    return GestureDetector(
      /// dismissing keyboard
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },

      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(
          title: widget.test,
          showBackButton: true,
          showHomeButton: true,
          showLogoutButton: true,
          backPressed: backPressed,

          bottomShowing: CustomBottomArea(
            patientName: widget.patientName,
            dateOfBirth: widget.dateOfBirth,
          ),
        ),
        
        body: ListView(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0, bottom: 20.0),
          children: <Widget>[
            // The title
            Center(child: Text(Strings.eyePhoto, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),

            // The button list
            leftRightChoiceButtonList(Strings.eyePhoto_photo, Constants.eyePhoto),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            Center(child: SizedBox(
              height: MediaQuery.of(context).size.height * Constants.columnRatio,
              width: MediaQuery.of(context).size.width * 0.4,

              child: RaisedButton(
                onPressed: () async {
                  setState(() {
                    widget.progress = Strings.submitting;
                  });

                  EyePhotoTest newEyePhotoTest = new EyePhotoTest(
                    left_eye_photo: getData(Strings.eyePhoto_photo+Strings.left),
                    right_eye_photo: getData(Strings.eyePhoto_photo+Strings.right),
                  );

                  EyePhotoTest newData = await createEyePhotoTest(widget.idNumber, newEyePhotoTest.toMap()).timeout(const Duration(seconds: 10), onTimeout: (){return null;});

                  if (newData == null) {
                    Functions.showAlert(
                      context, 
                      Strings.cannotSubmit, 
                      Functions.nothing
                    );

                    setState(() {
                      widget.progress = Strings.confirm;
                    });
                  } else {
                    Functions.showAlert(
                      context, 
                      Strings.successRecord, 
                      (BuildContext context){
                        Navigator.of(context).pop();
                      });
                  }
                  
                },
                child: Text(widget.progress, style: TextStyle(fontSize: Constants.normalFontSize),),
              ),
            ),)
          ],
        ),
      ),
    );
  }

  String getData(String key){
    String result;
    if (otherValue[key] != null && otherValue[key] != '') {
      result = otherValue[key];
    }
    else{
      result = radioValue[key];
    }
    return result;
  }

  Widget radioButtons(List<String> choices, String key){
    List<Widget> buttons = [];

    if (formOtherController[key] == null) {
      formOtherController[key] = new TextEditingController();
    }
    if (radioValue[key] == null) {
      radioValue[key] = '';
    }

    for (String choice in choices){
      buttons.add(
        Expanded(
          child: GestureDetector(
            onTap: (){
              if (choice == Strings.choice_others && radioValue[key] != choice) {
                showDialog(context: context, builder: (context) =>
                  AlertDialog(
                    title: Text(key + Strings.slit_AlertQuestion),
                    content: TextField(
                      controller: formOtherController[key],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(Strings.confirm),
                        onPressed: (){
                          otherValue[key] = formOtherController[key].text;

                          // set states
                          if (radioValue[key] != choice){
                            radioValue[key] = choice;
                          }
                          else {
                            radioValue[key] = "";
                          }

                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(Strings.cancel),
                        onPressed: (){
                          formOtherController[key].text = '';
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  )
                );
              }
              else {
                formOtherController[key].text = '';
                otherValue[key] = "";

                if (radioValue[key] != choice) {
                  radioValue[key] = choice;
                }
                else {
                  radioValue[key] = "";
                }
                setState(() {});
              }
            },

            child: Container(
              height: MediaQuery.of(context).size.height * Constants.columnRatio,
              child: Center(child: Text(choice, style: TextStyle(fontSize: Constants.normalFontSize),
              textAlign: TextAlign.center,),),
              decoration: BoxDecoration(
                color: (radioValue[key] == choice)?
                Theme.of(context).hintColor: Theme.of(context).disabledColor,
              ),
            ),
          ),
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }

  Container leftRightChoiceButtonList(String test, List<String> choices) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Constants.boxBorderRadius)),
        color: Theme.of(context).disabledColor,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
              /// 1. row of right eye, having a "右" and a row of radio buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * Constants.columnRatio,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(child: Text(Strings.right,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Constants.normalFontSize),
                    ),),
                  ),
                  // buttons of a single row is called to construct here
                  Expanded(child: radioButtons(choices, test + Strings.right)),
                  // padding
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                ],
              ),
              /// 2. row of left eye, basically same with right eye
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * Constants.columnRatio,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(child: Text(Strings.left,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Constants.normalFontSize),
                    ),),
                  ),
                  // buttons of a single row is called to construct here
                  Expanded(child: radioButtons(choices, test + Strings.left)),
                  // padding
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                ],
              ),
          ],
        ),
      ),
    );
  }
}