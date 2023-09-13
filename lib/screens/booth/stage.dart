import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panorama/panorama.dart';
import 'package:video_player/video_player.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/screens/auction/auction_detail.dart';
import 'package:virtual_exhibition_beta/screens/booth/booth.dart';
import 'package:virtual_exhibition_beta/screens/product/product_list.dart';
import 'package:virtual_exhibition_beta/widgets/animatedHotspotButton.dart';
import 'package:virtual_exhibition_beta/widgets/floatingButton.dart';
import 'package:virtual_exhibition_beta/widgets/regularHotspotButton.dart';
import 'package:virtual_exhibition_beta/widgets/seeProduct.dart';
import 'package:http/http.dart' as http;

class Stage extends StatefulWidget {
  const Stage({Key? key}) : super(key: key);

  @override
  _StageState createState() => _StageState();
}

class _StageState extends State<Stage> {
  late VideoPlayerController _controller;
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;

  // List<Image> panoImages = [
  //   Image.asset('assets/images/POV MID.png'),
  //   Image.asset('assets/images/POV KANAN.png'),
  //   Image.asset('assets/images/POV KIRI.png'),
  // ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  String positions = "Stage";

  Widget _scrollDialog(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 0.9,
        child: CupertinoAlertDialog(
          title: Text("You can scroll around with your fingertip."),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
                // height: 50,
                // width: 50,
                child: Center(child: Image.asset("assets/images/scroll.gif"))),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        // _isLoading = false;
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) => _scrollDialog(context),
        );
      });
    });
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  bool _isLoading = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Widget RegularHotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                )),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle checkButtonStyle = TextButton.styleFrom(
      backgroundColor: Color(0xFF264C95),
      primary: Color(0xFF264C95),
      // minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
    return Scaffold(
        body: Panorama(
          sensitivity: 3.0,
          animSpeed: 0.25,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          onTap: (longitude, latitude, tilt) =>
              print('onTap: $longitude, $latitude, $tilt'),
          // onLongPressStart: (longitude, latitude, tilt) => print('onLongPressStart: $longitude, $latitude, $tilt'),
          // onLongPressMoveUpdate: (longitude, latitude, tilt) => print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
          // onLongPressEnd: (longitude, latitude, tilt) => print('onLongPressEnd: $longitude, $latitude, $tilt'),
          // child: Image.network(
          //     'https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/stage_middle.webp'),
          child: Image(image: CachedNetworkImageProvider('https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/stage_middle.webp')),
          hotspots: [
            Hotspot(
              latitude: -25.0,
              longitude: -180.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth20()));
                  }),
            ),
            Hotspot(
              latitude: -3.0,
              longitude: 90.0,
              width: 65,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: StageRight()));
                  }),
            ),
            Hotspot(
              latitude: -3.0,
              longitude: 270.0,
              width: 65,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: StageLeft()));
                  }),
            ),
            Hotspot(
              latitude: 9.5,
              longitude: 0.0,
              width: 600,
              height: 280,
              widget: _controller.value.isInitialized
                  ?
                  // AspectRatio(
                  //     aspectRatio: _controller.value.aspectRatio,
                  //     child: VideoPlayer(_controller),
                  //   )
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3)),
                      child: VideoPlayer(_controller))
                  : Container(),
            ),
            Hotspot(
              latitude: -20.0,
              longitude: 0.0,
              width: 56,
              height: 56,
              widget: TextButton(
                onPressed: () {
                  // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: AuctionDetail()));
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                    _controller.setLooping(true);
                  });
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(25),
                //     // topLeft: Radius.circular(25),
                //     // bottomLeft: Radius.circular(25),
                //   ),
                // ),
                // color: Color(0xFF264C95),
                style: checkButtonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Text(
                    //   'Live Auction/Try a trial',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 18,
                    //     fontFamily: 'Poppins Medium',
                    //   ),
                    // ),
                    // SizedBox(width: 10),
                    Icon(
                      color: Colors.white,
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isStageMiddle'));
  }
}

class StageRight extends StatefulWidget {
  const StageRight({Key? key}) : super(key: key);

  @override
  _StageRightState createState() => _StageRightState();
}

class _StageRightState extends State<StageRight> {
  late VideoPlayerController _controller;
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  String positions = "Right Stage";

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
  }

  Widget RegularHotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                )),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle checkButtonStyle = TextButton.styleFrom(
      backgroundColor: Color(0xFF264C95),
      primary: Color(0xFF264C95),
      // minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
    return Scaffold(
        body: Panorama(
          sensitivity: 3.0,
          animSpeed: 0.25,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          onTap: (longitude, latitude, tilt) =>
              print('onTap: $longitude, $latitude, $tilt'),
          // onLongPressStart: (longitude, latitude, tilt) => print('onLongPressStart: $longitude, $latitude, $tilt'),
          // onLongPressMoveUpdate: (longitude, latitude, tilt) => print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
          // onLongPressEnd: (longitude, latitude, tilt) => print('onLongPressEnd: $longitude, $latitude, $tilt'),
          // child: Image.network(
          //     'https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/stage_right.webp'),
          child: Image(image: CachedNetworkImageProvider('https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/stage_right.webp')),
          hotspots: [
            Hotspot(
              latitude: -3.0,
              longitude: 90.0,
              width: 65,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Stage()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isStageRight'));
  }
}

class StageLeft extends StatefulWidget {
  const StageLeft({Key? key}) : super(key: key);

  @override
  _StageLeftState createState() => _StageLeftState();
}

class _StageLeftState extends State<StageLeft> {
  late VideoPlayerController _controller;
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  String positions = "Left Stage";

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
  }

  Widget RegularHotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                )),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle checkButtonStyle = TextButton.styleFrom(
      backgroundColor: Color(0xFF264C95),
      primary: Color(0xFF264C95),
      // minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
    return Scaffold(
        body: Panorama(
          sensitivity: 3.0,
          animSpeed: 0.25,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          onTap: (longitude, latitude, tilt) =>
              print('onTap: $longitude, $latitude, $tilt'),
          // onLongPressStart: (longitude, latitude, tilt) => print('onLongPressStart: $longitude, $latitude, $tilt'),
          // onLongPressMoveUpdate: (longitude, latitude, tilt) => print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
          // onLongPressEnd: (longitude, latitude, tilt) => print('onLongPressEnd: $longitude, $latitude, $tilt'),
          // child: Image.network(
          //     'https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/stage_left.webp'),
          child: Image(image: CachedNetworkImageProvider('https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/stage_left.webp')),
          hotspots: [
            Hotspot(
              latitude: -2.0,
              longitude: -90.0,
              width: 65,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Stage()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isStageLeft'));
  }
}
