// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:virtual_exhibition_beta/config/url.dart';
// import 'package:virtual_exhibition_beta/model/product_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:virtual_exhibition_beta/screens/product/asset_detail.dart';

// class AuctionDetail extends StatefulWidget {
//   // final String item_assets;
//   // final int id;
//   // AuctionDetail(this.item_assets, this.id);

//   @override
//   State<AuctionDetail> createState() => _AuctionDetailState();
// }

// class _AuctionDetailState extends State<AuctionDetail> {
//   final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

//   var user_id;

//   getPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       user_id = preferences.getString("id");
//     });
//   }

//   // var loading = false;
//   // // ignore: deprecated_member_use
//   // final list = <Product>[];
//   // Future<void> _itemDetail() async {
//   //   // await getPref();
//   //   list.clear();
//   //   setState(() {
//   //     loading = true;
//   //   });
//   //    final response = await http.post(Uri.parse(BoothUrl.auction_detail), body: {
//   //     "id": widget.id.toString(),
//   //   });
//   //   if (response.contentLength == 2) {
//   //     //   await getPref();
//   //     // final response =
//   //     //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
//   //     //   "user_id": user_id,
//   //     //   "location_country": location_country,
//   //     //   "location_city": location_city,
//   //     //   "location_user_id": user_id
//   //     // });

//   //     // final data = jsonDecode(response.body);
//   //     // int value = data['value'];
//   //     // String message = data['message'];
//   //     // String changeProf = data['changeProf'];
//   //   } else {
//   //     final data = jsonDecode(response.body);
//   //     data.forEach((api) {
//   //       final ab = Product(
//   //           api['id'],
//   //           api['booth_id'],
//   //           api['vendor_id'],
//   //           api['product_name'],
//   //           api['product_description'],
//   //           api['product_image'],
//   //           api['product_assets'],
//   //           api['category'],
//   //           api['price'],
//   //           api['stocks'],
//   //           api['status']);
//   //       list.add(ab);
//   //     });
//   //     setState(() {
//   //       loading = false;
//   //     });
//   //   }
//   // }

//   // save() async {
//   //   await getPref();
//   //   // showDialog(
//   //   //   barrierDismissible: false,
//   //   //   context: context,
//   //   //   builder: (BuildContext context) => _loading(context),
//   //   // );
//   //   final response = await http.post(Uri.parse(OrderUrl.addCart), body: {
//   //     "user_id": user_id.toString(),
//   //     'quantity': amount.toString(),
//   //     "product_id": widget.id.toString(),
//   //   });

//   //   final data = jsonDecode(response.body);
//   //   int value = data['value'];
//   //   String message = data['message'];
//   //   // String messageEnglish = data['messageEnglish'];
//   //   if (value == 1) {
//   //     // setState(() {
//   //     // Navigator.pop(context);
//   //     // });
//   //     // showDialog(
//   //     //   context: context,
//   //     //   builder: (BuildContext context) => _popUpGallery(context),
//   //     // );
//   //     // Navigator.pushReplacement(
//   //     //   context,
//   //     //   new MaterialPageRoute(
//   //     //     builder: (context) => Login(),
//   //     //   ),
//   //     // );
//   //     // login();
//   //     // print(message);
//   //     _showToastSuccess(message);
//   //     setState(() {
//   //       amount = 1;
//   //     });
//   //     // registerToast(message);

//   //   } else {
//   //     // print(message);
//   //     // Navigator.pop(context);
//   //     _showToast(message);
//   //     setState(() {
//   //       amount = 1;
//   //     });
//   //     // registerToast(message);
//   //   }
//   // }

//   _showToast(String toast) {
//     final snackbar = SnackBar(
//       content: new Text(toast),
//       backgroundColor: Colors.red,
//     );
//     _scaffoldkey.currentState!.showSnackBar(snackbar);
//   }

//   _showToastSuccess(String toast) {
//     final snackbar = SnackBar(
//       content: new Text(toast),
//       backgroundColor: Colors.green,
//     );
//     _scaffoldkey.currentState!.showSnackBar(snackbar);
//   }

