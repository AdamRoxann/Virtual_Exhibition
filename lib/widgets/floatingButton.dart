// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/auth/login.dart';
import 'package:virtual_exhibition_beta/profile/profile_page.dart';
import 'package:virtual_exhibition_beta/screens/chat/list_conversation.dart';
import 'package:virtual_exhibition_beta/screens/exhibitor/exhibitor_list.dart';
import 'package:virtual_exhibition_beta/screens/order/cart.dart';
import 'package:virtual_exhibition_beta/vendor/order.dart';
import 'package:virtual_exhibition_beta/widgets/maps.dart';

class FloatingButton extends StatefulWidget {
  final String? jumpActive;
  final bool? isVendor;
  const FloatingButton({Key? key, this.jumpActive, this.isVendor = false})
      : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  LoginStatus loginStatus = LoginStatus.notSignIn;
  @override
  Widget build(BuildContext context) {
    return widget.isVendor == true
        ? SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Color(0xFF264C95),
            children: [
                SpeedDialChild(
                    child: Icon(Icons.person),
                    label: "Profile",
                    onTap: () {
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             ZoomImage(x.product_img)));
                      // showDialog(
                      //   barrierDismissible: true,
                      //   context: context,
                      //   builder: (BuildContext context) =>
                      //       image(context, x.item_image),
                      // );
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfilePage(
                                isVendor: true,
                              )));
                    }),
                // SpeedDialChild(
                //   child: Icon(Icons.shopping_cart_rounded),
                //   label: "Open Cart",
                //   onTap: (){
                //                       //     context,
                //                       //     MaterialPageRoute(
                //                       //         builder: (context) =>
                //                       //             ZoomImage(x.product_img)));
                //                       // showDialog(
                //                       //   barrierDismissible: true,
                //                       //   context: context,
                //                       //   builder: (BuildContext context) =>
                //                       //       image(context, x.item_image),
                //                       // );
                //                       Navigator.pushReplacement(
                //                       context,
                //                       PageTransition(
                //                           type: PageTransitionType.fade,
                //                           child: Cart()));
                //   }
                // ),
                // SpeedDialChild(
                //   child: Icon(Icons.map),
                //   label: "Open Maps",
                //   onTap: (){
                //   showDialog(
                //     barrierDismissible: true,
                //     context: context,
                //     builder: (BuildContext context) => Maps(jumpActive : widget.jumpActive),
                //   );
                //   }
                // ),
                SpeedDialChild(
                    child: Icon(Icons.message),
                    label: "Open Message",
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ListConversation()));
                    }),
                SpeedDialChild(
                    child: Icon(Icons.message),
                    label: "Orders",
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: OrderPage()));
                    }),
                SpeedDialChild(
                  child: Icon(Icons.logout),
                  label: "Logout",
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    setState(() {
                      preferences.setInt('value', 0);
                      preferences.commit();
                      loginStatus = LoginStatus.notSignIn;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginPage(false)));
                  },
                ),
              ])
        : SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Color(0xFF264C95),
            children: [
                SpeedDialChild(
                    child: Icon(Icons.person),
                    label: "Profile",
                    onTap: () {
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             ZoomImage(x.product_img)));
                      // showDialog(
                      //   barrierDismissible: true,
                      //   context: context,
                      //   builder: (BuildContext context) =>
                      //       image(context, x.item_image),
                      // );
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfilePage()));
                    }),
                SpeedDialChild(
                    child: Icon(Icons.shopping_cart_rounded),
                    label: "Open Cart",
                    onTap: () {
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             ZoomImage(x.product_img)));
                      // showDialog(
                      //   barrierDismissible: true,
                      //   context: context,
                      //   builder: (BuildContext context) =>
                      //       image(context, x.item_image),
                      // );
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: Cart()));
                    }),
                SpeedDialChild(
                    child: Icon(Icons.map),
                    label: "Open Maps",
                    onTap: () {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) =>
                            Maps(jumpActive: widget.jumpActive),
                      );
                    }),
                SpeedDialChild(
                    child: Icon(Icons.emoji_people),
                    label: "Exhibitor List",
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ExhibitorList()));
                    }),
                SpeedDialChild(
                    child: Icon(Icons.message),
                    label: "Open Message",
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ListConversation()));
                    }),
                SpeedDialChild(
                  child: Icon(Icons.logout),
                  label: "Logout",
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    setState(() {
                      preferences.setInt('value', 0);
                      preferences.commit();
                      loginStatus = LoginStatus.notSignIn;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginPage(false)));
                  },
                ),
              ]);
  }
}
