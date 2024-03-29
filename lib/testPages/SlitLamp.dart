import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart';
import '../Utilities/Functions.dart';
import '../Utilities/string.dart';
import '../Utilities/AppBar.dart';
import '../Utilities/bottomForTestPages.dart';
import '../Utilities/CustomRadioButton.dart';
import '../Utilities/Constant.dart';
import '../Model/SlitLampTest.dart';

class SlitLamp extends StatefulWidget{
  // see if the arguments from last page is received
  bool isArgsReceived;
  // title of the page
  String test;
  // submitting progress, default is confirm button
  String progress;

  String patientName;
  String profileID;
  String dateOfBirth;

  SlitLamp({Key key}) :
      test = Strings.slitLamp,
      patientName = '',
      profileID = '',
      dateOfBirth = '',
      isArgsReceived = false,
      progress = Strings.confirm,
        super(key:key);

  @override
  _SlitLampState createState() => _SlitLampState();
}

class _SlitLampState extends State<SlitLamp> with SingleTickerProviderStateMixin{
  // control which tab the scaffold is showing
  TabController _tabController;

  // map storing the choice that user made in each multiple choice box
  Map<String, String> radioValue;

  // map storing the text controller of '其他'
  // e.g. formOtherController['眼臉左'] will return the text field controller inside the alert window
  //       the alert window only shows up when '其他' is pressed
  Map<String, TextEditingController> formOtherController;
  TextEditingController leftCenterAxisController;
  TextEditingController leftNearAxisController;
  TextEditingController rightCenterAxisController;
  TextEditingController rightNearAxisController;

  // map storing the value of '其他'
  // e.g. in alert window, user typed '盲了' in text field and confirm
  //       then, otherValue['眼臉左'] = '盲了'
  Map<String, String> otherValue;
  String leftCenterAxisValue;
  String leftNearAxisValue;
  String rightCenterAxisValue;
  String rightNearAxisValue;

