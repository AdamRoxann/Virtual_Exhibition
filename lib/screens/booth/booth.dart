import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panorama/panorama.dart';
import 'package:video_player/video_player.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/screens/auction/auction_detail.dart';
import 'package:virtual_exhibition_beta/screens/auction/auction_list.dart';
import 'package:virtual_exhibition_beta/screens/booth/leftBooth/booth.dart';
import 'package:virtual_exhibition_beta/screens/booth/rightBooth/booth.dart';
import 'package:virtual_exhibition_beta/screens/booth/stage.dart';
import 'package:virtual_exhibition_beta/screens/booth/test.dart';
import 'package:virtual_exhibition_beta/screens/product/product_list.dart';
import 'package:virtual_exhibition_beta/widgets/animatedHotspotButton.dart';
import 'package:virtual_exhibition_beta/widgets/floatingButton.dart';
import 'package:virtual_exhibition_beta/widgets/regularHotspotButton.dart';
import 'package:virtual_exhibition_beta/widgets/seeProduct.dart';
import 'package:http/http.dart' as http;

class Entrance extends StatefulWidget {
  const Entrance({Key? key}) : super(key: key);

  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
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

  String positions = "Entrance";

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
    // _showToast("Entering "+positions);
  }

  // final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  //     GlobalKey<ScaffoldMessengerState>();

  // _showToast(String toast) {
  //   final snackbar = SnackBar(
  //     content: new Text(toast),
  //     backgroundColor: Colors.green,
  //   );
  //   // scaffoldkey.currentState!.showSnackBar(snackbar);
  //   scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: scaffoldMessengerKey,
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
          child:
              // Image.network(AssetsUrl.boothModel + 'entrance/entrance_1.webp'),
              Image(
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  image: CachedNetworkImageProvider(
                      AssetsUrl.boothModel + 'entrance/entrance_1.webp')),
          hotspots: [
            Hotspot(
              latitude: -15.0,
              longitude: 0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth1()));
                  }),
            ),
            Hotspot(
              latitude: -2.0,
              longitude: 92.0,
              width: 100,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Entrance3()));
                  }),
            ),
            Hotspot(
              latitude: -2.0,
              longitude: 270.0,
              width: 100,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Entrance2()));
                  }),
            ),
            Hotspot(
                latitude: -8.0,
                longitude: -31.0,
                width: 90,
                height: 200,
                widget: Image.asset('assets/images/giphy-unscreen.gif')),
            Hotspot(
                latitude: -6.0,
                longitude: -19.0,
                width: 65,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_2.png')),
            Hotspot(
                latitude: -5.0,
                longitude: 23.0,
                width: 60,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_3.png')),
            Hotspot(
                latitude: -7.0,
                longitude: 33.0,
                width: 110,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_4.png')),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Entrance2 extends StatefulWidget {
  const Entrance2({Key? key}) : super(key: key);

  @override
  _Entrance2State createState() => _Entrance2State();
}

class _Entrance2State extends State<Entrance2> {
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

  String positions = "Left Entrance";

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
          child:
              Image.network(AssetsUrl.boothModel + 'entrance/entrance_2.webp'),
          hotspots: [
            Hotspot(
              latitude: -15.0,
              longitude: 0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: LeftBooth1()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 100,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Entrance()));
                  }),
            ),
            Hotspot(
                latitude: -8.0,
                longitude: -31.0,
                width: 90,
                height: 200,
                widget: Image.asset('assets/images/giphy-unscreen.gif')),
            Hotspot(
                latitude: -6.0,
                longitude: -19.0,
                width: 65,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_2.png')),
            Hotspot(
                latitude: -5.0,
                longitude: 23.0,
                width: 60,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_3.png')),
            Hotspot(
                latitude: -7.0,
                longitude: 33.0,
                width: 110,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_4.png')),
          ],
        ),
        floatingActionButton: FloatingButton(
          jumpActive: 'isEntranceLeft',
        ));
  }
}

class Entrance3 extends StatefulWidget {
  const Entrance3({Key? key}) : super(key: key);

  @override
  _Entrance3State createState() => _Entrance3State();
}

