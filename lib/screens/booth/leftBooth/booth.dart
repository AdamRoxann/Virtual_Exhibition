import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panorama/panorama.dart';
import 'package:video_player/video_player.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/screens/auction/auction_detail.dart';
import 'package:virtual_exhibition_beta/screens/auction/auction_list.dart';
import 'package:virtual_exhibition_beta/screens/booth/stage.dart';
import 'package:virtual_exhibition_beta/screens/booth/test.dart';
import 'package:virtual_exhibition_beta/screens/product/product_list.dart';
import 'package:virtual_exhibition_beta/widgets/animatedHotspotButton.dart';
import 'package:virtual_exhibition_beta/widgets/floatingButton.dart';
import 'package:virtual_exhibition_beta/widgets/regularHotspotButton.dart';
import 'package:virtual_exhibition_beta/widgets/seeProduct.dart';
import 'package:http/http.dart' as http;

class LeftBooth1 extends StatefulWidget {
  const LeftBooth1({Key? key}) : super(key: key);

  @override
  _LeftBooth1State createState() => _LeftBooth1State();
}

class _LeftBooth1State extends State<LeftBooth1> {
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
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_1.webp'),
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
                    // Navigator.pushReplacement(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.fade, child: Entrance()));
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
                            type: PageTransitionType.fade, child: LeftBooth2()));
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

class LeftBooth2 extends StatefulWidget {
  const LeftBooth2({Key? key}) : super(key: key);

  @override
  _LeftBooth2State createState() => _LeftBooth2State();
}

class _LeftBooth2State extends State<LeftBooth2> {
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
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_2.webp'),
          // child: Image.asset('assets/images/booth/2.png'),
          hotspots: [
            Hotspot(
              // latitude: -28.0,
              // longitude: 1.0,
              latitude: 12.0,
              longitude: 4,
              width: 260,
              height: 70,
              widget: Container(
                width: 260,
                height: 100,
                child: _isLoading
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: Test()));
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
                            Text(
                              'Live Auction/Try a trial',
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
            ),
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
                            type: PageTransitionType.fade, child: LeftBooth1()));
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
                            type: PageTransitionType.fade, child: LeftBooth3()));
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

class LeftBooth3 extends StatefulWidget {
  const LeftBooth3({Key? key}) : super(key: key);

  @override
  _LeftBooth3State createState() => _LeftBooth3State();
}

class _LeftBooth3State extends State<LeftBooth3> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_3.webp'),
          hotspots: [
            Hotspot(
              latitude: -1.0,
              longitude: -90.0,
              width: 150,
              height: 200,
              widget: AnimatedHotspotButton(
                  text: "Go Here",
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.fade, child: Entrance()));
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
                            type: PageTransitionType.fade, child: LeftBooth2()));
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
                            type: PageTransitionType.fade, child: LeftBooth4()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth4 extends StatefulWidget {
  const LeftBooth4({Key? key}) : super(key: key);

  @override
  _LeftBooth4State createState() => _LeftBooth4State();
}

class _LeftBooth4State extends State<LeftBooth4> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_3.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth3()));
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
                            type: PageTransitionType.fade, child: LeftBooth5()));
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

class LeftBooth5 extends StatefulWidget {
  const LeftBooth5({Key? key}) : super(key: key);

  @override
  _LeftBooth5State createState() => _LeftBooth5State();
}

class _LeftBooth5State extends State<LeftBooth5> {
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
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_5.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth4()));
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
                            type: PageTransitionType.fade, child: LeftBooth6()));
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

class LeftBooth6 extends StatefulWidget {
  const LeftBooth6({Key? key}) : super(key: key);

  @override
  _LeftBooth6State createState() => _LeftBooth6State();
}

class _LeftBooth6State extends State<LeftBooth6> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_6.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth5()));
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
                            type: PageTransitionType.fade, child: LeftBooth7()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth7 extends StatefulWidget {
  const LeftBooth7({Key? key}) : super(key: key);

  @override
  _LeftBooth7State createState() => _LeftBooth7State();
}

class _LeftBooth7State extends State<LeftBooth7> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_7.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth6()));
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
                            type: PageTransitionType.fade, child: LeftBooth8()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth8 extends StatefulWidget {
  const LeftBooth8({Key? key}) : super(key: key);

  @override
  _LeftBooth8State createState() => _LeftBooth8State();
}