  /// define back press action
  Future<bool> Function(BuildContext) backPressed = (BuildContext context) => Functions.onBackPressedAlert(
    context,
    Functions.backPage,
    Strings.leavingAlertQuestion,
  );

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);

    radioValue = Map();
    formOtherController = Map();
    leftCenterAxisController = TextEditingController();
    leftNearAxisController = TextEditingController();
    rightCenterAxisController = TextEditingController();
    rightNearAxisController = TextEditingController();
    otherValue = Map();
    leftCenterAxisValue = '';
    leftNearAxisValue = '';
    rightCenterAxisValue = '';
    rightNearAxisValue = '';
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// for controlling pages
  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// receive parameters from last page
    if(!widget.isArgsReceived){
      List<String> args = ModalRoute.of(context).settings.arguments;
      print(args);
      widget.profileID = args[1];
      widget.patientName = args[2];
      widget.dateOfBirth = args[3];
      widget.isArgsReceived = true;
    }

    return GestureDetector(
      /// dismissing keyboard
      onTap: (){ FocusScope.of(context).requestFocus(new FocusNode()); },

      /// define swipe action to next page
      onHorizontalDragEnd: (DragEndDetails details) => (details){
        if(details.primaryVelocity == 0){
          return;
        }

        if(details.primaryVelocity.compareTo(0) == -1){
          // left
          _nextPage(-1);
        }
        else _nextPage(1);
      },

      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(
          title: widget.test,
          showBackButton: true,
          showHomeButton: true,
          showLogoutButton: true,
          backPressed: backPressed,

          /// TO SHOW PATIENT NAME AND ITS ID
          bottomShowing: CustomBottomArea(patientName: widget.patientName, dateOfBirth: widget.dateOfBirth,),
        ),

        /// DOTS IN THE BOTTOM, showing which page
        bottomNavigationBar: PreferredSize(
            child: Container(
              height: 30.0,
              child: Center(
                child: TabPageSelector(controller: _tabController,),
              ),
            ),
            preferredSize: Size.fromHeight(30.0)
        ),

        body: Container(
          child: TabBarView(
            controller: _tabController,
              children: <Widget>[
                /// slit lamp view
                ListView(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0, bottom: 20.0),
                  children: <Widget>[
                    ///BUTTON ROWS, TEST ITEMS WITH LEFT EYE AND RIGHT EYE
                    Center(child: Text( Strings.slit_eyelid, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),
                    leftRightChoiceButtonList(Strings.slit_eyelid, Constants.eyelid),

                    Center(child: Text( Strings.slit_conjunctiva, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),
                    leftRightChoiceButtonList(Strings.slit_conjunctiva, Constants.conjunctiva),

                    Center(child: Text( Strings.slit_cornea, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),
                    leftRightChoiceButtonList(Strings.slit_cornea, Constants.cornea),

                    Center(child: Text( Strings.slit_lens, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),
                    leftRightChoiceButtonList(Strings.slit_lens, Constants.lens),

                    Center(child: Text(
                      Strings.slit_chamber, style: TextStyle(fontSize: Constants.normalFontSize + 5),
                    ),),
                    chamberButtonList(Strings.slit_chamber, Constants.chamber)
                    

                  ],
                ),

                /// hirschberg view
                ListView(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0, bottom: 20.0),
                  children: <Widget>[
                    /// 6. LIST OF TEST ITEMS IN HIRSCHBERG
                    Center(child: Text( Strings.slit_Hirschbergtest, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),
                    leftRightChoiceButtonList(Strings.slit_Hirschbergtest, Constants.hirschbergTest),

                    Center(child: Text( Strings.slit_exchange, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),
                    threeChoiceRowList(Strings.slit_exchange, Constants.exchange),

                    Center(child: Text( Strings.slit_eyeballshivering, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),
                    threeChoiceRowList(Strings.slit_eyeballshivering, Constants.eyeballShivering),

                  ],
                ),

                ListView(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0, bottom: 20.0),
                  children: thirdTabWidgets(),
                ),
              ]
          ),
        ),

        //Text(Strings.slitLamp),
      ),
    );
  }

  /*
    Control the layout of third page
   */
  List<Widget> thirdTabWidgets(){
    List<Widget> list = [];

    /// TITLE
    list.add( Center(child: Text( Strings.slit_otherShow, style: TextStyle(fontSize: Constants.normalFontSize + 5),),),);

    /// SHOWING OTHER VALUE IN THIS PAGE
    List<String> keys = otherValue.keys.toList();
    for(String key in keys){
      list.add(
        Card(
          color: Theme.of(context).disabledColor,
          child: ListTile(
            leading: Text(key,
              style: TextStyle(
                fontSize: Constants.normalFontSize
              ),
            ),

            title: Text(otherValue[key],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Constants.normalFontSize
              ),
            ),
          ),
        )
      );
    }

    list.add(
      /// CONFIRM BUTTON
      Center(child: SizedBox(
        height: MediaQuery.of(context).size.height * Constants.columnRatio,
        width: MediaQuery.of(context).size.width * 0.4,

        child: RaisedButton(
          // TODO: SLIT LAMP SUBMIT BUTTON

          onPressed: () async {
            setState(() {
              widget.progress = Strings.submitting;
            });

            // FACTORY THE OBJECT
            SlitlampTest newslitlampTest = new SlitlampTest(
                left_slit_conjunctiva: getData(Strings.slit_conjunctiva+Strings.left),
                right_slit_conjunctiva: getData(Strings.slit_conjunctiva+Strings.right),
                left_slit_cornea: getData(Strings.slit_cornea+Strings.left),
                right_slit_cornea: getData(Strings.slit_cornea+Strings.right),
                left_slit_eyelid: getData(Strings.slit_eyelid+Strings.left),
                right_slit_eyelid: getData(Strings.slit_eyelid+Strings.right),
                left_slit_lens: getData(Strings.slit_lens+Strings.left),
                right_slit_lens: getData(Strings.slit_lens+Strings.right),
                left_slit_Hirschbergtest: getData(Strings.slit_Hirschbergtest+Strings.left),
                right_slit_Hirschbergtest: getData(Strings.slit_Hirschbergtest+Strings.right),
                left_slit_chamber: getData(Strings.slit_chamber+Strings.left),
                right_slit_chamber: getData(Strings.slit_chamber+Strings.right),
                slit_exchange: getData(Strings.slit_exchange),
                slit_eyeballshivering: getData(Strings.slit_eyeballshivering),
                left_slit_chamber_center: getData(Strings.choice_centerAxis+Strings.left),
                left_slit_chamber_near: getData(Strings.choice_nearAxis+Strings.left),
                right_slit_chamber_center: getData(Strings.choice_centerAxis+Strings.right),
                right_slit_chamber_near: getData(Strings.choice_nearAxis+Strings.right),
                
            );
            SlitlampTest newData = await createSlitLampTest(widget.profileID, newslitlampTest.toMap()).timeout(const Duration(seconds: 10), onTimeout: (){ return null; });

            if(newData == null){
              /// CANNOT SUBMIT, SHOW ALERT AND CALL USER TO TRY AGAIN
              Functions.showAlert(
                  context,
                  Strings.cannotSubmit,
                  Functions.nothing
              );

              setState(() {
                widget.progress = Strings.confirm;
              });
            } else {
              /// finish alert here, press confirm to navigate to consultation page
              Functions.showAlert(context,
                  Strings.successRecord,
                      (BuildContext context){
                    Navigator.of(context).pop();
                    //Navigator.pushNamed(context, '/reviewProfile',
                    //  arguments: [Strings.reviewingProfile, widget.profileID, widget.patientName, widget.dateOfBirth, 'false'],
                    //);
                  });
            }
          },
          child: Text(widget.progress,
            style: TextStyle(fontSize: Constants.normalFontSize),
          ),
        ),
      ),),
    );

    return list;
  }


  /// BELOW IS THE SAME WITH OLD SLIP LAMP-----------------------------------------------

  // Decide to get data from othervalue or radiovalue
  String getData(String key){
    if (key == Strings.choice_centerAxis+Strings.left){
      return leftCenterAxisValue;
    }
    else if (key == Strings.choice_centerAxis+Strings.right){
      return rightCenterAxisValue;
    }
    else if (key == Strings.choice_nearAxis+Strings.left){
      return leftNearAxisValue;
    }
    else if (key == Strings.choice_nearAxis+Strings.right){
      return rightNearAxisValue;
    }
    else if (key == Strings.slit_chamber+Strings.right){
      if (otherValue[key] != null && otherValue[key] != ''){
        return otherValue[key];
      }
      else {
        return '';
      }
    }
    else if (key == Strings.slit_chamber+Strings.left){
      if (otherValue[key] != null && otherValue[key] != ''){
        return otherValue[key];
      }
      else {
        return '';
      }
    }
    String result;
    if (otherValue[key] != null && otherValue[key] != '') {
      result = otherValue[key];
    }
    else{
      result = radioValue[key];
    }
    return result;
  }

  /// Return a row of radio button
  /// @param:
  /// - choices (List of String): the text showing on the buttons
  /// - key (String): to search in radioValues
  Widget radioButtons(List<String> choices, String key){
    List<Widget> buttons = []; // temp. store the widgets need to create inside the row
    if(formOtherController[key] == null) formOtherController[key] = new TextEditingController();
    if(radioValue[key] == null) radioValue[key] = '';

    for(String choice in choices){
      // add gesture detectors with loop
      buttons.add(
          Expanded(
            // here we customize the button by gesture detector
              child: GestureDetector(

                /// 1. onTap:  define the action that user tapping the rectangular box
                  onTap: () {
                    // if the choice is other and other is not turned blue yet
                    if (choice == Strings.choice_others && radioValue[key] != choice) {
                      // show an alert window here to collect information
                      showDialog(context: context, builder: (context) =>
                          AlertDialog(
                            title: Text(key + Strings.slit_AlertQuestion),
                            content: TextField(
                              controller: formOtherController[key],
                            ),
                            actions: <Widget>[
                              // confirm button
                              FlatButton(
                                child: Text(Strings.confirm),
                                onPressed: (){
                                   // save the string to otherValue[]
                                  otherValue[key] = formOtherController[key].text;

                                  // set states
                                  if (radioValue[key] != choice)
                                    radioValue[key] = choice;
                                  else
                                    radioValue[key] = "";

                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                              // cancel button
                              FlatButton(
                                child: Text(Strings.cancel),
                                onPressed: () {
                                  // clear the controller if the user say cancel
                                  formOtherController[key].text = '';
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                      );
                    }
                    else {

                      // because the choice cannot be choosing other, or just cancel the choice, so clear controller
                      formOtherController[key].text = '';
                      // also clear the value stored
                      otherValue[key] = "";

                      // rebuild the whole widget by changing radio value, to make a certain cell become blur or not blue
                      // set radio values
                      if (radioValue[key] != choice)
                        radioValue[key] = choice;
                      else
                        radioValue[key] = "";
                      setState((){});
                    }
                  },

                  /// 2. Container, define the color and text inside the button box
                  child: Container(
                    height: MediaQuery.of(context).size.height * Constants.columnRatio,
                    child: Center(child: Text(choice,
                      style: TextStyle(fontSize: Constants.normalFontSize),
                      textAlign: TextAlign.center,
                    ),),
                    decoration: BoxDecoration(
                      // defines the color of the box, by following the radio value
                      color: (radioValue[key] == choice)?
                      Theme.of(context).hintColor: Theme.of(context).disabledColor,
                    ),
                  )
              ))
      );
    }

    // after adding all buttons within the string list, return a row
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }



  /// Return a single test form with left and right eye
  /// @param:
  /// - test (String): the name of the testing things
  /// - choice (List of String): the text showing on the buttons
  Container leftRightChoiceButtonList(String test, List<String> choices){
    return Container(
      // defining the box, with filled color and round edges
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Constants.boxBorderRadius)),
          color: Theme.of(context).disabledColor,
        ),
        child: SizedBox(
          width: double.infinity,
          child:Column(
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
        )
    );
  }

  /// Return a column with rows of radio buttons
  /// each row contains 3 radio buttons
  /// @param:
  /// - test (String): the name of the testing things
  /// - choice (List of String): the text showing on the buttons
  Container threeChoiceRowList(String test, List<String> choices){
    List<Widget> columnList = [];
    List<String> choiceList = [];

    // dividing the string list with 3 string one row, and send to radioButtons() to build buttons for it
    int counter = 0;
    for(String choice in choices){
      choiceList.add(choice);
      if(counter % 3 == 2 || counter == choices.length - 1){
        columnList.add(radioButtons(choiceList, test));
        choiceList = [];
      }
      ++ counter;
    }

    // return a container storing all rows built above
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Constants.boxBorderRadius)),
        color: Theme.of(context).disabledColor,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: columnList,
        ),
      ),
    );
  }

  // Return a button for the chamber checking items
  Widget chamberButtons(List<String> choices, String key){
    List<Widget> buttons = [];

    // We need to Initiate these controller before we set them as controller
    // Else we cannot use them later
    if (leftCenterAxisController == null){
      leftCenterAxisController = new TextEditingController();
    }
    if (leftNearAxisController == null){
      leftNearAxisController = new TextEditingController();
    }
    if (rightCenterAxisController == null){
      rightCenterAxisController = new TextEditingController();
    }
    if (rightNearAxisController == null){
      rightNearAxisController = new TextEditingController();
    }
    if (formOtherController[Strings.slit_chamber + key] == null){
      formOtherController[Strings.slit_chamber + key] = new TextEditingController();
    }

    for (String choice in choices){
      buttons.add(
        Expanded(
          child: GestureDetector(
            onTap: (){
              if (choice == Strings.choice_centerAxis){
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text(key + Strings.choice_centerAxis),
                  content: TextField(
                    controller: (key == Strings.left)?leftCenterAxisController:rightCenterAxisController
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        Strings.confirm),
                      onPressed: (){
                        if (key == Strings.left){
                          leftCenterAxisValue = leftCenterAxisController.text;
                        }
                        else{
                          rightCenterAxisValue = rightCenterAxisController.text;
                        }

                        setState(() {});
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(Strings.cancel),
                      onPressed: (){
                        if (key == Strings.left){
                          leftCenterAxisController.text = '';
                        }
                        else{
                          rightCenterAxisController.text = '';
                        }

                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
              }
              else if (choice == Strings.choice_nearAxis){
                showDialog(
                  context: context,
                  builder: (context) =>
                    AlertDialog(
                      title: Text(key + Strings.choice_nearAxis),
                      content: TextField(
                        controller: (key == Strings.left)?leftNearAxisController:rightNearAxisController
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            Strings.confirm),
                          onPressed: (){
                            if (key == Strings.left){
                              leftNearAxisValue = leftNearAxisController.text;
                            }
                            else{
                              rightNearAxisValue = rightNearAxisController.text;
                            }

                            setState(() {
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                        FlatButton(
                          child: Text(Strings.cancel),
                          onPressed: (){
                            if (key == Strings.left){
                              leftNearAxisController.text = '';
                            }
                            else{
                              rightNearAxisController.text = '';
                            }

                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )
                );
              }
              else{
                showDialog(context: context, builder: (context) => 
                  AlertDialog(
                    title: Text(Strings.slit_chamber + key + Strings.slit_AlertQuestion),
                    content: TextField(
                      controller: formOtherController[Strings.slit_chamber + key],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(Strings.confirm),
                        onPressed: (){
                          otherValue[Strings.slit_chamber + key] = formOtherController[Strings.slit_chamber + key].text;

                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(Strings.cancel),
                        onPressed: (){
                          formOtherController[Strings.slit_chamber + key].text = '';
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height * Constants.columnRatio,
              child: Center(child: Text(choice, style: TextStyle(fontSize: Constants.normalFontSize), textAlign: TextAlign.center,),),
            ),
          ),
        )
      );
    }

    // return the buttons row 
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );


  }

  /// Widget for chamber row
  Container chamberButtonList(String test, List<String> choices){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Constants.boxBorderRadius)),
        color: Theme.of(context).disabledColor,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            // The row for right eye
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * Constants.columnRatio,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Center(child: Text(Strings.right, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Constants.normalFontSize),),),
                ),
                // buttons for chamber options
                Expanded(child: chamberButtons(choices, Strings.right),),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,)
              ],
            ),
            // The row for left eye
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * Constants.columnRatio,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Center(child: Text(Strings.left, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Constants.normalFontSize),),),
                ),
                // buttons for chamber options
                Expanded(child: chamberButtons(choices, Strings.left),),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,)
              ],
            )
          ],
        ),
      ),
    );
  }
}