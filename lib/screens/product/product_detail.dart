import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/screens/product/asset_detail.dart';

class ProductDetail extends StatefulWidget {
  final String item_assets;
  final int id;
  ProductDetail(this.item_assets, this.id);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  var user_id;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id");
    });
  }

  var loading = false;
  // ignore: deprecated_member_use
  final list = <Product>[];
  Future<void> _itemDetail() async {
    // await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.post(Uri.parse(BoothUrl.productDetail), body: {
      "id": widget.id.toString(),
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

  save() async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(Uri.parse(OrderUrl.addCart), body: {
      "user_id": user_id.toString(),
      'quantity': amount.toString(),
      "product_id": widget.id.toString(),
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    // String messageEnglish = data['messageEnglish'];
    if (value == 1) {
      // setState(() {
      // Navigator.pop(context);
      // });
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) => _popUpGallery(context),
      // );
      // Navigator.pushReplacement(
      //   context,
      //   new MaterialPageRoute(
      //     builder: (context) => Login(),
      //   ),
      // );
      // login();
      // print(message);
      _showToastSuccess(message);
      setState(() {
        amount = 1;
      });
      // registerToast(message);

    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast(message);
      setState(() {
        amount = 1;
      });
      // registerToast(message);
    }
  }

  _showToast(String toast) {
    final snackbar = SnackBar(
      content: new Text(toast),
      backgroundColor: Colors.red,
    );
    // _scaffoldkey.currentState!.showSnackBar(snackbar);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: snackbar,
    //     duration: Duration(seconds: 2),
    //   ),
    // );

    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  _showToastSuccess(String toast) {
    final snackbar = SnackBar(
      content: new Text(toast),
      backgroundColor: Colors.green,
    );
    // _scaffoldkey.currentState!.showSnackBar(snackbar);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: snackbar,
    //     duration: Duration(seconds: 2),
    //   ),
    // );
     scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  int amount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.item_assets);
    _itemDetail();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(title: Text("Product Detail")),
    //     body: ModelViewer(
    //       // src: "http://virtual_exhibition.test/assets/images/booth_items/bag.glb",
    //       src: 'assets/images/booth_items/'+widget.item_assets,
    //       alt: "Product",
    //       ar: true,
    //       autoRotate: true,
    //       cameraControls: true,
    //     ),
    // );
    final ButtonStyle checkButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.blue,
      primary: Colors.blue,
      // minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.white,
          // body: ListView.builder(
          //   // child:
          //   itemCount: list.length,
          //   itemBuilder: (context, i) {
          //     final x = list[i];
          //     return Container(
          //       color: Color(0xFF171717),
          //       child: Column(
          //         children: <Widget>[
          //           Container(
          //             // width: MediaQuery.of(context).size.width,
          //             // height: MediaQuery.of(context).size.height / 1.8,
          //             // decoration: BoxDecoration(
          //             //   image: DecorationImage(
          //             //     image: NetworkImage(
          //             //         // "assets/img/post_one.jpg",
          //             //         ImageUrl.imageContent + x.post_img),
          //             //     fit: BoxFit.fill,
          //             //   ),
          //             // ),
          //             child: Stack(
          //               children: <Widget>[
          //                 InkWell(
          //                   onTap: (){
          //                   Navigator.pushReplacement(
          //                   context,
          //                   PageTransition(
          //                       type: PageTransitionType.fade,
          //                       child: AssetDetail(x.item_assets)));
          //                   },
          //                   child: Image(
          //                     image: NetworkImage(
          //                         // post,
          //                         AssetsUrl.items+ x.item_image),
          //                     width: double.infinity,
          //                     fit: BoxFit.fill,
          //                   ),
          //                 ),
          //                 new Align(
          //                   alignment: Alignment.topLeft,
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(15.0),
          //                     child: FloatingActionButton(
          //                         backgroundColor:
          //                             Color.fromRGBO(255, 255, 255, 0.5),
          //                         child: new Icon(
          //                           Icons.arrow_back,
          //                           color: Colors.black,
          //                         ),
          //                         onPressed: () {
          //                           Navigator.pop(context);
          //                         }),
          //                   ),
          //                 )
          //               ],
          //             ),
          //             //   Container(
          //             //     margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          //             //     child: Stack(
          //             //       alignment: Alignment.topLeft,
          //             //       children: <Widget>[
          //             //         Container(
          //             //           width: 35,
          //             //           height: 35,
          //             //           decoration: BoxDecoration(
          //             //             shape: BoxShape.circle,
          //             //             color: Colors.white,
          //             //             boxShadow: [
          //             //               new BoxShadow(
          //             //                 color: Colors.grey,
          //             //                 blurRadius: 4,
          //             //               ),
          //             //             ],
          //             //           ),
          //             //           child: IconButton(
          //             //             icon: Icon(
          //             //               Icons.arrow_back,
          //             //               color: Colors.black,
          //             //               size: 20,
          //             //             ),
          //             //             onPressed: () {
          //             //               Navigator.pop(context);
          //             //             },
          //             //           ),
          //             //         )
          //             //       ],
          //             //     ),
          //             //   ),
          //           ),
          //           Container(
          //             // color: Color(0xFF171717),
          //             // color: Color(0xFFF39C12),
          //             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          //             width: MediaQuery.of(context).size.width,
          //             // height: MediaQuery.of(context).size.height / 2,
          //             decoration: BoxDecoration(color: Colors.white),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 // InkWell(
          //                 //   onTap: (){
          //                 //   //   setState(() {
          //                 //   //         chat_user_id = post_user_id;
          //                 //   //       });
          //                 //   //   Navigator.pushReplacement(
          //                 //   //         context,
          //                 //   //         new MaterialPageRoute(
          //                 //   //           builder: (context) => UserProfile(chat_user_id),
          //                 //   //         ),
          //                 //   //       );
          //                 //   },
          //                 //     child: ListTile(
          //                 //     contentPadding: EdgeInsets.symmetric(
          //                 //         vertical: 0.0, horizontal: 0.0),
          //                 //     leading: Container(
          //                 //       padding: EdgeInsets.all(0),
          //                 //       width: 50,
          //                 //       height: 50,
          //                 //       decoration: BoxDecoration(
          //                 //         shape: BoxShape.circle,
          //                 //       ),
          //                 //       child: CircleAvatar(
          //                 //               backgroundColor: Colors.transparent,
          //                 //               // child: ClipOval(
          //                 //               // child: Image(
          //                 //               backgroundImage: NetworkImage(
          //                 //                   // "assets/img/icon_one.jpg",
          //                 //                   AssetsUrl.items + x.item_image),
          //                 //               // fit: BoxFit.fill,
          //                 //               minRadius: 40,
          //                 //               // ),
          //                 //               // ),
          //                 //             ),
          //                 //     ),
          //                 //     title: Text(
          //                 //       // "Tia Nurmala",
          //                 //       x.item_name,
          //                 //       style: TextStyle(
          //                 //         fontSize: 16,
          //                 //         fontFamily: "Poppins Semibold",
          //                 //       ),
          //                 //     ),
          //                 //     // subtitle: Text(
          //                 //     //   // "@tianurmala_",
          //                 //     //   x.user_username,
          //                 //     //   style: TextStyle(
          //                 //     //     color: Color(0xFF7F8C8D),
          //                 //     //     fontSize: 15,
          //                 //     //     fontFamily: "Poppins Regular",
          //                 //     //   ),
          //                 //     // ),
          //                 //   ),
          //                 // ),
          //                 Text(
          //                       // "Tia Nurmala",
          //                       x.item_name,
          //                       style: TextStyle(
          //                         fontSize: 25,
          //                         fontFamily: "Poppins Semibold",
          //                       ),
          //                 ),
          //                 SizedBox(height: 5),
          //                 // Text(
          //                 //   show_cat(x.post_cat_id),
          //                 //   // "Designer",
          //                 //   style: TextStyle(
          //                 //     color: Colors.black,
          //                 //     fontSize: 18,
          //                 //     fontFamily: "Poppins Semibold",
          //                 //   ),
          //                 // ),
          //                 // SizedBox(height: 5),
          //                 Text(
          //                   // "Description",
          //                   x.item_description,
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 15,
          //                     fontFamily: "Poppins Regular",
          //                   ),
          //                 ),
          //                 SizedBox(height: 15),
          //                 Text(
          //                   "Services",
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 18,
          //                     fontFamily: "Poppins Semibold",
          //                   ),
          //                 ),
          //                 // SizedBox(height: 15),
          //                 // Text(
          //                 //   // "Description",
          //                 //   x.post_offer,
          //                 //   style: TextStyle(
          //                 //     color: Colors.black,
          //                 //     fontSize: 15,
          //                 //     fontFamily: "Poppins Regular",
          //                 //   ),
          //                 // ),
          //                 SizedBox(height: 15),
          //                 Center(
          //                   child: SizedBox(
          //                     width: double.infinity,
          //                     child: RaisedButton(
          //                       color: new Color(0xFFF39C12),
          //                       splashColor: Colors.black,
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(5),
          //                       ),
          //                       padding: EdgeInsets.symmetric(vertical: 10),
          //                       onPressed: () async {
          //                         // submit();
          //                         // setState(() {
          //                         //   chat_user_id = post_user_id;
          //                         // });
          //                         // var navigationResult = await Navigator.pushReplacement(
          //                         //   context,
          //                         //   new MaterialPageRoute(
          //                         //     builder: (context) => ChatUserProfile(chat_user_id),
          //                         //   ),
          //                         // );
          //                         // // if (navigationResult == true) {
          //                         // //   MaterialPageRoute(
          //                         // //     builder: (context) => Chat(),
          //                         // //   );
          //                         // // }
          //                       },
          //                       child: Text(
          //                         "Collabs",
          //                         style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 18.0,
          //                           fontFamily: "Poppins Medium",
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(height: 15),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          body:
              // SingleChildScrollView(
              // child:
              Stack(
                children: [
                  // RefreshIndicator(
                  // key: _refresh,
                  // onRefresh: _allProduct,
                  ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        final x = list[i];
                        return Container(
                          color: Colors.black,
                          child: Column(
                            children: [
                              Stack(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      // Navigator.pushReplacement(
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
                                              child:
                                                  AssetDetail(x.product_assets)));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height / 2.5,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            AssetsUrl.product + x.product_image,
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: <Widget>[
                                            Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 300,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 30),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25),
                                          topLeft: Radius.circular(25),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: Text(
                                                    x.product_name,
                                                    // "Celana Jogger",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: "Poppins Regular",
                                                    ),
                                                    maxLines: 2,
                                                    softWrap: false,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Column(
                                              // children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Text(
                                                    x.price.toString() + ' SGD',
                                                    // "100000 SGD",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Poppins Bold",
                                                    )),
                                              ),
                                              // ],
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      'Stock : ' +
                                                          x.stocks.toString(),
                                                      // "100000 SGD",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "Poppins Regular",
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(height: 10),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 20.0),
                                          //   child: Text(
                                          //     "Warna",
                                          //     style: TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 15,
                                          //       fontFamily: "Poppins Medium",
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(height: 5),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 35.0),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: <Widget>[
                                          //       Warna(
                                          //         warna: "Merah",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Hitam",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Biru",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Ungu",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Kuning",
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 35.0),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: <Widget>[
                                          //       Warna(
                                          //         warna: "Merah",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Hitam",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Biru",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Ungu",
                                          //       ),
                                          //       Warna(
                                          //         warna: "Kuning",
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // SizedBox(height: 15),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 20.0),
                                          //   child: Text(
                                          //     "Ukuran",
                                          //     style: TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 15,
                                          //       fontFamily: "Poppins Medium",
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(height: 5),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 35.0),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: <Widget>[
                                          //       Ukuran(
                                          //         ukuran: "XXL",
                                          //       ),
                                          //       Ukuran(
                                          //         ukuran: "XL",
                                          //       ),
                                          //       Ukuran(
                                          //         ukuran: "L",
                                          //       ),
                                          //       Ukuran(
                                          //         ukuran: "M",
                                          //       ),
                                          //       Ukuran(
                                          //         ukuran: "S",
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Detail Produk",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: "Poppins Medium",
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  // "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                                  x.product_description,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: "Poppins Regular",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 80,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 15.0, bottom: 45.0),
                                  //   child: Center(
                                  //     child: Container(
                                  //       width: MediaQuery.of(context).size.width,
                                  //       padding: const EdgeInsets.symmetric(horizontal: 60),
                                  //       child: RaisedButton(
                                  //         color: new Color(0xffe3724b),
                                  //         shape: RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.circular(5),
                                  //         ),
                                  //         padding: EdgeInsets.symmetric(vertical: 10),
                                  //         onPressed: () {
                                  //           // Navigator.pushReplacement(
                                  //           //     context,
                                  //           //     MaterialPageRoute(
                                  //           //         builder: (context) =>
                                  //           //             KeranjangPage()));
                                  //           save();
                                  //         },
                                  //         child: Text(
                                  //           "Tambah Keranjang",
                                  //           style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 16.0,
                                  //             fontFamily: "Poppins Regular",
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                              // SizedBox(
                              //   height: 80,
                              // )
                            ],
                          ),
                        );
                      }
                      // ),
                      ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.5,
                            blurRadius: 3,
                            offset: Offset(0.5, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Quantity",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins Bold",
                                      fontSize: 11)),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          offset: Offset(
                                              0, 0.5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        // saveMinus(x.id);
                                        // setState(() {
                                        //   jumlah--;
                                        // });
                                        setState(() {
                                          amount -= 1;
                                        });
                                      },
                                      icon: Icon(Icons.remove,
                                          size: 14, color: Colors.black),
                                    ),
                                  ),
                                  // for (var o = 0;
                                  //     o < list.length;
                                  //     o++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(amount.toString()),
                                    // child: Text(''),
                                  ),
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          offset: Offset(
                                              0, 0.5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      // color: Colors.white,
                                      onPressed: () {
                                        // saveAdd(x.id);
                                        // setState(() {
                                        //   jumlah++;
                                        // });
                                        setState(() {
                                          amount += 1;
                                        });
                                      },
                                      icon: Icon(Icons.add,
                                          size: 14, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(3),
                            // ),
                            // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                            onPressed: () {
                              // showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //   builder: (BuildContext context) =>
                              //       _loadAddress(context),
                              // );
                              // orderNow();
                              // if (list_setting[0].status == 1) {
                              //   Route route =
                              //       MaterialPageRoute(builder: (context) => CheckOut());
                              //   Navigator.pushReplacement(context, route).then(onGoBack);
                              // } else {}
                              save();
                            },
                            // color: Colors.blue,
                            style: checkButtonStyle,
                            // color: Color(0xffe3724b),
                            child: Text("Add To Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: "Poppins Regular",
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