class _Entrance3State extends State<Entrance3> {
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

  String positions = "Right Entrance";

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
          child:
              Image.network(AssetsUrl.boothModel + 'entrance/entrance_3.webp'),
          hotspots: [
            Hotspot(
              latitude: -15.0,
              longitude: 0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: RightBooth1()));
                  }),
            ),
            Hotspot(
              latitude: -2.0,
              longitude: 270.0,
              width: 100,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Entrance()));
                  }),
            ),
            Hotspot(
                latitude: -8.0,
                longitude: -31.0,
                width: 90,
                height: 200,
                widget: Image.asset('assets/images/giphy-unscreen.gif')),
            Hotspot(
                latitude: -6.0,
                longitude: -19.0,
                width: 65,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_2.png')),
            Hotspot(
                latitude: -5.0,
                longitude: 23.0,
                width: 60,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_3.png')),
            Hotspot(
                latitude: -7.0,
                longitude: 33.0,
                width: 110,
                height: 200,
                widget: Image.asset('assets/images/avatar/avatar_4.png')),
          ],
        ),
        floatingActionButton: FloatingButton(
          jumpActive: 'isEntranceRight',
        ));
  }
}

class Booth1 extends StatefulWidget {
  const Booth1({Key? key}) : super(key: key);

  @override
  _Booth1State createState() => _Booth1State();
}

