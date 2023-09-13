import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/category_model.dart';
import 'package:virtual_exhibition_beta/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/screens/product/product_detail.dart';

class CategoryPage extends StatefulWidget {
  final String booth_id;
  final String id;

  CategoryPage(this.booth_id, this.id);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  var loading = false;
  // ignore: deprecated_member_use
  final list = <Product>[];
  Future<void> _listProduct() async {
    // await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
     final response = await http.post(Uri.parse(BoothUrl.productCategory), body: {
      "booth_id": widget.booth_id,
      "category_id": widget.id,
    });
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
        final ab = Product(
            api['id'],
            api['booth_id'],
            api['vendor_id'],
            api['product_name'],
            api['product_description'],
            api['product_image'],
            api['product_assets'],
            api['category'],
            api['price'],
            api['stocks'],
            api['status']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
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
    _listProduct();
  }

  // List<String> litems = [
  //   "assets/bag/lv_bag.glb",
  //   "assets/bag/bag.glb",
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Container(
            //             width: MediaQuery.of(context).size.width / 1.05,
            //             height: MediaQuery.of(context).size.height / 13,
            //             child: ListView.builder(
            //               scrollDirection: Axis.horizontal,
            //               itemCount: categories.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 final x = categories[index];
            //                 return Column(
            //                   children: <Widget>[
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.symmetric(horizontal: 6),
            //                       child: OutlineButton(
            //                         borderSide: BorderSide(
            //                           color: Colors.black,
            //                         ),
            //                         shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(5),
            //                         ),
            //                         child: Text(
            //                           x.name,
            //                           style: TextStyle(
            //                             color: Colors.black,
            //                             fontSize: 13,
            //                             fontFamily: "Poppins Regular",
            //                           ),
            //                         ),
            //                         onPressed: () {
            //                           Navigator.pushReplacement(
            //                             context,
            //                             new MaterialPageRoute(
            //                               builder: (context) => CategoryPage(x.id),
            //                             ),
            //                           );
            //                         },
            //                       ),
            //                     ),
            //                   ],
            //                 );
            //               },
            //             ),
            //           ),
            list.isEmpty ? 
            Center(
              child: Container(
                child: Text("No Item Available"),
              )
            ) :
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
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: ProductDetail(x.product_assets, x.id)));
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
                      Image.network(AssetsUrl.product + x.product_image)
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