//   int amount = 1;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // print(widget.item_assets);
//     // _itemDetail();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //     appBar: AppBar(title: Text("Product Detail")),
//     //     body: ModelViewer(
//     //       // src: "http://virtual_exhibition.test/assets/images/booth_items/bag.glb",
//     //       src: 'assets/images/booth_items/'+widget.item_assets,
//     //       alt: "Product",
//     //       ar: true,
//     //       autoRotate: true,
//     //       cameraControls: true,
//     //     ),
//     // );
//     return Scaffold(
//       key: _scaffoldkey,
//       backgroundColor: Colors.white,
//       body:
//             // SingleChildScrollView(
//             // child:
//             Stack(
//           children: [
//             // RefreshIndicator(
//               // key: _refresh,
//               // onRefresh: _allProduct,
//             //   ListView.builder(
//             //       itemCount: list.length,
//             //       itemBuilder: (context, i) {
//             //         final x = list[i];
//             //         return Container(
//             //           color: Colors.black,
//             //           child: Column(
//             //             children: [
//             //               Stack(
//             //                 children: <Widget>[
//             //                   InkWell(
//             //                     onTap: () {
//             //                       // Navigator.pushReplacement(
//             //                       //     context,
//             //                       //     MaterialPageRoute(
//             //                       //         builder: (context) =>
//             //                       //             ZoomImage(x.product_img)));
//             //                       // showDialog(
//             //                       //   barrierDismissible: true,
//             //                       //   context: context,
//             //                       //   builder: (BuildContext context) =>
//             //                       //       image(context, x.item_image),
//             //                       // );
//             //                       Navigator.pushReplacement(
//             //                       context,
//             //                       PageTransition(
//             //                           type: PageTransitionType.fade,
//             //                           child: AssetDetail(x.product_assets)));
//             //                     },
//             //                     child: Container(
//             //                       width: MediaQuery.of(context).size.width,
//             //                       height:
//             //                           MediaQuery.of(context).size.height / 2.5,
//             //                       decoration: BoxDecoration(
//             //                         color: Colors.black,
//             //                         image: DecorationImage(
//             //                           image: NetworkImage(
//             //                             AssetsUrl.product + x.product_image,
//             //                           ),
//             //                           fit: BoxFit.contain,
//             //                         ),
//             //                       ),
//             //                       child: Container(
//             //                         margin: EdgeInsets.symmetric(
//             //                             vertical: 20, horizontal: 20),
//             //                         child: Stack(
//             //                           alignment: Alignment.topLeft,
//             //                           children: <Widget>[
//             //                             Container(
//             //                               width: 35,
//             //                               height: 35,
//             //                               decoration: BoxDecoration(
//             //                                 shape: BoxShape.circle,
//             //                                 color: Colors.white,
//             //                                 boxShadow: [
//             //                                   new BoxShadow(
//             //                                     color: Colors.grey,
//             //                                     blurRadius: 4,
//             //                                   ),
//             //                                 ],
//             //                               ),
//             //                               child: IconButton(
//             //                                 icon: Icon(
//             //                                   Icons.arrow_back,
//             //                                   color: Colors.black,
//             //                                   size: 20,
//             //                                 ),
//             //                                 onPressed: () {
//             //                                   Navigator.pop(context);
//             //                                 },
//             //                               ),
//             //                             )
//             //                           ],
//             //                         ),
//             //                       ),
//             //                     ),
//             //                   ),