class _Booth1State extends State<Booth1> {
  int booth_id = 2;
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
      // zoom
    });
  }

  String positions = "Booth 1";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

  String booth_header_link_kanan = "";
  String booth_header_title_kanan = "";
  String booth_stand_link_kanan = "";
  String booth_tv_display_link_kanan = "";

  getbooth() async {
    final response = await http.post(Uri.parse(BoothUrl.images), body: {
      "booth_id": "1",
    });

    final data = jsonDecode(response.body);
    int id = data['id'];
    int booth_id = data['booth_id'];
    String booth_header_title = data['booth_header_title'];
    String booth_header = data['booth_header'];
    String booth_stand = data['booth_stand'];
    print(booth_stand);
    String booth_tv_display = data['booth_tv_display'];

    setState(() {
      booth_header_title = booth_header_title;
      booth_header_link = booth_header;
      booth_stand_link = booth_stand;
      booth_tv_display_link = booth_tv_display;
    });

    final responses = await http.post(Uri.parse(BoothUrl.images), body: {
      "booth_id": "2",
    });

    final data_kanan = jsonDecode(responses.body);
    int id_kanan = data_kanan['id'];
    int booth_id_kanan = data_kanan['booth_id'];
    String booth_header_title_kanan = data_kanan['booth_header_title'];
    String booth_header_kanan = data_kanan['booth_header'];
    String booth_stand_kanan = data_kanan['booth_stand'];
    String booth_tv_display_kanan = data_kanan['booth_tv_display'];

    setState(() {
      booth_header_title_kanan = booth_header_title_kanan;
      booth_header_link_kanan = booth_header_kanan;
      booth_stand_link_kanan = booth_stand_kanan;
      booth_tv_display_link_kanan = booth_tv_display_kanan;
    });
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
    Future.delayed(Duration(seconds: 1), () {
      if (this.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    getbooth();
  }

  @override
  Widget build(BuildContext context) {
    final String placeholder = "placeholder.png";
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
          maxZoom: 1,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          onTap: (longitude, latitude, tilt) =>
              print('onTap: $longitude, $latitude, $tilt'),
          // onLongPressStart: (longitude, latitude, tilt) => print('onLongPressStart: $longitude, $latitude, $tilt'),
          // onLongPressMoveUpdate: (longitude, latitude, tilt) => print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
          // onLongPressEnd: (longitude, latitude, tilt) => print('onLongPressEnd: $longitude, $latitude, $tilt'),
          // child: Image(
          //         loadingBuilder: (BuildContext context, Widget child,
          //             ImageChunkEvent? loadingProgress) {
          //           if (loadingProgress == null) return child;
          //           // return Center(
          //           //   child: CircularProgressIndicator(
          //           //     backgroundColor: Colors.red,
          //           //     value: loadingProgress.expectedTotalBytes != null
          //           //         ? loadingProgress.cumulativeBytesLoaded /
          //           //             loadingProgress.expectedTotalBytes!
          //           //         : null,
          //           //   ),
          //           // );
          //           return Image.network(AssetsUrl.boothModel + 'booth_1.webp');
          //         },
          // image: CachedNetworkImageProvider(
          //     AssetsUrl.boothModel + 'sample.jpg')),
          //  child: Image.network(AssetsUrl.boothModel + 'booth_1.webp'),
          child: _isLoading
              ? Image.asset("assets/images/loading_booth.webp")
              : Image(
                  image: CachedNetworkImageProvider(
                      AssetsUrl.boothModel + 'booth_1.webp')),
          // child: Image.asset('assets/images/booth/2.png'),
          hotspots: [
            Hotspot(
              latitude: -3.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Entrance()));
                  }),
            ),
            Hotspot(
              latitude: -18.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth2()));
                  }),
            ),
            Hotspot(
              latitude: -7.5,
              longitude: -19.0,
              width: 110,
              height: 250,
              widget: SeeProduct(
                  width: 80,
                  height: 250,
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => ProductDetail()));
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ProductList(
                              booth_id: 1.toString(),
                            )));
                    // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ProductDetail()));
                  }),
            ),
            Hotspot(
                latitude: -5.0,
                longitude: -24,
                width: 150,
                height: 750,
                widget: Image.asset('assets/images/click_here.gif')),
            Hotspot(
                latitude: -5.0,
                longitude: 159,
                width: 150,
                height: 750,
                widget: Image.asset('assets/images/click_here.gif')),
            Hotspot(
                latitude: -8.0,
                longitude: 2,
                width: 150,
                height: 750,
                widget: Image.asset('assets/images/giphy-unscreen.gif')),
            Hotspot(
                latitude: 2.8,
                longitude: -9.9,
                width: 130,
                height: 75,
                widget: booth_tv_display_link == ""
                    ? SeeProduct(
                        width: 115,
                        height: 75,
                        image: BoothUrl.tv + placeholder,
                        opacity: 1,
                        onPressed: () {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => BrandDetail()));
                          // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                        })
                    : SeeProduct(
                        width: 100,
                        height: 75,
                        image: BoothUrl.tv + booth_tv_display_link,
                        opacity: 1,
                        onPressed: () {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => BrandDetail()));
                          // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                        })),
            Hotspot(
              latitude: 15.5,
              longitude: 0.5,
              width: 680,
              height: 100,
              widget: booth_header_link == ""
                  ? SeeProduct(
                      width: 680,
                      height: 100,
                      image: BoothUrl.header + placeholder,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      })
                  : SeeProduct(
                      width: 535,
                      height: 100,
                      image: BoothUrl.header + booth_header_link,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      }),
            ),
            Hotspot(
              latitude: -8,
              longitude: 18,
              width: 115,
              height: 260,
              widget: booth_stand_link == ""
                  ? SeeProduct(
                      width: 115,
                      height: 260,
                      image: BoothUrl.banner + placeholder,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      })
                  : SeeProduct(
                      width: 95,
                      height: 260,
                      image: BoothUrl.banner + booth_stand_link,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      }),
            ),
            Hotspot(
              latitude: -8.5,
              longitude: 162.0,
              width: 110,
              height: 250,
              widget: SeeProduct(
                  width: 80,
                  height: 250,
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => ProductDetail()));
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ProductList(
                              booth_id: 2.toString(),
                            )));
                    // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ProductDetail()));
                  }),
            ),
            Hotspot(
                latitude: -9.0,
                longitude: 185,
                width: 150,
                height: 750,
                widget: Image.asset('assets/images/avatar/avatar_2.png')),
            Hotspot(
                latitude: 2.7,
                longitude: 171.5,
                width: 130,
                height: 75,
                widget: booth_tv_display_link_kanan == ""
                    ? SeeProduct(
                        width: 93,
                        height: 75,
                        image: BoothUrl.tv + placeholder,
                        opacity: 1,
                        onPressed: () {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => BrandDetail()));
                          // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                        })
                    : SeeProduct(
                        width: 93,
                        height: 75,
                        image: BoothUrl.tv + booth_tv_display_link_kanan,
                        opacity: 1,
                        onPressed: () {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => BrandDetail()));
                          // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                        })),
            Hotspot(
              latitude: 14.2,
              longitude: 180,
              width: 680,
              height: 100,
              widget: booth_header_link_kanan == ""
                  ? SeeProduct(
                      width: 680,
                      height: 100,
                      image: BoothUrl.header + placeholder,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      })
                  : SeeProduct(
                      width: 500,
                      height: 100,
                      image: BoothUrl.header + booth_header_link_kanan,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      }),
            ),
            Hotspot(
              latitude: -7,
              longitude: -162,
              width: 115,
              height: 260,
              widget: booth_stand_link_kanan == ""
                  ? SeeProduct(
                      width: 115,
                      height: 260,
                      image: BoothUrl.banner + placeholder,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      })
                  : SeeProduct(
                      width: 92,
                      height: 260,
                      image: BoothUrl.banner + booth_stand_link_kanan,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isJump1'));
  }
}

