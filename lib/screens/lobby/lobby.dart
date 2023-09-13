// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panorama/panorama.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/auth/login.dart';
import 'package:virtual_exhibition_beta/screens/booth/booth.dart';
import 'package:virtual_exhibition_beta/widgets/animatedHotspotButton.dart';
import 'package:virtual_exhibition_beta/widgets/floatingButton.dart';
import 'package:virtual_exhibition_beta/widgets/regularHotspotButton.dart';

class FirstLobby extends StatefulWidget {
  const FirstLobby({Key? key}) : super(key: key);

  @override
  _FirstLobbyState createState() => _FirstLobbyState();
}

class _FirstLobbyState extends State<FirstLobby> {
  LoginStatus loginStatus = LoginStatus.notSignIn;
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

  String positions = "First Lobby";

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Panorama(
          sensitivity: 3.0,
          animSpeed: 0.25,
          longitude: 10,
          // minZoom: 1.0,
          maxZoom: 5.0,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          onTap: (longitude, latitude, tilt) =>
              print('onTap: $longitude, $latitude, $tilt'),
          // onLongPressStart: (longitude, latitude, tilt) => print('onLongPressStart: $longitude, $latitude, $tilt'),
          // onLongPressMoveUpdate: (longitude, latitude, tilt) => print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
          // onLongPressEnd: (longitude, latitude, tilt) => print('onLongPressEnd: $longitude, $latitude, $tilt'),
          child: Image.network(
              'https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/lobby/first.webp'),
          hotspots: [
            Hotspot(
              latitude: -2.5,
              longitude: 89.5,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: SecondLobby()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isLobby'));
  }
}

class SecondLobby extends StatefulWidget {
  const SecondLobby({Key? key}) : super(key: key);

  @override
  _SecondLobbyState createState() => _SecondLobbyState();
}

class _SecondLobbyState extends State<SecondLobby> {
  LoginStatus loginStatus = LoginStatus.notSignIn;
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

  String positions = "Second Lobby";

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
  }

  @override
  Widget build(BuildContext context) {
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
          child: Image.network(
              'https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/lobby/second.webp'),
          hotspots: [
            Hotspot(
              latitude: 1.0,
              longitude: 0.0,
              width: 90,
              height: 75,
              widget: RegularHotspotButton(
                  text: "Go In",
                  icon: Icons.arrow_upward_rounded,
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //   MaterialPageRoute(builder: (context) => MidBooth()));
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: PovHeli()));
                  }),
            ),
            Hotspot(
              latitude: -4.0,
              longitude: 89.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //   MaterialPageRoute(builder: (context) => MidBooth()));
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: FirstLobby()));
                  }),
            ),
            Hotspot(
              latitude: -7.0,
              longitude: -89.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //   MaterialPageRoute(builder: (context) => MidBooth()));
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ThirdLobby()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isLobby'));
  }
}

class ThirdLobby extends StatefulWidget {
  const ThirdLobby({Key? key}) : super(key: key);

  @override
  _ThirdLobbyState createState() => _ThirdLobbyState();
}

class _ThirdLobbyState extends State<ThirdLobby> {
  LoginStatus loginStatus = LoginStatus.notSignIn;
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

  String positions = "Third Lobby";

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Panorama(
          sensitivity: 3.0,
          animSpeed: 0.25,
          // minZoom: 1.0,
          maxZoom: 5.0,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          onTap: (longitude, latitude, tilt) =>
              print('onTap: $longitude, $latitude, $tilt'),
          // onLongPressStart: (longitude, latitude, tilt) => print('onLongPressStart: $longitude, $latitude, $tilt'),
          // onLongPressMoveUpdate: (longitude, latitude, tilt) => print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
          // onLongPressEnd: (longitude, latitude, tilt) => print('onLongPressEnd: $longitude, $latitude, $tilt'),
          child: Image.network(
              'https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/lobby/third.webp'),
          hotspots: [
            Hotspot(
              latitude: -5.5,
              longitude: -179.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //   MaterialPageRoute(builder: (context) => MidBooth()));
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: SecondLobby()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isLobby'));
  }
}

class PovHeli extends StatefulWidget {
  const PovHeli({Key? key}) : super(key: key);

  @override
  _PovHeliState createState() => _PovHeliState();
}

class _PovHeliState extends State<PovHeli> {
  LoginStatus loginStatus = LoginStatus.notSignIn;
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

  String positions = "Helicopter POV";

  // final audioPlayer = AudioPlayer();

  // playMusic() async {
  //   audioPlayer.setReleaseMode(ReleaseMode.loop);

  //   audioPlayer.setSourceAsset('assets/music/lofi.mp3');
  // }

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
    // playMusic();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Image.network(
              'https://virtual.exhibition.sgvrevents.com/assets/images/booth_model/entrance/povheli.webp'),
          hotspots: [
            Hotspot(
              latitude: -57.0,
              longitude: -5.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Get Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Entrance()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isHeli'));
  }
}
