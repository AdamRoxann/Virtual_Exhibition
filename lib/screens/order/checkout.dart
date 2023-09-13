import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tucartpoin/in_app/profile/tracking.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/address_model.dart';
import 'package:virtual_exhibition_beta/model/product_model.dart';
import 'package:virtual_exhibition_beta/profile/address.dart';
import 'package:virtual_exhibition_beta/screens/order/orderPlaced.dart';
import 'package:virtual_exhibition_beta/screens/order/stripe_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _orderRefresh =
      GlobalKey<RefreshIndicatorState>();
  final key = new GlobalKey<FormState>();
  final keyCat = new GlobalKey<FormState>();

  var user_id, token, order_note;

  check() {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      orderNow();
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id");
      token = preferences.getString("token");
    });
  }

  orderNow() async {
    await getPref();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => _loadingOrder(context),
    );
    final response = await http.post(Uri.parse(OrderUrl.checkout), body: {
      "user_id": user_id,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    int order_id = data['order_id'];
    // String messageEnglish = data['messageEnglish'];
    if (value == 1) {
      // setState(() {
      // Navigator.pop(context);
      // });
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) => _popUpGallery(context),
      // );
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => OrderPlaced(
              totalPrices[0].total_price.toString(), order_id.toString()),
        ),
      );
      // login();
      // print(message);
      // Navigator.pop(context);
      // showDialog(
      //   barrierDismissible: false,
      //   context: context,
      //   builder: (BuildContext context) => _loadingOrderSuccess(context),
      // );
      // Navigator.pop(context);
      // _showToastSuccess(message);

      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      Navigator.pop(context);
      _showToast(message);
      // registerToast(message);
    }
  }

  Widget _loadingOrder(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
          title: Text("Creating Your Order.."),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              // height: 50,
              // width: 50,
              child: SizedBox(
                  // height: 50,
                  // width: 50,
                  child: Center(child: CircularProgressIndicator())),
            ),
          ),
        ),
      ),
    );
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

  Widget _loadingOrderSuccess(BuildContext context) {
    return new Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
          title: Text("Order Sukses!"),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              // height: 50,
              // width: 50,
              child: SizedBox(
                  // height: 50,
                  // width: 50,
                  child: Center(child: Icon(Icons.check, color: Colors.green))),
            ),
          ),
        ),
      ),
    );
  }

  var loading = false;
  final list = <AddressModel>[];
  Future<void> _activeAddress() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.post(Uri.parse(UserUrl.activeAddress),
        body: {"user_id": user_id.toString()});
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
      print('No Data aaa');
      // final data = jsonDecode(response.body);
      // int value = data['value'];
      // String message = data['message'];
      // String changeProf = data['changeProf'];
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new AddressModel(
          api['id'],
          api['user_id'],
          api['address_name'],
          api['address'],
          api['status'],
          api['created_at'],
        );
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
  // ignore: deprecated_member_use
  final listt = <Product>[];
  Future<void> _myCart() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.post(Uri.parse(OrderUrl.myCart), body: {
      "user_id": user_id.toString(),
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
        listt.add(ab);
      });
      setState(() {
        loading = false;
        print(data);
      });
    }
  }

  // var loading_order = false;
  // final list_order = new List<OrderModel>();
  // Future<void> _order() async {
  //   await getPref();
  //   list_order.clear();
  //   setState(() {
  //     loading_order = true;
  //   });
  //   final response =
  //       await http.post(OrderUrl.cartNote, body: {"user_id": user_id});
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
  //       final ab = new OrderModel(
  //         api['id'],
  //         api['order_list_id'],
  //         api['user_id'],
  //         api['product_id'],
  //         api['quantity'],
  //         api['status_id'],
  //         api['order_note'],
  //         api['created_at'],
  //       );
  //       list_order.add(ab);
  //     });
  //     if (this.mounted) {
  //       setState(() {
  //         loading_order = false;
  //       });
  //     }
  //   }
  // }

  var loading_quantity = false;
  final list_quantity = <QuantityModel>[];
  Future<void> _quantity() async {
    await getPref();
    list_quantity.clear();
    setState(() {
      loading_quantity = true;
    });
    final response = await http.post(Uri.parse(OrderUrl.quantity), body: {
      "user_id": user_id.toString(),
    });
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

      // final data = jsonDecode(response.body);
      // int value = data['value'];
      // String message = data['message'];
      // String changeProf = data['changeProf'];
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new QuantityModel(
          api['id'],
          api['user_id'],
          api['product_id'],
          api['quantity'],
        );
        list_quantity.add(ab);
      });
      if (this.mounted) {
        setState(() {
          loading_quantity = false;
        });
      }
    }
  }

  var loading_total_price = false;
  final totalPrices = <TotalPrice>[];
  Future<void> _totalPrice() async {
    await getPref();
    totalPrices.clear();
    setState(() {
      loading_total_price = true;
    });
    final response = await http.post(Uri.parse(OrderUrl.totalPrice), body: {
      "user_id": user_id.toString(),
    });
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

      // final data = jsonDecode(response.body);
      // int value = data['value'];
      // String message = data['message'];
      // String changeProf = data['changeProf'];
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new TotalPrice(
          api['total_price'],
        );
        totalPrices.add(ab);
      });
      if (this.mounted) {
        setState(() {
          loading_total_price = false;
        });
      }
    }
  }

  Future<void> _refreshAll() async {
    _activeAddress();
  }

  @override
  void initState() {
    super.initState();
    _activeAddress();
    _myCart();
    _quantity();
    _totalPrice();
    // _order();
  }

  Future onGoBack(dynamic value) async {
    _activeAddress();
  }

  // addNote() async {
  //   final response = await http.post(OrderUrl.addNote, body: {
  //     "id": idNote,
  //     "order_note": noteOrder
  //     // "product_id": item.toString(),
  //   });

  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   String message = data['message'];
  //   // String messageEnglish = data['messageEnglish'];
  //   if (value == 1) {
  //     // setState(() {
  //     Navigator.pop(context);
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
  //     _orderRefresh.currentState.show();
  //     // _totalHarga.currentState.show();
  //     // _quantity_refresh.currentState.show();
  //     // registerToast(message);

  //   } else {
  //     // print(message);
  //     // Navigator.pop(context);
  //     _showToast('Delete item from cart failed');
  //     // registerToast(message);
  //   }
  // }

  // String idNote, noteOrder;

  // checkNote() {
  //   final form = keyCat.currentState;
  //   if (form.validate()) {
  //     form.save();
  //     addNote();
  //   }
  // }

  // Widget note(BuildContext context, String pesan, String idOrder) {
  //   var notedText = TextEditingController();
  //   notedText.text = pesan;
  //   return Form(
  //     key: keyCat,
  //     child: new Transform.scale(
  //       scale: 1,
  //       child: Opacity(
  //         opacity: 1,
  //         // child: CupertinoAlertDialog(
  //         //   title: Text("Order Sukses!"),
  //         //   content: Padding(
  //         //     padding: const EdgeInsets.only(top: 8.0),
  //         //     child: Container(
  //         //       // height: 50,
  //         //       // width: 50,
  //         //       child: SizedBox(
  //         //           // height: 50,
  //         //           // width: 50,
  //         //           child: Center(child: Icon(Icons.check, color: Colors.green))),
  //         //     ),
  //         //   ),
  //         // ),
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 12.0),
  //           child: Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15.0),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(25.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Column(
  //                     children: [
  //                       // Container(
  //                       //   child:
  //                       Padding(
  //                         padding:
  //                             const EdgeInsets.only(top: 8.0, bottom: 20.0),
  //                         child: Text(
  //                           "Tambah catatan untuk pesanan",
  //                           style: TextStyle(
  //                               fontFamily: "Poppins Bold", fontSize: 20.0),
  //                         ),
  //                       ),
  //                       Divider(
  //                         height: 2,
  //                         color: Colors.black,
  //                         thickness: 0.5,
  //                       ),
  //                       TextFormField(
  //                         onSaved: (e) => noteOrder = e,
  //                         controller: notedText,
  //                         keyboardType: TextInputType.multiline,
  //                         maxLines: null,
  //                         decoration: InputDecoration(
  //                             // labelText: 'Contoh: Sambalnya dipisah ya!',
  //                             labelStyle: TextStyle(
  //                               color: Color(0xFFBDC3C7),
  //                               fontSize: 15,
  //                               fontFamily: 'Poppins Regular',
  //                             ),
  //                             border: InputBorder.none,
  //                             focusedBorder: InputBorder.none,
  //                             enabledBorder: InputBorder.none,
  //                             errorBorder: InputBorder.none,
  //                             disabledBorder: InputBorder.none,
  //                             hintText: "Contoh: Sambalnya dipisah ya!"
  //                             // enabledBorder: OutlineInputBorder(
  //                             //   borderRadius: BorderRadius.circular(10),
  //                             //   borderSide: BorderSide(
  //                             //     color: Color(0xFF7F8C8D),
  //                             //   ),
  //                             // ),
  //                             // focusedBorder: OutlineInputBorder(
  //                             //   borderRadius: BorderRadius.circular(10),
  //                             //   borderSide: BorderSide(color: Colors.black),
  //                             // ),
  //                             ),
  //                       ),
  //                       // ),
  //                     ],
  //                   ),
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(right: 8.0),
  //                         child: Container(
  //                           alignment: Alignment.bottomCenter,
  //                           child: FlatButton(
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(3),
  //                             ),
  //                             padding: EdgeInsets.symmetric(
  //                                 vertical: 0, horizontal: 25),
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                               // if (totalPrices.isEmpty) {
  //                               //   _showToast("Keranjang Kosong");
  //                               // } else {
  //                               //   check();
  //                               // }
  //                               // orderNow();
  //                               // Navigator.pushReplacement(
  //                               //   context,
  //                               //   new MaterialPageRoute(
  //                               //     builder: (context) =>
  //                               //         OrderPlaced(totalPrices[0].total_price.toString()),
  //                               //   ),
  //                               // );
  //                             },
  //                             color: Colors.grey[400],
  //                             child: Text("Cancel",
  //                                 style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontSize: 17,
  //                                   fontFamily: "Poppins Regular",
  //                                 )),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         alignment: Alignment.bottomCenter,
  //                         child: FlatButton(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(3),
  //                           ),
  //                           padding: EdgeInsets.symmetric(
  //                               vertical: 0, horizontal: 25),
  //                           onPressed: () {
  //                             // if (totalPrices.isEmpty) {
  //                             //   _showToast("Keranjang Kosong");
  //                             // } else {
  //                             //   check();
  //                             // }
  //                             // orderNow();
  //                             // Navigator.pushReplacement(
  //                             //   context,
  //                             //   new MaterialPageRoute(
  //                             //     builder: (context) =>
  //                             //         OrderPlaced(totalPrices[0].total_price.toString()),
  //                             //   ),
  //                             // );
  //                             setState(() {
  //                               idNote = idOrder;
  //                             });
  //                             checkNote();
  //                           },
  //                           color: Color(0xffe3724b),
  //                           child: Text("Simpan",
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 17,
  //                                 fontFamily: "Poppins Regular",
  //                               )),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget webView() {
  //   return WebView(
  //     initialUrl: "https://belajarflutter.com/",
  //     javascriptMode: JavascriptMode.unrestricted,
  //   );
  // }

  final Uri _url = Uri.parse('https://buy.stripe.com/test_eVa4gF2MR8ZneI06p1');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

