// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/auth/login.dart';
import 'package:virtual_exhibition_beta/screens/home.dart';
import 'package:virtual_exhibition_beta/vendor/vendorHome.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  LoginStatus loginStatus = LoginStatus.notSignIn;
  final int _numPages = 1;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFe3724b) : Color(0xFFffdcb5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _chatPermissions(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
          title:
              Text("Are you willing to be chatted with by other users in this event?"),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            // child: SizedBox(
            //     // height: 50,
            //     // width: 50,
            //     child: Center(child: CircularProgressIndicator())),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              // isDestructiveAction: true,
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                savePref(1);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
    );
  }

  savePref(int agree) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("agree", agree);
      preferences.commit();
    });
  }

  var value, agree;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      agree = preferences.getInt("agree");

      loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  late AnimationController _animationController;
  late Animation<double> _animation;

  Future<void> _chatPopUp() async {
    await getPref();
    agree == null
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => _chatPermissions(context),
          )
        : Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
    _animationController = AnimationController(
        vsync: this, // must add with TickerProviderStateMixin
        duration: const Duration(milliseconds: 750) //Animation Durations
        );

    _animation = Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    Future.delayed(Duration.zero, () {
      this._chatPopUp();
    });
  }

  @override
  void dispose() {
    // _tapGallery.dispose();
    // _tapCamera.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Color(0xFFe3724b),
      primary: Color(0xFFe3724b),
      // minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
    );
    switch (loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(false),
                              ),
                            );
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Poppins Semibold',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.35,
                        // height: 600,
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 50),
                                      child: ScaleTransition(
                                          scale: _animation,
                                          child: InkWell(
                                              onTap: () {
                                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstLobby()));
                                                setState(() {
                                                  _animationController.stop();
                                                });
                                              },
                                              child: Image.asset(
                                                  "assets/images/onboarding.png")))
                                      // Image(
                                      //   width: double.infinity,
                                      //   image: AssetImage(
                                      //     'assets/images/onboarding.png',
                                      //   ),
                                      // ),
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("assets/images/logo.png",
                                            width: 250),
                                        SizedBox(height: 10),
                                        // Text(
                                        //   'Lorem Ipsum',
                                        //   style: TextStyle(
                                        //     fontSize: 20,
                                        //     fontFamily: 'Poppins Bold',
                                        //   ),
                                        // ),
                                        // SizedBox(height: 10),
                                        Text(
                                          'consectetur adispicing elit \n sed do euismod tempor incidunt',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Poppins Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: <Widget>[
                            //     // Center(
                            //     //   child: Padding(
                            //     //     padding: const EdgeInsets.symmetric(
                            //     //         vertical: 50),
                            //     //     child: Image(
                            //     //       image: AssetImage(
                            //     //         'assets/images/onboardTwo.png',
                            //     //       ),
                            //     //     ),
                            //     //   ),
                            //     // ),
                            //     Center(
                            //       child: Column(
                            //         children: <Widget>[
                            //           Text(
                            //             'Lorem Ipsum',
                            //             style: TextStyle(
                            //               fontSize: 20,
                            //               fontFamily: 'Poppins Bold',
                            //             ),
                            //           ),
                            //           SizedBox(height: 10),
                            //           Text(
                            //             'consectetur adispicing elit \n sed do euismod tempor incidunt',
                            //             textAlign: TextAlign.center,
                            //             style: TextStyle(
                            //               fontSize: 18,
                            //               fontFamily: 'Poppins Regular',
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: <Widget>[
                            //     // Center(
                            //     //   child: Padding(
                            //     //     padding: const EdgeInsets.symmetric(
                            //     //         vertical: 50),
                            //     //     child: Image(
                            //     //       image: AssetImage(
                            //     //         'assets/images/onboardThree.png',
                            //     //       ),
                            //     //       height: 275,
                            //     //     ),
                            //     //   ),
                            //     // ),
                            //     Center(
                            //       child: Column(
                            //         children: <Widget>[
                            //           Text(
                            //             'Lorem Ipsum',
                            //             style: TextStyle(
                            //               fontSize: 20,
                            //               fontFamily: 'Poppins Bold',
                            //             ),
                            //           ),
                            //           SizedBox(height: 10),
                            //           Text(
                            //             'consectetur adispicing elit \n sed do euismod tempor incidunt',
                            //             textAlign: TextAlign.center,
                            //             style: TextStyle(
                            //               fontSize: 18,
                            //               fontFamily: 'Poppins Regular',
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: _buildPageIndicator(),
                      // ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 80,
                  // ignore: deprecated_member_use
                  child: ElevatedButton(
                    onPressed: () {
                      // agree == 1 ?
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LoginPage(true)));
                      // _pageController.nextPage(
                      //     duration: Duration(milliseconds: 500),
                      //     curve: Curves.ease);
                      print('a');
                    },
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.all(
                    //     Radius.circular(180),
                    //     // topLeft: Radius.circular(25),
                    //     // bottomLeft: Radius.circular(25),
                    //   ),
                    // ),
                    // color: Color(0xFF264C95),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(5),
                      primary: Color(0xFF264C95), // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Text(
                        //   'Selanjutnya',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 18,
                        //     fontFamily: 'Poppins Medium',
                        //   ),
                        // ),
                        // SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _currentPage != _numPages - 1
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 50,
                        // ignore: deprecated_member_use
                        child: TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          style: flatButtonStyle,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Selanjutnya',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Poppins Medium',
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text(''),
            ],
          ),
          // bottomSheet: _currentPage == _numPages - 1
          //     ? Container(
          //         height: 80,
          //         width: double.infinity,
          //         // color: Color(0xFFe3724b),
          //         child: GestureDetector(
          //           onTap: () {
          //             Navigator.pushReplacement(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => LoginPage(false),
          //               ),
          //             );
          //           },
          //           // child: Center(
          //           //   child: Text(
          //           //     'Mulai Sekarang',
          //           //     style: TextStyle(
          //           //       color: Colors.white,
          //           //       fontSize: 20,
          //           //       fontFamily: 'Poppins Semibold',
          //           //     ),
          //           //   ),
          //           // ),
          //         ),
          //       )
          //     : Text(''),
        );
        break;
      case LoginStatus.signIn:
        return HomePage();
        break;
      case LoginStatus.vendorIn:
        return VendorHome();
        break;
    }
  }
}