//             //                   Padding(
//             //                     padding: const EdgeInsets.only(
//             //                       top: 300,
//             //                     ),
//             //                     child: Container(
//             //                       padding: EdgeInsets.symmetric(vertical: 30),
//             //                       decoration: BoxDecoration(
//             //                         color: Colors.white,
//             //                         borderRadius: BorderRadius.only(
//             //                           topRight: Radius.circular(25),
//             //                           topLeft: Radius.circular(25),
//             //                         ),
//             //                       ),
//             //                       child: Column(
//             //                         crossAxisAlignment:
//             //                             CrossAxisAlignment.start,
//             //                         children: <Widget>[
//             //                           Padding(
//             //                             padding: const EdgeInsets.symmetric(
//             //                                 horizontal: 20),
//             //                             child: Row(
//             //                               mainAxisAlignment:
//             //                                   MainAxisAlignment.spaceBetween,
//             //                               children: <Widget>[
//             //                                 Container(
//             //                                   width: MediaQuery.of(context)
//             //                                           .size
//             //                                           .width *
//             //                                       0.7,
//             //                                   child: Text(
//             //                                     x.product_name,
//             //                                     // "Celana Jogger",
//             //                                     style: TextStyle(
//             //                                       fontSize: 17,
//             //                                       fontFamily: "Poppins Regular",
//             //                                     ),
//             //                                     maxLines: 2,
//             //                                     softWrap: false,
//             //                                     overflow: TextOverflow.ellipsis,
//             //                                   ),
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                           SizedBox(height: 10),
//             //                           Row(
//             //                             mainAxisAlignment:
//             //                                 MainAxisAlignment.spaceBetween,
//             //                             children: [
//             //                               // Column(
//             //                               // children: [
//             //                               Padding(
//             //                                 padding: const EdgeInsets.symmetric(
//             //                                     horizontal: 20),
//             //                                 child: Text(
//             //                                     x.price.toString() + ' SGD',
//             //                                     // "100000 SGD",
//             //                                     style: TextStyle(
//             //                                       fontSize: 16,
//             //                                       fontFamily: "Poppins Bold",
//             //                                     )),
//             //                               ),
//             //                               // ],
//             //                               // ),
//             //                               Padding(
//             //                                 padding: const EdgeInsets.symmetric(
//             //                                     horizontal: 20),
//             //                                 child: Align(
//             //                                   alignment: Alignment.centerRight,
//             //                                   child: Text(
//             //                                       'Stock : ' +
//             //                                           x.stocks.toString(),
//             //                                       // "100000 SGD",
//             //                                       style: TextStyle(
//             //                                         fontSize: 14,
//             //                                         fontFamily:
//             //                                             "Poppins Regular",
//             //                                       )),
//             //                                 ),
//             //                               ),
//             //                             ],
//             //                           ),
//             //                           // SizedBox(height: 10),
//             //                           // Padding(
//             //                           //   padding: const EdgeInsets.symmetric(
//             //                           //       horizontal: 20.0),
//             //                           //   child: Text(
//             //                           //     "Warna",
//             //                           //     style: TextStyle(
//             //                           //       color: Colors.black,
//             //                           //       fontSize: 15,
//             //                           //       fontFamily: "Poppins Medium",
//             //                           //     ),
//             //                           //   ),
//             //                           // ),
//             //                           // SizedBox(height: 5),
//             //                           // Padding(
//             //                           //   padding: const EdgeInsets.symmetric(
//             //                           //       horizontal: 35.0),
//             //                           //   child: Row(
//             //                           //     mainAxisAlignment: MainAxisAlignment.center,
//             //                           //     children: <Widget>[
//             //                           //       Warna(
//             //                           //         warna: "Merah",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Hitam",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Biru",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Ungu",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Kuning",
//             //                           //       ),
//             //                           //     ],
//             //                           //   ),
//             //                           // ),
//             //                           // Padding(
//             //                           //   padding: const EdgeInsets.symmetric(
//             //                           //       horizontal: 35.0),
//             //                           //   child: Row(
//             //                           //     mainAxisAlignment: MainAxisAlignment.center,
//             //                           //     children: <Widget>[
//             //                           //       Warna(
//             //                           //         warna: "Merah",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Hitam",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Biru",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Ungu",
//             //                           //       ),
//             //                           //       Warna(
//             //                           //         warna: "Kuning",
//             //                           //       ),
//             //                           //     ],
//             //                           //   ),
//             //                           // ),
//             //                           // SizedBox(height: 15),
//             //                           // Padding(
//             //                           //   padding: const EdgeInsets.symmetric(
//             //                           //       horizontal: 20.0),
//             //                           //   child: Text(
//             //                           //     "Ukuran",
//             //                           //     style: TextStyle(
//             //                           //       color: Colors.black,
//             //                           //       fontSize: 15,
//             //                           //       fontFamily: "Poppins Medium",
//             //                           //     ),
//             //                           //   ),
//             //                           // ),
//             //                           // SizedBox(height: 5),
//             //                           // Padding(
//             //                           //   padding: const EdgeInsets.symmetric(
//             //                           //       horizontal: 35.0),
//             //                           //   child: Row(
//             //                           //     mainAxisAlignment: MainAxisAlignment.center,
//             //                           //     children: <Widget>[
//             //                           //       Ukuran(
//             //                           //         ukuran: "XXL",
//             //                           //       ),
//             //                           //       Ukuran(
//             //                           //         ukuran: "XL",
//             //                           //       ),
//             //                           //       Ukuran(
//             //                           //         ukuran: "L",
//             //                           //       ),
//             //                           //       Ukuran(
//             //                           //         ukuran: "M",
//             //                           //       ),
//             //                           //       Ukuran(
//             //                           //         ukuran: "S",
//             //                           //       ),
//             //                           //     ],
//             //                           //   ),
//             //                           // ),
//             //                           SizedBox(height: 20),
//             //                           Padding(
//             //                             padding: const EdgeInsets.symmetric(
//             //                                 horizontal: 20.0),
//             //                             child: Column(
//             //                               crossAxisAlignment:
//             //                                   CrossAxisAlignment.start,
//             //                               children: <Widget>[
//             //                                 Text(
//             //                                   "Detail Produk",
//             //                                   style: TextStyle(
//             //                                     color: Colors.black,
//             //                                     fontSize: 15,
//             //                                     fontFamily: "Poppins Medium",
//             //                                   ),
//             //                                 ),
//             //                                 SizedBox(height: 10),
//             //                                 Text(
//             //                                   // "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//             //                                   x.product_description,
//             //                                   style: TextStyle(
//             //                                     color: Colors.black,
//             //                                     fontSize: 13,
//             //                                     fontFamily: "Poppins Regular",
//             //                                   ),
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                           SizedBox(
//             //                             height: 80,
//             //                           )
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ),
//             //                   // Padding(
//             //                   //   padding: const EdgeInsets.only(top: 15.0, bottom: 45.0),
//             //                   //   child: Center(
//             //                   //     child: Container(
//             //                   //       width: MediaQuery.of(context).size.width,
//             //                   //       padding: const EdgeInsets.symmetric(horizontal: 60),
//             //                   //       child: RaisedButton(
//             //                   //         color: new Color(0xffe3724b),
//             //                   //         shape: RoundedRectangleBorder(
//             //                   //           borderRadius: BorderRadius.circular(5),
//             //                   //         ),
//             //                   //         padding: EdgeInsets.symmetric(vertical: 10),
//             //                   //         onPressed: () {
//             //                   //           // Navigator.pushReplacement(
//             //                   //           //     context,
//             //                   //           //     MaterialPageRoute(
//             //                   //           //         builder: (context) =>
//             //                   //           //             KeranjangPage()));
//             //                   //           save();
//             //                   //         },
//             //                   //         child: Text(
//             //                   //           "Tambah Keranjang",
//             //                   //           style: TextStyle(
//             //                   //             color: Colors.white,
//             //                   //             fontSize: 16.0,
//             //                   //             fontFamily: "Poppins Regular",
//             //                   //           ),
//             //                   //         ),
//             //                   //       ),
//             //                   //     ),
//             //                   //   ),
//             //                   // )
//             //                 ],
//             //               ),
//             //               // SizedBox(
//             //               //   height: 80,
//             //               // )
//             //             ],
//             //           ),
//             //         );
//             //       }
//             //       // ),
//             // ),
//             Container(
//                       color: Colors.black,
//                       child: Column(
//                         children: [
//                           Stack(
//                             children: <Widget>[
//                               InkWell(
//                                 onTap: () {
//                                   // Navigator.pushReplacement(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             ZoomImage(x.product_img)));
//                                   // showDialog(
//                                   //   barrierDismissible: true,
//                                   //   context: context,
//                                   //   builder: (BuildContext context) =>
//                                   //       image(context, x.item_image),
//                                   // );
//                                   // Navigator.pushReplacement(
//                                   // context,
//                                   // PageTransition(
//                                   //     type: PageTransitionType.fade,
//                                   //     child: AssetDetail(x.product_assets)));
//                                 },
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                       MediaQuery.of(context).size.height / 2.5,
//                                   decoration: BoxDecoration(
//                                     color: Colors.black,
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         'assets/images/auction/royal_chest.png',
//                                       ),
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                   child: Container(
//                                     margin: EdgeInsets.symmetric(
//                                         vertical: 20, horizontal: 20),
//                                     child: Stack(
//                                       alignment: Alignment.topLeft,
//                                       children: <Widget>[
//                                         Container(
//                                           width: 35,
//                                           height: 35,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Colors.white,
//                                             boxShadow: [
//                                               new BoxShadow(
//                                                 color: Colors.grey,
//                                                 blurRadius: 4,
//                                               ),
//                                             ],
//                                           ),
//                                           child: IconButton(
//                                             icon: Icon(
//                                               Icons.arrow_back,
//                                               color: Colors.black,
//                                               size: 20,
//                                             ),
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 300,
//                                 ),
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(vertical: 30),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(25),
//                                       topLeft: Radius.circular(25),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Container(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.7,
//                                               child: Text(
//                                                 // x.product_name,
//                                                 "Royal Gun",
//                                                 style: TextStyle(
//                                                   fontSize: 17,
//                                                   fontFamily: "Poppins Regular",
//                                                 ),
//                                                 maxLines: 2,
//                                                 softWrap: false,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           // Column(
//                                           // children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 20),
//                                             child: Text(
//                                                 // x.price.toString() + ' SGD',
//                                                 "Creator",
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontFamily: "Poppins Bold",
//                                                 )),
//                                           ),
//                                           // ],
//                                           // ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 20),
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: Text(
//                                                   // 'Stock : ' +
//                                                   //     x.stocks.toString(),
//                                                   "Ending in",
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontFamily:
//                                                         "Poppins Regular",
//                                                   )),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 8),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           // Column(
//                                           // children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 20),
//                                             child: Text(
//                                                 // x.price.toString() + ' SGD',
//                                                 "Vendor1",
//                                                 style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontFamily: "Poppins Bold",
//                                                 )),
//                                           ),
//                                           // ],
//                                           // ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 20),
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: Text(
//                                                   // 'Stock : ' +
//                                                   //     x.stocks.toString(),
//                                                   "Stocks : 1",
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontFamily:
//                                                         "Poppins Regular",
//                                                   )),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       // SizedBox(height: 10),
//                                       // Row(
//                                       //   mainAxisAlignment:
//                                       //       MainAxisAlignment.spaceBetween,
//                                       //   children: [
//                                       //     // Column(
//                                       //     // children: [
//                                       //     Padding(
//                                       //       padding: const EdgeInsets.symmetric(
//                                       //           horizontal: 20),
//                                       //       child: Text(
//                                       //           // x.price.toString() + ' SGD',
//                                       //           "100000 SGD",
//                                       //           style: TextStyle(
//                                       //             fontSize: 16,
//                                       //             fontFamily: "Poppins Bold",
//                                       //           )),
//                                       //     ),
//                                       //     // ],
//                                       //     // ),
//                                       //     Padding(
//                                       //       padding: const EdgeInsets.symmetric(
//                                       //           horizontal: 20),
//                                       //       child: Align(
//                                       //         alignment: Alignment.centerRight,
//                                       //         child: Text(
//                                       //             // 'Stock : ' +
//                                       //             //     x.stocks.toString(),
//                                       //             "Stocks : 1",
//                                       //             style: TextStyle(
//                                       //               fontSize: 14,
//                                       //               fontFamily:
//                                       //                   "Poppins Regular",
//                                       //             )),
//                                       //       ),
//                                       //     ),
//                                       //   ],
//                                       // ),
//                                       // SizedBox(height: 10),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.symmetric(
//                                       //       horizontal: 20.0),
//                                       //   child: Text(
//                                       //     "Warna",
//                                       //     style: TextStyle(
//                                       //       color: Colors.black,
//                                       //       fontSize: 15,
//                                       //       fontFamily: "Poppins Medium",
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                       // SizedBox(height: 5),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.symmetric(
//                                       //       horizontal: 35.0),
//                                       //   child: Row(
//                                       //     mainAxisAlignment: MainAxisAlignment.center,
//                                       //     children: <Widget>[
//                                       //       Warna(
//                                       //         warna: "Merah",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Hitam",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Biru",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Ungu",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Kuning",
//                                       //       ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.symmetric(
//                                       //       horizontal: 35.0),
//                                       //   child: Row(
//                                       //     mainAxisAlignment: MainAxisAlignment.center,
//                                       //     children: <Widget>[
//                                       //       Warna(
//                                       //         warna: "Merah",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Hitam",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Biru",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Ungu",
//                                       //       ),
//                                       //       Warna(
//                                       //         warna: "Kuning",
//                                       //       ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       // SizedBox(height: 15),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.symmetric(
//                                       //       horizontal: 20.0),
//                                       //   child: Text(
//                                       //     "Ukuran",
//                                       //     style: TextStyle(
//                                       //       color: Colors.black,
//                                       //       fontSize: 15,
//                                       //       fontFamily: "Poppins Medium",
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                       // SizedBox(height: 5),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.symmetric(
//                                       //       horizontal: 35.0),
//                                       //   child: Row(
//                                       //     mainAxisAlignment: MainAxisAlignment.center,
//                                       //     children: <Widget>[
//                                       //       Ukuran(
//                                       //         ukuran: "XXL",
//                                       //       ),
//                                       //       Ukuran(
//                                       //         ukuran: "XL",
//                                       //       ),
//                                       //       Ukuran(
//                                       //         ukuran: "L",
//                                       //       ),
//                                       //       Ukuran(
//                                       //         ukuran: "M",
//                                       //       ),
//                                       //       Ukuran(
//                                       //         ukuran: "S",
//                                       //       ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       SizedBox(height: 20),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Text(
//                                               "Detail Produk",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 15,
//                                                 fontFamily: "Poppins Medium",
//                                               ),
//                                             ),
//                                             SizedBox(height: 10),
//                                             Text(
//                                               "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//                                               // "Lorem",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 13,
//                                                 fontFamily: "Poppins Regular",
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 300,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               // Padding(
//                               //   padding: const EdgeInsets.only(top: 15.0, bottom: 45.0),
//                               //   child: Center(
//                               //     child: Container(
//                               //       width: MediaQuery.of(context).size.width,
//                               //       padding: const EdgeInsets.symmetric(horizontal: 60),
//                               //       child: RaisedButton(
//                               //         color: new Color(0xffe3724b),
//                               //         shape: RoundedRectangleBorder(
//                               //           borderRadius: BorderRadius.circular(5),
//                               //         ),
//                               //         padding: EdgeInsets.symmetric(vertical: 10),
//                               //         onPressed: () {
//                               //           // Navigator.pushReplacement(
//                               //           //     context,
//                               //           //     MaterialPageRoute(
//                               //           //         builder: (context) =>
//                               //           //             KeranjangPage()));
//                               //           save();
//                               //         },
//                               //         child: Text(
//                               //           "Tambah Keranjang",
//                               //           style: TextStyle(
//                               //             color: Colors.white,
//                               //             fontSize: 16.0,
//                               //             fontFamily: "Poppins Regular",
//                               //           ),
//                               //         ),
//                               //       ),
//                               //     ),
//                               //   ),
//                               // )
//                             ],
//                           ),
//                           // SizedBox(
//                           //   height: 80,
//                           // )
//                         ],
//                       ),
//                     ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 30.0, left: 12.0, right: 12.0),
//                 child: Container(
//                   padding: EdgeInsets.all(15),
//                   height: 120,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         spreadRadius: 0.5,
//                         blurRadius: 3,
//                         offset: Offset(0.5, 0), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2.0, bottom: 5),
//                             child: Text("Bid Now!",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontFamily: "Poppins Bold",
//                                     fontSize: 15)),
//                           ),
//                           // SizedBox(
//                           //   height: 5,
//                           // ),
//                           // Row(
//                           //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //   children: <Widget>[
//                           //     Container(
//                           //       width: 22,
//                           //       height: 22,
//                           //       decoration: BoxDecoration(
//                           //         color: Colors.white,
//                           //         borderRadius: BorderRadius.circular(5),
//                           //         boxShadow: [
//                           //           BoxShadow(
//                           //             color: Colors.grey,
//                           //             spreadRadius: 0.5,
//                           //             blurRadius: 0.5,
//                           //             offset: Offset(
//                           //                 0, 0.5), // changes position of shadow
//                           //           ),
//                           //         ],
//                           //       ),
//                           //       child: IconButton(
//                           //         padding: EdgeInsets.all(0),
//                           //         onPressed: () {
//                           //           // saveMinus(x.id);
//                           //           // setState(() {
//                           //           //   jumlah--;
//                           //           // });
//                           //           setState(() {
//                           //             amount -= 1;
//                           //           });
//                           //         },
//                           //         icon: Icon(Icons.remove,
//                           //             size: 14, color: Colors.black),
//                           //       ),
//                           //     ),
//                           //     // for (var o = 0;
//                           //     //     o < list.length;
//                           //     //     o++)
//                           //     Padding(
//                           //       padding:
//                           //           const EdgeInsets.symmetric(horizontal: 10.0),
//                           //       child: Text(amount.toString()),
//                           //       // child: Text(''),
//                           //     ),
//                           //     Container(
//                           //       width: 22,
//                           //       height: 22,
//                           //       decoration: BoxDecoration(
//                           //         color: Colors.white,
//                           //         borderRadius: BorderRadius.circular(5),
//                           //         boxShadow: [
//                           //           BoxShadow(
//                           //             color: Colors.grey,
//                           //             spreadRadius: 0.5,
//                           //             blurRadius: 0.5,
//                           //             offset: Offset(
//                           //                 0, 0.5), // changes position of shadow
//                           //           ),
//                           //         ],
//                           //       ),
//                           //       child: IconButton(
//                           //         padding: EdgeInsets.all(0),
//                           //         // color: Colors.white,
//                           //         onPressed: () {
//                           //           // saveAdd(x.id);
//                           //           // setState(() {
//                           //           //   jumlah++;
//                           //           // });
//                           //           setState(() {
//                           //             amount += 1;
//                           //           });
//                           //         },
//                           //         icon: Icon(Icons.add,
//                           //             size: 14, color: Colors.black),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           Container(
//                             width: 200,
//                             height: 40,
//                             child: TextFormField(
//                                     // validator: validateEmail,
//                                     // validator: (e) {
//                                     //   if (e!.isEmpty) {
//                                     //     return "Email Can't be Empty";
//                                     //   }
//                                     // },
//                                     // onSaved: (e) => email = e!,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.only(left: 10),
//                                       hintText: 'Enter your bid',
//                                       labelStyle: TextStyle(
//                                         color: Color(0xFFBDC3C7),
//                                         fontSize: 11,
//                                         fontFamily: 'Poppins Regular',
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(
//                                           color: Color(0xFF7F8C8D),
//                                         ),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(color: Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                           ),
//                         ],
//                       ),
//                       FlatButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//                         onPressed: () {
//                           // showDialog(
//                           //   barrierDismissible: false,
//                           //   context: context,
//                           //   builder: (BuildContext context) =>
//                           //       _loadAddress(context),
//                           // );
//                           // orderNow();
//                           // if (list_setting[0].status == 1) {
//                           //   Route route =
//                           //       MaterialPageRoute(builder: (context) => CheckOut());
//                           //   Navigator.pushReplacement(context, route).then(onGoBack);
//                           // } else {}
//                           // save();
//                         },
//                         color: Colors.blue,
//                         // color: Color(0xffe3724b),
//                         child: Text("Place Bid",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontFamily: "Poppins Regular",
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/screens/auction/auction_bid.dart';
import 'package:virtual_exhibition_beta/widgets/placeBid.dart';

class AuctionDetail extends StatefulWidget {
  // final String id;
  // AuctionDetail(this.id);
  @override
  _AuctionDetailState createState() => _AuctionDetailState();
}

class _AuctionDetailState extends State<AuctionDetail> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  var user_id;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id");
    });
  }

  // var loading = false;
  // final list = new List<ProductModel>();
  // Future<void> _allProduct() async {
  //   list.clear();
  //   setState(() {
  //     loading = true;
  //   });
  //   final response =
  //       await http.post(ProductUrl.detailProduct, body: {"id": widget.id});
  //   if (response.contentLength == 2) {
  //     //   await getPref();
  //     // final response =
  //     //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
  //     // await http.post("https://dipena.com/flutter/api/updateProfile.php");
  //     //   "user_id": user_id,
  //     //   "location_country": location_country,
  //     //   "location_city": location_city,
  //     //   "location_user_id": user_id
  //     // });
  //     print('No Data');
  //     // final data = jsonDecode(response.body);
  //     // int value = data['value'];
  //     // String message = data['message'];
  //     // String changeProf = data['changeProf'];
  //   } else {
  //     final data = jsonDecode(response.body);
  //     data.forEach((api) {
  //       final ab = new ProductModel(
  //         api['id'],
  //         api['user_id'],
  //         api['product_name'],
  //         api['product_description'],
  //         api['price'],
  //         api['product_category'],
  //         api['product_sub_category'],
  //         api['stocks'],
  //         api['has_variant'],
  //         api['status'],
  //         api['product_img'],
  //       );
  //       list.add(ab);
  //     });
  //     if (this.mounted) {
  //       setState(() {
  //         loading = false;
  //       });
  //     }
  //   }
  // }

  // var loading_images = false;
  // final list_images = new List<ProductImages>();
  // Future<void> _listImages() async {
  //   list_images.clear();
  //   setState(() {
  //     loading_images = true;
  //   });
  //   final response =
  //       await http.post(ProductUrl.productImages, body: {"id": widget.id});
  //   if (response.contentLength == 2) {
  //     //   await getPref();
  //     // final response =
  //     //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
  //     // await http.post("https://dipena.com/flutter/api/updateProfile.php");
  //     //   "user_id": user_id,
  //     //   "location_country": location_country,
  //     //   "location_city": location_city,
  //     //   "location_user_id": user_id
  //     // });
  //     print('No Data');
  //     // final data = jsonDecode(response.body);
  //     // int value = data['value'];
  //     // String message = data['message'];
  //     // String changeProf = data['changeProf'];
  //   } else {
  //     final data = jsonDecode(response.body);
  //     data.forEach((api) {
  //       final ab = new ProductImages(
  //         api['id'],
  //         api['product_id'],
  //         api['product_img'],
  //       );
  //       list_images.add(ab);
  //     });
  //     if (this.mounted) {
  //       setState(() {
  //         loading_images = false;
  //       });
  //     }
  //   }
  // }

  // save() async {
  //   await getPref();
  //   // showDialog(
  //   //   barrierDismissible: false,
  //   //   context: context,
  //   //   builder: (BuildContext context) => _loading(context),
  //   // );
  //   final response = await http.post(OrderUrl.addCart, body: {
  //     "user_id": user_id,
  //     'quantity': amount.toString(),
  //     "product_id": widget.id,
  //   });

  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   String message = data['message'];
  //   // String messageEnglish = data['messageEnglish'];
  //   if (value == 1) {
  //     // setState(() {
  //     // Navigator.pop(context);
  //     // });
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) => _popUpGallery(context),
  //     // );
  //     // Navigator.pushReplacement(
  //     //   context,
  //     //   new MaterialPageRoute(
  //     //     builder: (context) => Login(),
  //     //   ),
  //     // );
  //     // login();
  //     // print(message);
  //     _showToastSuccess(message);
  //     setState(() {
  //       amount = 1;
  //     });
  //     // registerToast(message);

  //   } else {
  //     // print(message);
  //     // Navigator.pop(context);
  //     _showToast(message);
  //     setState(() {
  //       amount = 1;
  //     });
  //     // registerToast(message);
  //   }
  // }

  _showToast(String toast) {
    final snackbar = SnackBar(
      content: new Text(toast),
      backgroundColor: Colors.red,
    );
    // _scaffoldkey.currentState!.showSnackBar(snackbar);
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  _showToastSuccess(String toast) {
    final snackbar = SnackBar(
      content: new Text(toast),
      backgroundColor: Colors.green,
    );
    // _scaffoldkey.currentState!.showSnackBar(snackbar);
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  // Widget image(BuildContext context, String image) {
  //   // var notedText = TextEditingController();
  //   // notedText.text = pesan;
  //   return Transform.scale(
  //     scale: 1,
  //     child: Opacity(
  //         opacity: 1,
  //         child: Container(
  //             color: Colors.black,
  //             child: Center(
  //                 child: Swiper(
  //               pagination: SwiperPagination(builder: SwiperPagination.dots),
  //               itemCount: list_images.length,
  //               itemBuilder: (context, i) {
  //                 final x = list_images[i];
  //                 return Image.network(ImageUrl.productImage + x.product_img);
  //               },
  //             )))),
  //   );
  // }

  int amount = 1;

  static const countdownDuration = Duration(minutes: 10);

  Duration duration = Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // _allProduct();
    // _listImages();
    startTimer();
    setState(() {
      duration = countdownDuration;
    });
  }

  void addTime() {
    final addSeconds = -1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel;
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    Timer? timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
     final ButtonStyle checkButtonStyle = TextButton.styleFrom(
      backgroundColor: Color(0xFF264C95),
      primary: Color(0xFF264C95),
      // minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return Center(
      child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.white,
          body:
              // SingleChildScrollView(
              // child:
              Stack(
            children: [
              ListView(
                children: [
                  Container(
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
                                //       image(context, x.product_img),
                                // );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/auction/royal_chest.png',
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
                                top: 270,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              // x.product_name,
                                              "Royal Chest",
                                              style: TextStyle(
                                                fontSize: 20,
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
                                          child: Text('Created',
                                              // "100000 Poin",
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
                                                // 'Stock : ' +
                                                //     x.stocks.toString(),
                                                "Ending In",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins Regular",
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Column(
                                        // children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 20),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 5, 10, 0),
                                                child:
                                                    // widget.model.user_img_from == null
                                                    // ?
                                                    CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                    "assets/man.png",
                                                  ),
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  minRadius: 30,
                                                ),
                                                // : CircleAvatar(
                                                //     backgroundImage: NetworkImage(
                                                //         // "assets/img/icon_one.jpg",
                                                //         ImageUrl.imageProfile + widget.model.user_img_from),
                                                //     backgroundColor: Colors.grey[200],
                                                //     minRadius: 30,
                                                //   ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                    // 'Stock : ' +
                                                    //     x.stocks.toString(),
                                                    "Vendor 1",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          "Poppins Regular",
                                                      fontWeight: FontWeight.bold,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // ],
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: buildTime()),
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
                                    SizedBox(height: 30),
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
                                            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                            // x.product_description,
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
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                      const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text("Highest Bid",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins Bold",
                                      fontSize: 15)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Container(
                                //   width: 22,
                                //   height: 22,
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(5),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey,
                                //         spreadRadius: 0.5,
                                //         blurRadius: 0.5,
                                //         offset: Offset(
                                //             0, 0.5), // changes position of shadow
                                //       ),
                                //     ],
                                //   ),
                                //   child: IconButton(
                                //     padding: EdgeInsets.all(0),
                                //     onPressed: () {
                                //       // saveMinus(x.id);
                                //       // setState(() {
                                //       //   jumlah--;
                                //       // });
                                //       setState(() {
                                //         amount -= 1;
                                //       });
                                //     },
                                //     icon: Icon(Icons.remove,
                                //         size: 14, color: Colors.black),
                                //   ),
                                // ),
                                // for (var o = 0;
                                //     o < list.length;
                                //     o++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text("10 SGD"),
                                ),
                                // Container(
                                //   width: 22,
                                //   height: 22,
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(5),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey,
                                //         spreadRadius: 0.5,
                                //         blurRadius: 0.5,
                                //         offset: Offset(
                                //             0, 0.5), // changes position of shadow
                                //       ),
                                //     ],
                                //   ),
                                //   child: IconButton(
                                //     padding: EdgeInsets.all(0),
                                //     // color: Colors.white,
                                //     onPressed: () {
                                //       // saveAdd(x.id);
                                //       // setState(() {
                                //       //   jumlah++;
                                //       // });
                                //       setState(() {
                                //         amount += 1;
                                //       });
                                //     },
                                //     icon: Icon(Icons.add,
                                //         size: 14, color: Colors.black),
                                //   ),
                                // ),
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
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  AuctionBid(),
                            );
                            // orderNow();
                            // if (list_setting[0].status == 1) {
                            //   Route route =
                            //       MaterialPageRoute(builder: (context) => CheckOut());
                            //   Navigator.pushReplacement(context, route).then(onGoBack);
                            // } else {}
                            // save();
                          },
                          // color: Color(0xFF264C95),
                          style: checkButtonStyle,
                          child: Text("Place a Bid",
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
              ),
            ],
          )
          // ),
          ),
    );
  }
}

// class Ukuran extends StatelessWidget {
//   Ukuran({this.ukuran});
//   final String ukuran;
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       flex: 6,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
//         child: OutlineButton(
//           color: Colors.white,
//           padding: EdgeInsets.all(0),
//           onPressed: () {},
//           child: Text(
//             ukuran,
//             style: TextStyle(fontSize: 13),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Warna extends StatelessWidget {
//   Warna({this.warna});
//   final String warna;
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       flex: 6,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
//         child: OutlineButton(
//           color: Colors.white,
//           padding: EdgeInsets.all(0),
//           onPressed: () {},
//           child: Text(
//             warna,
//             style: TextStyle(fontSize: 13),
//           ),
//         ),
//       ),
//     );
//   }
// }
