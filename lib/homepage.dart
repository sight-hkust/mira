import 'package:flutter/material.dart';
import 'Utilities/string.dart';
import 'Utilities/AppBar.dart';
import 'Utilities/Functions.dart';
import 'Utilities/Constant.dart';

class HomePage extends StatelessWidget{
  String id;

  HomePage({Key key}) :
        id = null,
        super(key: key);

  /// define back press action
  Future<bool> Function(BuildContext) backPressed = (BuildContext context) => Functions.onBackPressedAlert(
    context,
    Functions.logout,
    Strings.logoutAlertQuestion,
  );

  /// Function to unify the layout of the buttons
  /// provide tap action with assets image path to build the button
  GestureDetector customizeIconButton(BuildContext context, Function() tapAction, String imagePath, String hintText, double heightRatio, double widthRatio){
    return GestureDetector(
      onTap: tapAction,

      child: Container(
        height: MediaQuery.of(context).size.height * heightRatio,
        width: MediaQuery.of(context).size.width * widthRatio,

        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(Constants.boxBorderRadius),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            // resized image
            Container(
              height: MediaQuery.of(context).size.height * heightRatio / 7 * 4,
              width: MediaQuery.of(context).size.width * widthRatio / 7 * 4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fill
                ),
              ),
            ),

            // hint text
            Text( hintText,
              style: TextStyle(
                  fontSize: Constants.normalFontSize,
                  color: Theme.of(context).textSelectionColor
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// receive parameters from last page
    if(id == null)
      id = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      /// set the back action
      onWillPop: () => backPressed(context),

      /// layout of the page
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(
          title: Strings.homePage,
          showBackButton: false,
          showHomeButton: false,
          showLogoutButton: true,
          backPressed: backPressed,
          bottomShowing: null,
        ),

        body: ListView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),

          children: <Widget>[
            ///  1. welcome message, for confirming the correct user has been log in
            Text( Strings.successLoginPart1 + id + Strings.successLoginPart2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Constants.normalFontSize,
              ),
            ),

            /// sized box as padding
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          
            // 2. Row with register and eye pressure button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                customizeIconButton(context, (){
                  Navigator.pushNamed(context, '/register');
                }, 'assets/images/Vision.png', Strings.register, 0.21, 0.35),
                customizeIconButton(context, (){
                  Navigator.pushNamed(context, '/UserSearch', arguments: Strings.eyePressure);
                }, 'assets/images/Vision.png', Strings.eyePressure, 0.21, 0.35)
              ],
            ),

            /// sized box as padding
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            /// 3. Row with vision test button and optometry button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                customizeIconButton(context, (){ Navigator.pushNamed(context, '/UserSearch', arguments: Strings.visionTest); },
                    'assets/images/Vision.png', Strings.visionTest, 0.21, 0.35),
                customizeIconButton(context, (){ Navigator.pushNamed(context, '/UserSearch', arguments: Strings.optometry); },
                    'assets/images/Optometry.png', Strings.optometry, 0.21, 0.35),
              ],
            ),

            /// sized box as padding
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            ///  4. Row with slip lamp test button and checking patient data button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                customizeIconButton(context, (){ Navigator.pushNamed(context, '/UserSearch', arguments: Strings.slitLamp); },
                    'assets/images/SlitLamp.png', Strings.slitLamp, 0.21, 0.35),
                customizeIconButton(context, (){ Navigator.pushNamed(context, '/UserSearch', arguments: Strings.reviewingProfile); },
                    'assets/images/Review.png', Strings.consultation, 0.21, 0.35),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            /// 5. Row with eye photo button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                customizeIconButton(context, (){Navigator.pushNamed(context, '/UserSearch', arguments: Strings.eyePhoto);}, 
                'assets/images/SlitLamp.png', Strings.eyePhoto, 0.21, 0.35),
              ],
            )
          ],
        ),
      ),
    );
  }
}