class Booth2 extends StatefulWidget {
  const Booth2({Key? key}) : super(key: key);

  @override
  _Booth2State createState() => _Booth2State();
}

class _Booth2State extends State<Booth2> {
  int booth_id = 2;
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

  String positions = "Booth 2";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

  getbooth() async {
    final response = await http.post(Uri.parse(BoothUrl.images), body: {
      "booth_id": "3",
    });

    final data = jsonDecode(response.body);
    int id = data['id'];
    int booth_id = data['booth_id'];
    String booth_header_title = data['booth_header_title'];
    String booth_header = data['booth_header'];
    String booth_stand = data['booth_stand'];
    String booth_tv_display = data['booth_tv_display'];
    // String tokenAPI = data['api_key'];
    // print(data);

    // if (booth_id == 1) {
    //   // Navigator.pop(context);
    setState(() {
      booth_header_title = booth_header_title;
      booth_header_link = booth_header;
      booth_stand_link = booth_stand;
      booth_tv_display_link = booth_tv_display;
    });

    print(booth_header_title);
    print(booth_header_link);
    print(booth_stand_link);
    print(booth_tv_display_link);
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    Future.delayed(Duration(seconds: 1), () {
      if (this.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    getbooth();
  }

  @override
  Widget build(BuildContext context) {
    final String placeholder = "placeholder.png";
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
          child: _isLoading ? Image.asset('assets/images/loading_booth.webp') :
          Image(
              image: CachedNetworkImageProvider(
                  AssetsUrl.boothModel + 'booth_2.webp')),
          // child: Image.network(AssetsUrl.boothModel + 'booth_2.webp'),
          // child: Image.asset('assets/images/booth/2.png'),
          hotspots: [
            // Hotspot(
            //   // latitude: -28.0,
            //   // longitude: 1.0,
            //   latitude: 12.0,
            //   longitude: 4,
            //   width: 260,
            //   height: 70,
            //   widget: Container(
            //     width: 260,
            //     height: 100,
            //     child: _isLoading
            //         ? Container()
            //         : TextButton(
            //             onPressed: () {
            //               Navigator.pushReplacement(
            //                   context,
            //                   PageTransition(
            //                       type: PageTransitionType.fade,
            //                       child: Test()));
            //             },
            //             // shape: RoundedRectangleBorder(
            //             //   borderRadius: BorderRadius.all(
            //             //     Radius.circular(25),
            //             //     // topLeft: Radius.circular(25),
            //             //     // bottomLeft: Radius.circular(25),
            //             //   ),
            //             // ),
            //             // color: Color(0xFF264C95),
            //             style: checkButtonStyle,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               mainAxisSize: MainAxisSize.min,
            //               children: <Widget>[
            //                 Text(
            //                   'Live Auction/Try a trial',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 18,
            //                     fontFamily: 'Poppins Medium',
            //                   ),
            //                 ),
            //                 SizedBox(width: 10),
            //                 Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: Colors.white,
            //                   size: 15,
            //                 ),
            //               ],
            //             ),
            //           ),
            //   ),
            // ),
            Hotspot(
              latitude: -26.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth1()));
                  }),
            ),
            Hotspot(
              latitude: -18.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth3()));
                  }),
            ),
            Hotspot(
              latitude: -7.5,
              longitude: -19.0,
              width: 110,
              height: 250,
              widget: SeeProduct(
                  width: 80,
                  height: 250,
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => ProductDetail()));
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ProductList(
                              booth_id: 3.toString(),
                            )));
                    // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ProductDetail()));
                  }),
            ),
            Hotspot(
                latitude: -8.0,
                longitude: 2,
                width: 150,
                height: 750,
                widget: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: Test()));
                    },
                    child: Image.asset('assets/images/avatar/avatar_3.png'))),
            Hotspot(
                latitude: -7.0, //y
                longitude: -41, //x
                width: 115,
                height: 750,
                widget: Image.asset('assets/images/giphy-unscreen.gif')),
            Hotspot(
                latitude: 2.8,
                longitude: -9.9,
                width: 130,
                height: 75,
                widget: booth_tv_display_link == ""
                    ? SeeProduct(
                        width: 115,
                        height: 75,
                        image: BoothUrl.tv + placeholder,
                        opacity: 1,
                        onPressed: () {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => BrandDetail()));
                          // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                        })
                    : SeeProduct(
                        width: 100,
                        height: 75,
                        image: BoothUrl.tv + booth_tv_display_link,
                        opacity: 1,
                        onPressed: () {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => BrandDetail()));
                          // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                        })),
            Hotspot(
              latitude: 15.5,
              longitude: 0.5,
              width: 680,
              height: 100,
              widget: booth_header_link == ""
                  ? SeeProduct(
                      width: 680,
                      height: 100,
                      image: BoothUrl.header + placeholder,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      })
                  : SeeProduct(
                      width: 535,
                      height: 100,
                      image: BoothUrl.header + booth_header_link,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      }),
            ),
            Hotspot(
              latitude: -8,
              longitude: 18,
              width: 115,
              height: 260,
              widget: booth_stand_link == ""
                  ? SeeProduct(
                      width: 115,
                      height: 260,
                      image: BoothUrl.banner + placeholder,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      })
                  : SeeProduct(
                      width: 95,
                      height: 260,
                      image: BoothUrl.banner + booth_stand_link,
                      opacity: 1,
                      onPressed: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => BrandDetail()));
                        // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
                      }),
            ),
            Hotspot(
              latitude: -8.5,
              longitude: 162.0,
              width: 110,
              height: 250,
              widget: SeeProduct(
                  width: 80,
                  height: 250,
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => ProductDetail()));
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ProductList(
                              booth_id: 2.toString(),
                            )));
                    // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ProductDetail()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isJump2'));
  }
}

