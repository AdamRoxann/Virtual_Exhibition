import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/category_model.dart';
import 'package:virtual_exhibition_beta/model/exhibitor_model.dart';
import 'package:virtual_exhibition_beta/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/screens/product/category_page.dart';
import 'package:virtual_exhibition_beta/screens/product/product_detail.dart';

class ExhibitorList extends StatefulWidget {
  const ExhibitorList({Key? key}) : super(key: key);

  @override
  State<ExhibitorList> createState() => _ExhibitorListState();
}

class _ExhibitorListState extends State<ExhibitorList> {
  var loading = false;
  // ignore: deprecated_member_use
  final list = <ExhibitorModel>[];
  Future<void> _listExhibitor() async {
    // await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(BoothUrl.exhibitorList));
    if (response.contentLength == 2) {
      //   await getPref();
      // final response =
      //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
      //   "user_id": user_id,
      //   "location_country": location_country,
      //   "location_city": location_city,
      //   "location_user_id": user_id
      // });

      // final data = jsonDecode(response.body);
      // int value = data['value'];
      // String message = data['message'];
      // String changeProf = data['changeProf'];
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = ExhibitorModel(
            api['id'],
            api['vendor_id'],
            api['booth_name'],
            api['type'],
            api['image'],
            api['status']);
        list.add(ab);
      });
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  List<Category> categories = [
    Category(
      '1',
      'Jewellery',
    ),
    Category(
      '2',
      'Bags',
    ),
    Category(
      '3',
      'Timepieces',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listExhibitor();
  }

  // List<String> litems = [
  //   "assets/bag/lv_bag.glb",
  //   "assets/bag/bag.glb",
  // ];

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.black,
      // minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          return BorderSide(
            color: Colors.black,
            width: 1,
          );
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text("Exhibitor List")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width / 1.05,
            //   height: MediaQuery.of(context).size.height / 13,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: categories.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       final x = categories[index];
            //       return Column(
            //         children: <Widget>[
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 6),
            //             child: OutlinedButton(
            //               style: outlineButtonStyle,
            //               // borderSide: BorderSide(
            //               //   color: Colors.black,
            //               // ),
            //               // shape: RoundedRectangleBorder(
            //               //   borderRadius: BorderRadius.circular(5),
            //               // ),
            //               child: Text(
            //                 x.name,
            //                 style: TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 13,
            //                   fontFamily: "Poppins Regular",
            //                 ),
            //               ),
            //               onPressed: () {
            //                 // Navigator.pushReplacement(
            //                 //   context,
            //                 //   new MaterialPageRoute(
            //                 //     builder: (context) =>
            //                 //         CategoryPage(widget.booth_id, x.id),
            //                 //   ),
            //                 // );
            //               },
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    // childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: list.length,
                itemBuilder: (BuildContext ctx, index) {
                  final x = list[index];
                  return Container(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          // Navigator.pushReplacement(
                          //     context,
                          //     PageTransition(
                          //         type: PageTransitionType.fade,
                          //         child:
                          //             ProductDetail(x.product_assets, x.id)));
                        },
                        child:
                            // ModelViewer(
                            //   backgroundColor: Colors.blueGrey,
                            //   src: AssetsUrl.items + x.item_assets,
                            //   alt: "A 3D model of an astronaut",
                            //   ar: true,
                            //   autoRotate: true,
                            //   cameraControls: true,
                            // ),
                            Column(
                              children: [
                                Image.network(BoothUrl.tv + x.image),
                                Container(child: Text(x.booth_name),)
                              ],
                            )
                            // Container(child: Text(x.booth_name),)
                            ),
                    //   Text(litems[index]),
                    //   decoration: BoxDecoration(
                    //       color: Colors.amber,
                    //       borderRadius: BorderRadius.circular(15)),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
