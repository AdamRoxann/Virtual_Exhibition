// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_exhibition_beta/screens/lobby/lobby.dart';

class PlaceBid extends StatefulWidget {
  const PlaceBid({Key? key}) : super(key: key);

  @override
  _PlaceBidState createState() => _PlaceBidState();
}

class _PlaceBidState extends State<PlaceBid> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.6,
      child: Opacity(
        opacity: 1,
        // child: Image.network(image),
        child: CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 330,
                    child: Center(
                      child: Image.asset(
                        "assets/images/auction/royal_chest.png",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // content: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //         padding: const EdgeInsets.only(top: 8.0),
          //         child: Stack(
          //           children: [
          //             Container(
          //               height: 330,
          //               child: Center(
          //                 child: Image.asset(
          //                   "assets/images/auction/royal_chest.png",
          //                   // fit: BoxFit.cover,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         )),
          //   ],
          // ),
        ),
      ),
    );
  }
}