class Booth3 extends StatefulWidget {
  const Booth3({Key? key}) : super(key: key);

  @override
  _Booth3State createState() => _Booth3State();
}

class _Booth3State extends State<Booth3> {
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

  String positions = "Booth 3";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_3.webp'),
          hotspots: [
            Hotspot(
              latitude: -1.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Entrance()));
                  }),
            ),
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth2()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth4()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth4 extends StatefulWidget {
  const Booth4({Key? key}) : super(key: key);

  @override
  _Booth4State createState() => _Booth4State();
}

class _Booth4State extends State<Booth4> {
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

  String positions = "Booth 4";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_3.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth3()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth5()));
                  }),
            ),
            // Hotspot(
            //   latitude: -42.0,
            //   longitude: -46.0,
            //   width: 60.0,
            //   height: 60.0,
            //   widget: RegularHotspotButton(icon: Icons.search, onPressed: () => setState(() => _panoId = 2)),
            // ),
            // Hotspot(
            //   latitude: -33.0,
            //   longitude: 123.0,
            //   width: 60.0,
            //   height: 60.0,
            //   widget: RegularHotspotButton(icon: Icons.arrow_upward, onPressed: () {}),
            // ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth5 extends StatefulWidget {
  const Booth5({Key? key}) : super(key: key);

  @override
  _Booth5State createState() => _Booth5State();
}