// void _loadFromUrl(String url) async {
//   http.Response response = await http.get(url);
//   if (response.statusCode == 200) {print('success');}
//   else {print('failed');}

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
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          title: Text("Tambahkan Detail",
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
        body: Form(
          key: key,
          child: Stack(
            children: [
              Container(),
              ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  list.isEmpty
                      ? InkWell(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => AddressPage());
                            Navigator.push(context, route).then(onGoBack);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, top: 2.0, bottom: 5.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Delivery Address",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "Poppins Bold"),
                                          )),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 120,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        color: Colors.grey.shade300,
                                        elevation: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                // Container(
                                                //   height: double.infinity,
                                                //   width: MediaQuery.of(context).size.width / 3.5,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.only(
                                                //       topLeft: Radius.circular(8),
                                                //       bottomLeft: Radius.circular(8),
                                                //     ),
                                                //     image: DecorationImage(
                                                //       image: AssetImage(img),
                                                //       fit: BoxFit.fill,
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: Text(
                                                          // "Alamat",
                                                          "Choose Address",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                "Poppins Bold",
                                                          ),
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                        // "Nama Alamat",
                                                        "Not yet have address",
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontFamily:
                                                              "Poppins Regular",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 8.0),
                                                  child: Icon(
                                                      Icons.arrow_right_alt)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => AddressPage());
                            Navigator.push(context, route).then(onGoBack);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, top: 2.0, bottom: 5.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Delivery Address",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "Poppins Bold"),
                                          )),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 120,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        color: Colors.grey.shade300,
                                        elevation: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                // Container(
                                                //   height: double.infinity,
                                                //   width: MediaQuery.of(context).size.width / 3.5,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.only(
                                                //       topLeft: Radius.circular(8),
                                                //       bottomLeft: Radius.circular(8),
                                                //     ),
                                                //     image: DecorationImage(
                                                //       image: AssetImage(img),
                                                //       fit: BoxFit.fill,
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: Text(
                                                          // "Alamat",
                                                          "Choose Address",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                "Poppins Bold",
                                                          ),
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      for (var i = 0;
                                                          i < list.length;
                                                          i++)
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Text(
                                                            // "Nama Alamat",
                                                            list[i].address,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontFamily:
                                                                  "Poppins Regular",
                                                            ),
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 8.0),
                                                  child: Icon(
                                                      Icons.arrow_right_alt)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: TextFormField(
                  //     onSaved: (e) => order_note = e,
                  //     keyboardType: TextInputType.multiline,
                  //     maxLines: null,
                  //     // onSaved: (e) => email = e,
                  //     decoration: InputDecoration(
                  //       labelText: 'Order Note',
                  //       labelStyle: TextStyle(
                  //         color: Color(0xFFBDC3C7),
                  //         fontSize: 15,
                  //         fontFamily: 'Poppins Regular',
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide(
                  //           color: Color(0xFF7F8C8D),
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide(color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listt.length,
                      itemBuilder: (context, i) {
                        final x = listt[i];
                        // final y = list_order[i];
                        // final z = list_quantity[i];
                        return ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 13, right: 13, top: 2, bottom: 2),
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 110,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             Details(
                                              //                 x.id.toString())));
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      AssetsUrl.product +
                                                          x.product_image),
                                                  fit: BoxFit.fill,
                                                ),
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
                                                InkWell(
                                                  onTap: () {
                                                    // Navigator.pushReplacement(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             Details(x.id
                                                    //                 .toString())));
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: Text(
                                                      // "nama",
                                                      x.product_name,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "Poppins Bold",
                                                      ),
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  x.price.toString() + " SGD",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily:
                                                        "Poppins Regular",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child:
                                            // IconButton(
                                            //   padding: EdgeInsets.all(0),
                                            //   // color: Colors.white,
                                            //   onPressed: () {
                                            //     // deleteItemCart(x.id);
                                            //   },
                                            //   icon: Icon(Icons.delete_outline,
                                            //       size: 25, color: Color(0xffe3724b)),
                                            // ),
                                            Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 40.0),
                                          child:
                                              // list_quantity
                                              //         .isEmpty
                                              //     ? Text(
                                              //         // "1",
                                              //         '0',
                                              //         // '$jumlah',
                                              //         style:
                                              //             TextStyle(
                                              //           fontSize:
                                              //               12,
                                              //           fontFamily:
                                              //               "Poppins Regular",
                                              //         ),
                                              //       )
                                              //     : Text(
                                              //         // "1",
                                              //         z.quantity
                                              //                 .toString() ??
                                              //             '0',
                                              //         // list_quantity.length >
                                              //         //         0
                                              //         //     ? list_quantity[0]
                                              //         //         .quantity
                                              //         //         .toString()
                                              //         //     : '',
                                              //         // '$jumlah',
                                              //         style:
                                              //             TextStyle(
                                              //           fontSize:
                                              //               12,
                                              //           fontFamily:
                                              //               "Poppins Regular",
                                              //         ),
                                              //       ),
                                              list_quantity.isEmpty
                                                  ? Text('')
                                                  : Text(
                                                      list_quantity[i]
                                                          .quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "Poppins Bold",
                                                      ),
                                                    ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // KeranjangView(
                            //   img: 'assets/images/sepatu2.jpg',
                            //   nama: "Sepatu Kekinian",
                            //   harga: '100000',
                            //   // desc: "Lorem ipsum dolor sit amet, con...",
                            // ),
                            // KeranjangView(
                            //   img: 'assets/images/celana-jogger.jpg',
                            //   nama: "Celana Aliando",
                            //   harga: '65000',
                            //   // desc: "Lorem ipsum dolor sit amet, con...",
                            // ),
                            // KeranjangView(
                            //   img: 'assets/images/topi.jpg',
                            //   nama: "Topi Korea Viral",
                            //   harga: '28000',
                            //   // desc: "Lorem ipsum dolor sit amet, con...",
                            // ),
                            // KeranjangView(
                            //   img: 'assets/images/kemeja-polos.jpg',
                            //   nama: "Kemeja Polos",
                            //   harga: '15000',
                            //   // desc: "Lorem ipsum dolor sit amet, con...",
                            // ),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, left: 16.0, top: 8.0),
                          child: const Text(
                            'Total Order',
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Poppins Bold"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, bottom: 16.0, top: 15.0),
                          child: totalPrices.isEmpty
                              ? Text("0 SGD",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: "Poppins Regular",
                                  ))
                              : Text(
                                  totalPrices[0].total_price.toString() +
                                      " SGD",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: "Poppins Regular",
                                  )),
                          // child: Text(
                          //   '1000'+" Poin",
                          //   style: TextStyle(
                          //       fontSize: 16.0,
                          //       color: Colors.black.withOpacity(1)),
                          // ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 70,
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
                  child: TextButton(
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(3),
                    // ),
                    // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    onPressed: () {
                      if (list.isEmpty) {
                        _showToast("Address empty");
                      } else if (totalPrices.isEmpty) {
                        _showToast("Cart Empty");
                      } else {
                        // _launchUrl();
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: StripeScreen(
                                  user_id: user_id,
                                )));
                        // check();
                      }
                      // orderNow();
                      // Navigator.pushReplacement(
                      //   context,
                      //   new MaterialPageRoute(
                      //     builder: (context) =>
                      //         OrderPlaced(totalPrices[0].total_price.toString()),
                      //   ),
                      // );
                    },
                    // color: Color(0xFF264C95),
                    style: checkButtonStyle,
                    child: Text("Place Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Poppins Regular",
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
