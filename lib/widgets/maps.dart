import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_exhibition_beta/screens/booth/booth.dart';
import 'package:virtual_exhibition_beta/screens/booth/leftBooth/booth.dart';
import 'package:virtual_exhibition_beta/screens/booth/rightBooth/booth.dart';
import 'package:virtual_exhibition_beta/screens/booth/stage.dart';
import 'package:virtual_exhibition_beta/screens/lobby/lobby.dart';

class Maps extends StatefulWidget {
  final String? jumpActive;

  const Maps({ Key? key, this.jumpActive}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  @override
  void initState() {
    super.initState();
    print(widget.jumpActive);
  }
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.6,
      child: Opacity(
        opacity: 1,
        // child: Image.network(image),
        child: CupertinoAlertDialog(
          actions:[
            CupertinoDialogAction(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },),
          ],
          title: Text("Choose Map"),
          content: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 15.0),
                      child: ClipOval(
                          child: Material(
                            color: Colors.red, // Button color
                            child: InkWell(
                              // splashColor: Colors.red, // Splash color
                              onTap: () {
                              // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: SecondLobby()));
                              },
                              child: SizedBox(width: 10, height: 10, child: Center()),
                            ),
                          ),
                      ),
                    ),
                    Text("You are here."),
                  ],
                )),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 15.0),
                      child: ClipOval(
                          child: Material(
                            color: Colors.purple, // Button color
                            child: InkWell(
                              splashColor: Colors.red, // Splash color
                              onTap: () {
                              // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: SecondLobby()));
                              },
                              child: SizedBox(width: 10, height: 10, child: Center()),
                            ),
                          ),
                      ),
                    ),
                    Text("Booth Jumppoint"),
                  ],
                )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 330,
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: 0,
                          // height: 300,
                          // width: 3,
                          child: Image.asset("assets/images/floorplan.png",
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //lobby
                        // top: 53.5,
                        bottom: 25.5,
                        left: 111.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isLobby' ? Colors.red : Colors.purple, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: SecondLobby()));
                            },
                            child: SizedBox(width: 8, height: 8, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //helicopter
                        bottom: 35,
                        left: 110.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isHeli' ? Colors.red : Colors.purple, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: PovHeli()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //merge booth
                        bottom: 52,
                        left: 110.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isJump1' ? Colors.red : Colors.purple, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Booth1()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //merge booth
                        bottom: 62,
                        left: 110.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isJump2' ? Colors.red : Colors.purple, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Booth2()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //merge booth
                        bottom: 45,
                        left: 75.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isEntranceLeft' ? Colors.red : Colors.purple, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Entrance2()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //merge booth
                        bottom: 45,
                        right: 75.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isEntranceRight' ? Colors.red : Colors.purple, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Entrance3()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //     //single booth
                    //     bottom: 94,
                    //     left: 110.3,
                    //     child: ClipOval(
                    //     child: Material(
                    //       color: widget.jumpActive == 'isJump5' ? Colors.red : Colors.purple, // Button color
                    //       child: InkWell(
                    //         splashColor: Colors.red, // Splash color
                    //         onTap: () {
                    //           Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Booth5()));
                    //         },
                    //         child: SizedBox(width: 10, height: 10, child: Center()),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //     //left
                    //     top: 30.5,
                    //     right: 50,
                    //     child: ClipOval(
                    //     child: Material(
                    //       color: Colors.purple, // Button color
                    //       child: InkWell(
                    //         splashColor: Colors.red, // Splash color
                    //         onTap: () {
                    //           // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: LeftBooth()));
                    //         },
                    //         child: SizedBox(width: 10, height: 10, child: Center()),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //     //mid
                    //     top: 53.5,
                    //     right: 50,
                    //     child: ClipOval(
                    //     child: Material(
                    //       color: Colors.purple, // Button color
                    //       child: InkWell(
                    //         splashColor: Colors.red, // Splash color
                    //         onTap: () {
                    //           // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: MidBooth()));
                    //         },
                    //         child: SizedBox(width: 10, height: 10, child: Center()),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //     //Stage
                    //     top: 53.5,
                    //     right: 35,
                    //     child: ClipOval(
                    //     child: Material(
                    //       color: Colors.purple, // Button color
                    //       child: InkWell(
                    //         splashColor: Colors.red, // Splash color
                    //         onTap: () {
                    //           // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: StageBooth()));
                    //         },
                    //         child: SizedBox(width: 10, height: 10, child: Center()),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                        //vendor
                        top: 156,
                        left: 75.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isCenterLeft' ? Colors.red : Colors.purple,
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: LeftCenterBooth()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //vendor
                        top: 156,
                        right: 110.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isCenterHall' ? Colors.red : Colors.purple,
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: CenterBooth()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //vendor
                        top: 156,
                        right: 75.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isCenterRight' ? Colors.red : Colors.purple,
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: RightCenterBooth()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //vendor
                        top: 33,
                        right: 110.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isStageMiddle' ? Colors.red : Colors.purple,
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Stage()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //vendor
                        top: 33,
                        right: 75.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isStageRight' ? Colors.red : Colors.purple,
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: StageRight()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        //vendor
                        top: 33,
                        left: 75.3,
                        child: ClipOval(
                        child: Material(
                          color: widget.jumpActive == 'isStageLeft' ? Colors.red : Colors.purple,
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: StageLeft()));
                            },
                            child: SizedBox(width: 10, height: 10, child: Center()),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}