class _LeftBooth8State extends State<LeftBooth8> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_8.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth7()));
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
                            type: PageTransitionType.fade, child: LeftBooth9()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth9 extends StatefulWidget {
  const LeftBooth9({Key? key}) : super(key: key);

  @override
  _LeftBooth9State createState() => _LeftBooth9State();
}

class _LeftBooth9State extends State<LeftBooth9> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_9.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth8()));
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
                            type: PageTransitionType.fade, child: LeftBooth10()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftCenterBooth extends StatefulWidget {
  const LeftCenterBooth({Key? key}) : super(key: key);

  @override
  _LeftCenterBoothState createState() => _LeftCenterBoothState();
}

class _LeftCenterBoothState extends State<LeftCenterBooth> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'left_center.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth10()));
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
                            type: PageTransitionType.fade, child: LeftBooth11()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(jumpActive: 'isCenterLeft',));
  }
}

class LeftBooth10 extends StatefulWidget {
  const LeftBooth10({Key? key}) : super(key: key);

  @override
  _LeftBooth10State createState() => _LeftBooth10State();
}

class _LeftBooth10State extends State<LeftBooth10> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_10.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth9()));
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
                            type: PageTransitionType.fade, child: LeftBooth11()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth11 extends StatefulWidget {
  const LeftBooth11({Key? key}) : super(key: key);

  @override
  _LeftBooth11State createState() => _LeftBooth11State();
}

class _LeftBooth11State extends State<LeftBooth11> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_11.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth10()));
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
                            type: PageTransitionType.fade, child: LeftBooth12()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth12 extends StatefulWidget {
  const LeftBooth12({Key? key}) : super(key: key);

  @override
  _LeftBooth12State createState() => _LeftBooth12State();
}

class _LeftBooth12State extends State<LeftBooth12> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_12.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth11()));
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
                            type: PageTransitionType.fade, child: LeftBooth13()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth13 extends StatefulWidget {
  const LeftBooth13({Key? key}) : super(key: key);

  @override
  _LeftBooth13State createState() => _LeftBooth13State();
}

class _LeftBooth13State extends State<LeftBooth13> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_13.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth12()));
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
                            type: PageTransitionType.fade, child: LeftBooth14()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth14 extends StatefulWidget {
  const LeftBooth14({Key? key}) : super(key: key);

  @override
  _LeftBooth14State createState() => _LeftBooth14State();
}

class _LeftBooth14State extends State<LeftBooth14> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_14.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth13()));
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
                            type: PageTransitionType.fade, child: LeftBooth14()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth15 extends StatefulWidget {
  const LeftBooth15({Key? key}) : super(key: key);

  @override
  _LeftBooth15State createState() => _LeftBooth15State();
}

class _LeftBooth15State extends State<LeftBooth15> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_15.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth14()));
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
                            type: PageTransitionType.fade, child: LeftBooth16()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth16 extends StatefulWidget {
  const LeftBooth16({Key? key}) : super(key: key);

  @override
  _LeftBooth16State createState() => _LeftBooth16State();
}

class _LeftBooth16State extends State<LeftBooth16> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_16.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth15()));
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
                            type: PageTransitionType.fade, child: LeftBooth17()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth17 extends StatefulWidget {
  const LeftBooth17({Key? key}) : super(key: key);

  @override
  _LeftBooth17State createState() => _LeftBooth17State();
}

class _LeftBooth17State extends State<LeftBooth17> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_17.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth16()));
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
                            type: PageTransitionType.fade, child: LeftBooth18()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth18 extends StatefulWidget {
  const LeftBooth18({Key? key}) : super(key: key);

  @override
  _LeftBooth18State createState() => _LeftBooth18State();
}

class _LeftBooth18State extends State<LeftBooth18> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_18.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth17()));
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
                            type: PageTransitionType.fade, child: LeftBooth19()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth19 extends StatefulWidget {
  const LeftBooth19({Key? key}) : super(key: key);

  @override
  _LeftBooth19State createState() => _LeftBooth19State();
}

class _LeftBooth19State extends State<LeftBooth19> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_19.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth18()));
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
                            type: PageTransitionType.fade, child: LeftBooth20()));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingButton());
  }
}

class LeftBooth20 extends StatefulWidget {
  const LeftBooth20({Key? key}) : super(key: key);

  @override
  _LeftBooth20State createState() => _LeftBooth20State();
}

class _LeftBooth20State extends State<LeftBooth20> {
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
          child: Image.network(AssetsUrl.boothModelLeft + 'booth_20.webp'),
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
                            type: PageTransitionType.fade, child: LeftBooth19()));
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
