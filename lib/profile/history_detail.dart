import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/orders_model.dart';
import 'package:virtual_exhibition_beta/model/product_model.dart';

class HistoryDetail extends StatefulWidget {
  final String id, order_list_id;
  HistoryDetail(this.id, this.order_list_id);
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
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

  var loading = false;
  final list = <Product>[];
  Future<void> _allProduct() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http
        .post(Uri.parse(BoothUrl.productDetail), body: {"id": widget.id});
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
        final ab = new Product(
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
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  var loadingg = false;
  final listt = <OrderModelDetail>[];
  Future<void> _orderDetail() async {
    await getPref();
    listt.clear();
    setState(() {
      loadingg = true;
    });
    final response = await http.post(Uri.parse(OrderUrl.orderHistoryDetail),
        body: {"product_id": widget.id, "order_list_id": widget.order_list_id});
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
        final ab = new OrderModelDetail(
          api['id'],
          api['user_id'],
          api['product_id'],
          api['product_name'],
          api['product_image'],
          api['product_description'],
          api['price'],
          api['quantity'],
          api['status'],
          api['total_price'],
          api['invoice_id'],
          api['created_at'],
          api['updated_at'],
        );
        listt.add(ab);
      });
      if (this.mounted) {
        setState(() {
          loadingg = false;
          print(data);
        });
      }
    }
  }

  var loading_images = false;
  final list_images = <ProductImages>[];
  Future<void> _listImages() async {
    list_images.clear();
    setState(() {
      loading_images = true;
    });
    final response = await http
        .post(Uri.parse(BoothUrl.productDetail), body: {"id": widget.id});
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
        final ab = new ProductImages(
          api['id'],
          api['product_image'],
        );
        list_images.add(ab);
      });
      if (this.mounted) {
        setState(() {
          loading_images = false;
        });
      }
    }
  }

  Widget image(BuildContext context, String image) {
    // var notedText = TextEditingController();
    // notedText.text = pesan;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(153, 0, 0, 0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Transform.scale(
        scale: 1,
        child: Opacity(
            opacity: 1,
            child: Container(
                color: Colors.black,
                child: Center(
                    child: Swiper(
                  pagination: SwiperPagination(builder: SwiperPagination.dots),
                  itemCount: list_images.length,
                  itemBuilder: (context, i) {
                    final x = list_images[i];
                    return Image.network(AssetsUrl.product + x.product_image);
                  },
                )))),
      ),
    );
  }

  // save() async {
  //   await getPref();
  //   // showDialog(
  //   //   barrierDismissible: false,
  //   //   context: context,
  //   //   builder: (BuildContext context) => _loading(context),
  //   // );
  //   final response = await http.post(OrderUrl.addCart, body: {
  //     "user_id": user_id,
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
  //     // registerToast(message);

  //   } else {
  //     // print(message);
  //     // Navigator.pop(context);
  //     _showToast(message);
  //     // registerToast(message);
  //   }
  // }

  // packageComplete(String order_id) async {
  //   // showDialog(
  //   //   barrierDismissible: false,
  //   //   context: context,
  //   //   builder: (BuildContext context) => _loading(context),
  //   // );
  //   final response = await http.post(ProfileUrl.packageComplete, body: {
  //     "id": order_id,
  //     "notif_id": widget.notif_id,
  //   });

  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   String message = data['message'];
  //   // String messageEnglish = data['messageEnglish'];
  //   if (value == 1) {
  //     // setState(() {
  //     int count = 0;
  //     Navigator.of(context).popUntil((_) => count++ >= 3);
  //   } else {}
  // }

  save(int id, int status) async {
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response =
        await http.post(Uri.parse(VendorUrl.change_orderStatus), body: {
      "id": id.toString(),
      'status': status.toString(),
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    // String messageEnglish = data['messageEnglish'];
    if (value == 1) {
      _showToastSuccess(message);
      _refresh.currentState!.show();
      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      _refresh.currentState!.show();
      _showToast(message);
      // registerToast(message);
    }
  }

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

  @override
  void initState() {
    super.initState();
    // _allProduct();
    _orderDetail();
    _listImages();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Color(0xffe3724b),
      primary: Color(0xffe3724b),
      // minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(vertical: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.white,
          body:
              // SingleChildScrollView(
              // child:
              ListView.builder(
                  itemCount: listt.length,
                  itemBuilder: (context, i) {
                    final x = listt[i];
                    // final n = listt[i];
                    return RefreshIndicator(
                      key: _refresh,
                      onRefresh: _orderDetail,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      image(context, x.product_image),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 2.5,
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
                                      vertical: 50, horizontal: 30),
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
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              decoration: BoxDecoration(color: Colors.white),
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
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.4,
                                          child: Text(
                                            x.product_name,
                                            // "Celana Jogger",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: "Poppins SemiBold",
                                            ),
                                            maxLines: 2,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(x.price.toString() + ' SGD/Item',
                                                // "100000 Poin",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins Regular",
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // for (var i = 0; i < listt.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          'Quantity : ' + x.quantity.toString(),
                                          // "100000 Poin",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Poppins Regular",
                                          )),
                                    ),
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
                                  // x.status >= 3
                                  //     ? Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //             horizontal: 20.0),
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: <Widget>[
                                  //             Text(
                                  //               "Vendor",
                                  //               style: TextStyle(
                                  //                 color: Colors.black,
                                  //                 fontSize: 15,
                                  //                 fontFamily: "Poppins Medium",
                                  //               ),
                                  //             ),
                                  //             SizedBox(height: 10),
                                  //             Text(
                                  //               // "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                  //               x.vendor ?? "",
                                  //               style: TextStyle(
                                  //                 color: Colors.black,
                                  //                 fontSize: 13,
                                  //                 fontFamily: "Poppins Regular",
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       )
                                  //     : Container(),
                                  x.status >= 3
                                      ? SizedBox(height: 20)
                                      : Container(),
                                  x.status >= 3
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Invoice",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "Poppins Medium",
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                // "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                                x.invoice_id,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: "Poppins Regular",
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
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
                                  SizedBox(height: 20),
                                  // for (var i = 0; i < listt.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        x.status == 1
                                            ? Text(
                                                "Order Status : Waiting to be process",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "Poppins Medium",
                                                ),
                                              )
                                            : x.status == 2
                                                ? Text(
                                                    "Order Status : Item has been processed",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily:
                                                          "Poppins Medium",
                                                    ),
                                                  )
                                                : x.status == 3
                                                    ? Text(
                                                        "Order Status : In shipping",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "Poppins Medium",
                                                        ),
                                                      )
                                                    : x.status == 4
                                                        ? Text(
                                                            "Order Status : Item arrived",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Poppins Medium",
                                                            ),
                                                          )
                                                        : x.status == 5
                                                            ? Text(
                                                                "Order Status : Item has been received",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Poppins Medium",
                                                                ),
                                                              )
                                                            : Text(
                                                                "Order Status : Order canceled",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Poppins Medium",
                                                                ),
                                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // for (var i = 0; i < listt.length; i++)
                            x.status > 2 && x.status < 5
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, bottom: 45.0),
                                    child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 60),
                                        child: ElevatedButton(
                                          // color: Color(0xffe3724b),
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius:
                                          //       BorderRadius.circular(5),
                                          // ),
                                          // padding:
                                          //     EdgeInsets.symmetric(vertical: 10),
                                          style: raisedButtonStyle,
                                          onPressed: () {
                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             KeranjangPage()));
                                            // save();
                                            // for (var i = 0; i < listt.length; i++)
                                            //   packageComplete(
                                            //       x.id.toString());
                                            save(x.id, 5);
                                          },
                                          child: Text(
                                            "Product Received Confirmation",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontFamily: "Poppins Regular",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    );
                  })
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