class _Booth5State extends State<Booth5> {
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

  String positions = "Booth 5";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

  getbooth() async {
    final response = await http.post(Uri.parse(BoothUrl.images), body: {
      "booth_id": "",
    });

    final data = jsonDecode(response.body);
    int id = data['id'];
    int booth_id = data['booth_id'];
    String booth_header_title = data['booth_header_title'];
    String booth_header = data['booth_header'];
    String booth_stand = data['booth_stand'];
    String booth_tv_display = data['booth_tv_display'];
    // String tokenAPI = data['api_key'];
    // print(data);

    // if (booth_id == 1) {
    //   // Navigator.pop(context);
    setState(() {
      booth_header_title = booth_header_title;
      booth_header_link = booth_header;
      booth_stand_link = booth_stand;
      booth_tv_display_link = booth_tv_display;
    });

    print(booth_header_title);
    print(booth_header_link);
    print(booth_stand_link);
    print(booth_tv_display_link);
    //   // print(message);
    //   print(data);
    //   // _showToast(message);
    // } else {
    //   // Navigator.pop(context);
    //   print("fail");
    //   // print(message);
    // }
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final String placeholder = "placeholder.png";
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
          child: Image.network(AssetsUrl.boothModel + 'booth_5.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth4()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth6()));
                  }),
            ),
            // Hotspot(
            //   latitude: -12,
            //   longitude: 44,
            //   width: 120,
            //   height: 300,
            //   widget: booth_stand_link == ""
            //       ? SeeProduct(
            //           width: 120,
            //           height: 260,
            //           image: BoothUrl.banner + placeholder,
            //           opacity: 1,
            //           onPressed: () {
            //             // Navigator.pushReplacement(context,
            //             //     MaterialPageRoute(builder: (context) => BrandDetail()));
            //             // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
            //           })
            //       : SeeProduct(
            //           width: 120,
            //           height: 260,
            //           image: BoothUrl.banner + booth_stand_link,
            //           opacity: 1,
            //           onPressed: () {
            //             // Navigator.pushReplacement(context,
            //             //     MaterialPageRoute(builder: (context) => BrandDetail()));
            //             // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BrandDetail()));
            //           }),
            // ),
            // Hotspot(
            //   latitude: -42.0,
            //   longitude: -46.0,
            //   width: 60.0,
            //   height: 60.0,
            //   widget: RegularHotspotButton(icon: Icons.search, onPressed: () => setState(() => _panoId = 2)),
            // ),
            // Hotspot(
            //   latitude: -33.0,
            //   longitude: 123.0,
            //   width: 60.0,
            //   height: 60.0,
            //   widget: RegularHotspotButton(icon: Icons.arrow_upward, onPressed: () {}),
            // ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isJump5'));
  }
}

class Booth6 extends StatefulWidget {
  const Booth6({Key? key}) : super(key: key);

  @override
  _Booth6State createState() => _Booth6State();
}

class _Booth6State extends State<Booth6> {
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

  String positions = "Booth 6";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_6.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth5()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth7()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth7 extends StatefulWidget {
  const Booth7({Key? key}) : super(key: key);

  @override
  _Booth7State createState() => _Booth7State();
}

class _Booth7State extends State<Booth7> {
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

  String positions = "Booth 7";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_7.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth6()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth8()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth8 extends StatefulWidget {
  const Booth8({Key? key}) : super(key: key);

  @override
  _Booth8State createState() => _Booth8State();
}

class _Booth8State extends State<Booth8> {
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

  String positions = "Booth 8";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_8.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth7()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth9()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth9 extends StatefulWidget {
  const Booth9({Key? key}) : super(key: key);

  @override
  _Booth9State createState() => _Booth9State();
}

class _Booth9State extends State<Booth9> {
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

  String positions = "Booth 9";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_9.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth8()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: CenterBooth()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class CenterBooth extends StatefulWidget {
  const CenterBooth({Key? key}) : super(key: key);

  @override
  _CenterBoothState createState() => _CenterBoothState();
}

class _CenterBoothState extends State<CenterBooth> {
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

