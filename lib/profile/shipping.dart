import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tucartpoin/in_app/home/detail.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/orders_model.dart';
import 'package:virtual_exhibition_beta/profile/history_detail.dart';
import 'package:virtual_exhibition_beta/profile/timeline.dart';
import 'package:virtual_exhibition_beta/profile/tracking.dart';
// import 'package:tucartpoin/in_app/home/packageSend.dart';
// import 'package:tucartpoin/in_app/profile/historyDetail.dart';
// import 'package:tucartpoin/model/order_model.dart';
// import 'package:tucartpoin/url.dart';

class ShippingItem extends StatefulWidget {
  @override
  _ShippingItemState createState() => _ShippingItemState();
}

class _ShippingItemState extends State<ShippingItem> {
  late String user_id;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id")!;
      // token = preferences.getString("token");
    });
  }

  var loading = false;
  String color = '';
  final list = <OrderProductModel>[];
  Future<void> _allAddress() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http
        .post(Uri.parse(OrderUrl.orderHistory), body: {"user_id": user_id});
    if (response.contentLength == 2) {
      //   await getPref();
      // final response =
      //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
      // await http.post("https://dipena.com/flutter/api/updateProfile.php");
      //   "user_id": user_id,
      //   "location_country": location_country,
      //   "location_city": location_city,
      //   "location_user_id": user_id
      // });
      print('No Data');
      // final data = jsonDecode(response.body);
      // int value = data['value'];
      // String message = data['message'];
      // String changeProf = data['changeProf'];
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new OrderProductModel(
          api['id'],
          api['user_id'],
          api['product_id'],
          api['product_name'],
          api['product_description'],
          api['product_image'],
          api['price'],
          api['category'],
          api['order_list_id'],
          api['quantity'],
          api['status'],
          api['invoice_id'],
          api['address_name'],
          api['created_at'],
          api['updated_at'],
        );
        list.add(ab);
      });
      if (this.mounted) {
        // for (var i = 0; i < list.length; i++) {
        //   if (list[i].status_id == 1) {
        //     setState(() {
        //       color = 'Processing';
        //     });
        //   } else if (list[i].status_id == 4) {
        //     setState(() {
        //       color = 'green';
        //     });
        //   } else {
        //     setState(() {
        //       color = 'red';
        //     });
        //   }
        // }
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _allAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Text("Shipping Items",
            style: TextStyle(
                fontFamily: "Poppins SemiBold",
                fontSize: 16,
                color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: RefreshIndicator(
        onRefresh: _allAddress,
        child: Stack(
          children: [
            list.isEmpty
                ? Center(
                    child: Container(
                      child: Text("You don't have any order"),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          final x = list[i];
                          // return InkWell(
                          //   onTap: () {
                          //     Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 HistoryDetail(x.id.toString())));
                          //   },
                          //   child: SizedBox(
                          //     width: MediaQuery.of(context).size.width,
                          //     height: 110,
                          //     child: Card(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8.0),
                          //       ),
                          //       color: x.status_id == 2
                          //           ? Colors.yellow[400]
                          //           : x.status_id == 3
                          //               ? Color(0xffe3724b)
                          //               : x.status_id == 4
                          //                   ? Colors.blue[400]
                          //                   : x.status_id == 5
                          //                       ? Color(0xff2a9d8f)
                          //                       : x.status_id == 6
                          //                           ? Colors.red
                          //                           : Colors.white,
                          //       elevation: 3,
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: <Widget>[
                          //           Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.start,
                          //             children: <Widget>[
                          //               // Container(
                          //               //   height: double.infinity,
                          //               //   width: MediaQuery.of(context).size.width / 3.5,
                          //               //   decoration: BoxDecoration(
                          //               //     borderRadius: BorderRadius.only(
                          //               //       topLeft: Radius.circular(8),
                          //               //       bottomLeft: Radius.circular(8),
                          //               //     ),
                          //               //     image: DecorationImage(
                          //               //       image: AssetImage(img),
                          //               //       fit: BoxFit.fill,
                          //               //     ),
                          //               //   ),
                          //               // ),
                          //               SizedBox(
                          //                 width: 15,
                          //               ),
                          //               Padding(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     horizontal: 0, vertical: 15),
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: <Widget>[
                          //                     // Text(
                          //                     //   // "Nama Alamat",
                          //                     //   x.address_name,
                          //                     //   style: TextStyle(
                          //                     //     fontSize: 13,
                          //                     //     fontFamily: "Poppins Bold",
                          //                     //   ),
                          //                     // ),
                          //                     // SizedBox(
                          //                     //   height: 5,
                          //                     // ),
                          //                     Container(
                          //                       width: MediaQuery.of(context)
                          //                               .size
                          //                               .width *
                          //                           0.4,
                          //                       child: Text(
                          //                         // "Alamat",
                          //                         "Alamat : " + x.address_name,
                          //                         style: TextStyle(
                          //                           fontSize: 13,
                          //                           fontFamily: "Poppins Bold",
                          //                           color: x.status_id == 2
                          //                               ? Colors.black
                          //                               : x.status_id == 3
                          //                                   ? Colors.white
                          //                                   : x.status_id == 4
                          //                                       ? Colors.black
                          //                                       : x.status_id ==
                          //                                               5
                          //                                           ? Colors
                          //                                               .white
                          //                                           : x.status_id ==
                          //                                                   6
                          //                                               ? Colors
                          //                                                   .white
                          //                                               : Colors
                          //                                                   .black,
                          //                         ),
                          //                         maxLines: 1,
                          //                         softWrap: false,
                          //                         overflow:
                          //                             TextOverflow.ellipsis,
                          //                       ),
                          //                     ),
                          //                     SizedBox(
                          //                       height: 5,
                          //                     ),
                          //                     x.order_note == null
                          //                         ? Text(
                          //                             // "Alamat",
                          //                             "Catatan : -",
                          //                             style: TextStyle(
                          //                               fontSize: 11,
                          //                               fontFamily:
                          //                                   "Poppins Regular",
                          //                               color: x.status_id == 2
                          //                                   ? Colors.black
                          //                                   : x.status_id == 3
                          //                                       ? Colors.white
                          //                                       : x.status_id ==
                          //                                               4
                          //                                           ? Colors
                          //                                               .black
                          //                                           : x.status_id ==
                          //                                                   5
                          //                                               ? Colors
                          //                                                   .white
                          //                                               : x.status_id ==
                          //                                                       6
                          //                                                   ? Colors.white
                          //                                                   : Colors.black,
                          //                             ),
                          //                           )
                          //                         : Text(
                          //                             // "Alamat",
                          //                             "Catatan : " +
                          //                                 x.order_note,
                          //                             style: TextStyle(
                          //                               fontSize: 11,
                          //                               fontFamily:
                          //                                   "Poppins Regular",
                          //                               color: x.status_id == 2
                          //                                   ? Colors.black
                          //                                   : x.status_id == 3
                          //                                       ? Colors.white
                          //                                       : x.status_id ==
                          //                                               4
                          //                                           ? Colors
                          //                                               .black
                          //                                           : x.status_id ==
                          //                                                   5
                          //                                               ? Colors
                          //                                                   .white
                          //                                               : x.status_id ==
                          //                                                       6
                          //                                                   ? Colors.white
                          //                                                   : Colors.black,
                          //                             ),
                          //                           ),
                          //                     SizedBox(
                          //                       height: 15,
                          //                     ),
                          //                     // Text(
                          //                     //   "",
                          //                     //   style: TextStyle(
                          //                     //     fontSize: 11,
                          //                     //     fontFamily: "Poppins SemiBold",
                          //                     //   ),
                          //                     // ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           Align(
                          //             alignment: Alignment.bottomRight,
                          //             child: Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   vertical: 15.0, horizontal: 8.0),
                          //               child: Text(
                          //                 'Dibuat tanggal: ' +
                          //                     x.created_at.substring(0, 10),
                          //                 style: TextStyle(
                          //                   fontSize: 11,
                          //                   fontFamily: "Poppins Regular",
                          //                   color: x.status_id == 2
                          //                       ? Colors.black
                          //                       : x.status_id == 3
                          //                           ? Colors.white
                          //                           : x.status_id == 4
                          //                               ? Colors.black
                          //                               : x.status_id == 5
                          //                                   ? Colors.white
                          //                                   : x.status_id == 6
                          //                                       ? Colors.white
                          //                                       : Colors.black,
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                          return InkWell(
                            onTap: () {
                              // x.status_id == 3
                              //     ? Navigator.pushReplacement(
                              //         context,
                              //         new MaterialPageRoute(
                              //           builder: (context) => PackageSend(
                              //               x.id.toString(),
                              //               x.notif_id.toString(),
                              //               x.product_id.toString(),
                              //               x.order_list_id.toString()),
                              //         ),
                              //       )
                              //     :
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PackageDeliveryTrackingPage(
                                    // x.product_id.toString(),
                                    // x.order_list_id.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color:
                                  // x.read == 1 ?
                                  Colors.white,
                              //  Colors.grey[300],
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 110,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      color:
                                          // x.read == 0
                                          //     ? Colors.grey[300]
                                          // :
                                          Colors.white,
                                      elevation: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: double.infinity,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    AssetsUrl.product +
                                                        x.product_image),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(
                                                    // "nama",
                                                    x.product_name,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily:
                                                          "Poppins Bold",
                                                    ),
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.52,
                                                  child: Text(
                                                    // "harga" + " Poin",
                                                    x.address_name,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily:
                                                          "Poppins Regular",
                                                    ),
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                x.status == 3
                                                    ? Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.52,
                                                        child: Text(
                                                          // "desc",
                                                          // x.created_at
                                                          //     .substring(0, 10),
                                                          "Klik untuk info dan konfirmasi!",
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontFamily:
                                                                  "Poppins Regular",
                                                              color: Colors
                                                                  .blue[900]),
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    : x.status == 5
                                                        ? Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.52,
                                                            child: Text(
                                                              // "desc",
                                                              "Diterima pada : " +
                                                                  x.updated_at
                                                                      .substring(
                                                                          0,
                                                                          10),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontFamily:
                                                                      "Poppins Regular",
                                                                  color: Colors
                                                                          .blue[
                                                                      900]),
                                                              maxLines: 1,
                                                              softWrap: false,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )
                                                        : x.status == 6
                                                            ? Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.52,
                                                                child: Text(
                                                                  // "desc",
                                                                  "Dicancel pada : " +
                                                                      x.updated_at
                                                                          .substring(
                                                                              0,
                                                                              10),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontFamily:
                                                                          "Poppins Regular",
                                                                      color: Colors
                                                                              .blue[
                                                                          900]),
                                                                  maxLines: 1,
                                                                  softWrap:
                                                                      false,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            : Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.52,
                                                                child: Text(
                                                                  // "desc",

                                                                  x.updated_at
                                                                      .substring(
                                                                          0,
                                                                          10),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontFamily:
                                                                          "Poppins Regular",
                                                                      color: Colors
                                                                              .blue[
                                                                          900]),
                                                                  maxLines: 1,
                                                                  softWrap:
                                                                      false,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // x.type_id == 2
                                  //     ? Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.center,
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 top: 4.0, left: 10.0),
                                  //             child: Container(
                                  //               alignment: Alignment.center,
                                  //               child: FlatButton(
                                  //                 shape: RoundedRectangleBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(5),
                                  //                 ),
                                  //                 padding: EdgeInsets.symmetric(
                                  //                     vertical: 2,
                                  //                     horizontal: 25),
                                  //                 onPressed: () {
                                  //                   Navigator.pop(context);
                                  //                 },
                                  //                 color: Color(0xff2a9d8f),
                                  //                 child: Text(
                                  //                     "Konfirmasi barang telah diterima.",
                                  //                     style: TextStyle(
                                  //                       color: Colors.white,
                                  //                       fontSize: 17,
                                  //                       fontFamily:
                                  //                           "Poppins Regular",
                                  //                     )),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     : Container()
                                ],
                              ),
                            ),
                          );
                        }
                        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),

                        ),
                  ),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     padding: EdgeInsets.all(15),
            //     height: 70,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey,
            //           spreadRadius: 0.5,
            //           blurRadius: 3,
            //           offset: Offset(0.5, 0), // changes position of shadow
            //         ),
            //       ],
            //     ),
            //     child: Align(
            //       alignment: Alignment.center,
            //       child: FlatButton(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(3),
            //         ),
            //         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            //         onPressed: () {},
            //         color: Color(0xffe3724b),
            //         child: Text("Tambah Alamat",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 14,
            //               fontFamily: "Poppins Regular",
            //             )),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // ListView(
      //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      //   children: <Widget>[
      //     HistoryView(
      //       img: 'assets/images/kemeja-tie-die.jpg',
      //       nama: "Kemeja Tie Die",
      //       harga: '25000',
      //       status: "Paket telah diterima",
      //       tanggal: '07/06/2021',
      //     ),
      //     HistoryView(
      //       img: 'assets/images/celana-pendek.jpg',
      //       nama: "Celana Pendek Pria",
      //       harga: '20000',
      //       status: "Paket telah diterima",
      //       tanggal: '04/11/2021',
      //     ),
      //   ],
      // ),
    );
  }
}

// class HistoryView extends StatelessWidget {
//   HistoryView({this.img, this.nama, this.harga, this.status, this.tanggal});
//   final String img;
//   final String nama;
//   final String harga;
//   final String status;
//   final String tanggal;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       // onTap: () {
//       //   Navigator.pushReplacement(
//       //       context, MaterialPageRoute(builder: (context) => Details()));
//       // },
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: 110,
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           color: Colors.white,
//           elevation: 3,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     height: double.infinity,
//                     width: MediaQuery.of(context).size.width / 3.5,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         bottomLeft: Radius.circular(8),
//                       ),
//                       image: DecorationImage(
//                         image: AssetImage(img),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           nama,
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontFamily: "Poppins Bold",
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           harga + " Poin",
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontFamily: "Poppins Regular",
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           status,
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontFamily: "Poppins SemiBold",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 15.0, horizontal: 8.0),
//                   child: Text(
//                     tanggal,
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontFamily: "Poppins Regular",
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
