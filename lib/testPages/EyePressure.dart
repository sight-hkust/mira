import 'package:flutter/material.dart';
import 'package:myapp/Utilities/bottomForTestPages.dart';
import 'package:myapp/Utilities/string.dart';
import 'package:myapp/Utilities/Functions.dart';
import 'package:myapp/Utilities/AppBar.dart';
import 'package:myapp/Utilities/Constant.dart';
import 'package:myapp/Utilities/bottomForTestPages.dart';
import 'package:myapp/Model/PressureTest.dart';

class EyePressure extends StatefulWidget{
  bool isArgReceived;
  String test;
  String progress;
  
  // For the header of test page
  String patientName;
  String profileID;
  String dateOfBirth;

  EyePressure({Key key}) :
    isArgReceived = false,
    progress = Strings.confirm,
    super(key: key);

  @override
  _EyePressureState createState() => _EyePressureState();
}

class _EyePressureState extends State<EyePressure>{
  TextEditingController rightFieldController;
  TextEditingController leftFieldController;

  Future<bool> Function(BuildContext) backPressed = (BuildContext context) => Functions.onBackPressedAlert(context, Functions.backPage, Strings.leavingAlertQuestion);

  @override
  void initState() {
    rightFieldController = TextEditingController();
    leftFieldController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    // Get the parameters from UserSearch
    if (!widget.isArgReceived){
      List<String> args = ModalRoute.of(context).settings.arguments;
      widget.test = args[0];
      widget.profileID = args[1];
      widget.patientName = args[2];
      widget.dateOfBirth = args[3];
      widget.isArgReceived = true;
    }

    return WillPopScope(
      onWillPop: () => backPressed(context),
      child: GestureDetector(
        // Dismiss the keyboard when we tap around
        onTap: (){ FocusScope.of(context).requestFocus(new FocusNode());},
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Theme.of(context).backgroundColor,

          appBar: CustomAppBar(
            title: widget.test,
            showBackButton: true,
            showHomeButton: true,
            showLogoutButton: true,
            backPressed: backPressed,
          
            // Show the header with patient information
            bottomShowing: CustomBottomArea(patientName: widget.patientName, dateOfBirth: widget.dateOfBirth,),
          ),

          body: ListView(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0, bottom: 20.0),
            children: generateLayout(),
          ),

        ),
      ),
    );
  }

  Widget customInputRow(String testItem, bool isRight){

    // Initiate all textEditing Controller
    if (isRight && rightFieldController == null){
      rightFieldController = new TextEditingController();
    }
    if (!isRight && leftFieldController == null){
      leftFieldController = new TextEditingController();
    }

    return Container(
      height: MediaQuery.of(context).size.height*0.1,

      child: Card(
        color: Theme.of(context).disabledColor,
        child: ListTile(
          leading: Text(testItem, style: TextStyle(fontSize: Constants.normalFontSize),),
          title: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: Strings.typeHere,
              hintStyle: TextStyle(
                color: Theme.of(context).buttonColor
              )
            ),
            controller: (isRight)? rightFieldController : leftFieldController,
            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontSize: Constants.normalFontSize
            ),
          ),
        ),
      )
    );
  }

  List<Widget> generateLayout(){
    List<Widget> widgets = [];

    // The right eye title
    widgets.add(
      Text(Strings.right, style: TextStyle(
        fontSize: Constants.headingFontSize
      ),)
    );

    // The text Filed
    widgets.add(customInputRow(Strings.eyePressure_pressure, true));

    // The left eye title
    widgets.add(
      Text(Strings.left, style: TextStyle(
        fontSize: Constants.headingFontSize
      ))
    );

    // The text field
    widgets.add(customInputRow(Strings.eyePressure_pressure, false));

    widgets.add(SizedBox(height: MediaQuery.of(context).size.height*0.02));

    // Confirm button
    widgets.add(
      GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.2,

          decoration: BoxDecoration(
            color: Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(Constants.boxBorderRadius),
          ),

          child: Center(
            child: Text(widget.progress, style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: Constants.normalFontSize,
            ),),
          ),
        ),

        onTap: () async{
          setState(() {
            widget.progress = Strings.submitting;
          });

          PressureTest pressureTest = new PressureTest(
            left_eye_pressure: (leftFieldController == null)?'':leftFieldController.text,
            right_eye_pressure: (rightFieldController == null)?'':rightFieldController.text
          );

          PressureTest newData = await createPressureTest(widget.profileID, body: pressureTest.toMap()).timeout(const Duration(seconds: 10), onTimeout: (){return null;});

          if (newData != null) {
            Functions.showAlert(context, Strings.successRecord, Functions.backPage);
          } else{
            Functions.showAlert(context, Strings.cannotSubmit, Functions.nothing);
            setState(() {
              widget.progress = Strings.confirm;
            });
          }
        },
      )
    );

    widgets.add(SizedBox(height: MediaQuery.of(context).viewInsets.bottom,));

    return widgets;
  }
}