  String positions = "Booth 10";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'center.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth10()));
                  }),
            ),
            Hotspot(
              latitude: -6.0,
              longitude: 92.0,
              width: 65,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth11()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(
          jumpActive: 'isCenterHall',
        ));
  }
}

class Booth10 extends StatefulWidget {
  const Booth10({Key? key}) : super(key: key);

  @override
  _Booth10State createState() => _Booth10State();
}

class _Booth10State extends State<Booth10> {
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

  String positions = "Booth 10";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_10.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth9()));
                  }),
            ),
            Hotspot(
              latitude: -6.0,
              longitude: 92.0,
              width: 65,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth11()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth11 extends StatefulWidget {
  const Booth11({Key? key}) : super(key: key);

  @override
  _Booth11State createState() => _Booth11State();
}

class _Booth11State extends State<Booth11> {
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

  String positions = "Booth 11";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_11.webp'),
          hotspots: [
            Hotspot(
              latitude: -6.0,
              longitude: -90.0,
              width: 65,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth10()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth12()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth12 extends StatefulWidget {
  const Booth12({Key? key}) : super(key: key);

  @override
  _Booth12State createState() => _Booth12State();
}

class _Booth12State extends State<Booth12> {
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

  String positions = "Booth 12";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_12.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth11()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth13()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth13 extends StatefulWidget {
  const Booth13({Key? key}) : super(key: key);

  @override
  _Booth13State createState() => _Booth13State();
}

class _Booth13State extends State<Booth13> {
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

  String positions = "Booth 13";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_13.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth12()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth14()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth14 extends StatefulWidget {
  const Booth14({Key? key}) : super(key: key);

  @override
  _Booth14State createState() => _Booth14State();
}

class _Booth14State extends State<Booth14> {
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

  String positions = "Booth 14";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_14.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth13()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth14()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth15 extends StatefulWidget {
  const Booth15({Key? key}) : super(key: key);

  @override
  _Booth15State createState() => _Booth15State();
}

class _Booth15State extends State<Booth15> {
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

  String positions = "Booth 15";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_15.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth14()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth16()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth16 extends StatefulWidget {
  const Booth16({Key? key}) : super(key: key);

  @override
  _Booth16State createState() => _Booth16State();
}

class _Booth16State extends State<Booth16> {
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

  String positions = "Booth 16";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_16.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth15()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth17()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth17 extends StatefulWidget {
  const Booth17({Key? key}) : super(key: key);

  @override
  _Booth17State createState() => _Booth17State();
}

class _Booth17State extends State<Booth17> {
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

  String positions = "Booth 17";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_17.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth16()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth18()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth18 extends StatefulWidget {
  const Booth18({Key? key}) : super(key: key);

  @override
  _Booth18State createState() => _Booth18State();
}

class _Booth18State extends State<Booth18> {
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

  String positions = "Booth 18";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_18.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth17()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth19()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth19 extends StatefulWidget {
  const Booth19({Key? key}) : super(key: key);

  @override
  _Booth19State createState() => _Booth19State();
}

class _Booth19State extends State<Booth19> {
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

  String positions = "Booth 19";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

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
          child: Image.network(AssetsUrl.boothModel + 'booth_19.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth18()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 92.0,
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
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class Booth20 extends StatefulWidget {
  const Booth20({Key? key}) : super(key: key);

  @override
  _Booth20State createState() => _Booth20State();
}

class _Booth20State extends State<Booth20> {
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

  String positions = "Booth 20";
  String booth_header_link = "";
  String booth_header_title = "";
  String booth_stand_link = "";
  String booth_tv_display_link = "";

  @override
  void initState() {
    super.initState();
    print("Entering $positions");
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
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
          child: Image.network(AssetsUrl.boothModel + 'booth_20.webp'),
          hotspots: [
            Hotspot(
              latitude: -22.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Booth19()));
                  }),
            ),
            Hotspot(
              latitude: -24.0,
              longitude: 90.0,
              width: 150,
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
            Hotspot(
              latitude: 8.5,
              longitude: 90.0,
              width: 400,
              height: 245,
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
              latitude: -13.0,
              longitude: 90.0,
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
        floatingActionButton: FloatingButton());
  }
}
