import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/product_model.dart';
import 'package:virtual_exhibition_beta/screens/order/checkout.dart';
import 'package:virtual_exhibition_beta/screens/product/product_detail.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _quantity_refresh =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _totalHarga =
      GlobalKey<RefreshIndicatorState>();

  var user_id;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        user_id = preferences.getString("id");
      });
    }
  }

  var loading = false;
  // ignore: deprecated_member_use
  final list = <Product>[];
  Future<void> _myCart() async {
    await getPref();
    list.clear();
    if (this.mounted) {
      setState(() {
        loading = true;
      });
    }

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
        list.add(ab);
      });
      setState(() {
        loading = false;
        print(data);
      });
    }
  }

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

  saveMinus(var item) async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(Uri.parse(OrderUrl.minusCart), body: {
      "user_id": user_id,
      "product_id": item.toString(),
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
      // _showToastSuccess(message);
      // _refresh.currentState!.show();
      _quantity_refresh.currentState!.show();
      _totalHarga.currentState!.show();
      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast('Descrease from cart failed');
      // registerToast(message);
    }
  }

  // var loading_setting = false;
  // final list_setting = new List<OrderSettings>();
  // Future<void> _orderSettings() async {
  //   await getPref();
  //   list_setting.clear();
  //   setState(() {
  //     loading_setting = true;
  //   });
  //   final response = await http.get(OrderUrl.orderSettings);
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
  //       final ab = new OrderSettings(
  //         api['id'],
  //         api['settings_name'],
  //         api['status'],
  //         api['created_at'],
  //       );
  //       list_setting.add(ab);
  //     });
  //     if (this.mounted) {
  //       setState(() {
  //         loading_setting = false;
  //       });
  //     }
  //   }
  // }

  saveAdd(var item) async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(Uri.parse(OrderUrl.addCart), body: {
      "user_id": user_id,
      "product_id": item.toString(),
      "quantity": "1",
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
      // _showToastSuccess(message);
      _quantity_refresh.currentState!.show();
      _totalHarga.currentState!.show();
      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast(message);
      // registerToast(message);
    }
  }

  deleteItemCart(var item) async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(Uri.parse(OrderUrl.deleteItemCart), body: {
      "user_id": user_id,
      "product_id": item.toString(),
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
      // _showToastSuccess(message);
      _refresh.currentState!.show();
      _totalHarga.currentState!.show();
      // _quantity_refresh.currentState.show();
      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast('Delete item from cart failed');
      // registerToast(message);
    }
  }

  deleteCart() async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(Uri.parse(OrderUrl.deleteCart), body: {
      "user_id": user_id,
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
      _refresh.currentState!.show();
      _totalHarga.currentState!.show();
      // _quantity_refresh.currentState.show();
      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast('Delete All items from cart failed');
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

  Future<void> _refreshAll() async {
    _myCart();
    _quantity();
    _totalPrice();
  }

  Future onGoBack(dynamic value) async {
    _myCart();
    _quantity();
    _totalPrice();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myCart();
    _quantity();
    _totalPrice();
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 4,
            title: Text("My Cart",
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
          body: Stack(children: <Widget>[
            list.isEmpty && list_quantity.isEmpty
                ? Center(
                    child: Container(
                    child: Text("You haven't ordered anything"),
                  ))
                : RefreshIndicator(
                    onRefresh: _refreshAll,
                    child: ListView(
                      children: [
                        RefreshIndicator(
                            child: Container(),
                            onRefresh: _quantity,
                            key: _quantity_refresh),
                        RefreshIndicator(
                            child: Container(),
                            onRefresh: _myCart,
                            key: _refresh),
                        RefreshIndicator(
                            child: Container(),
                            onRefresh: _totalPrice,
                            key: _totalHarga),
                        Container(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              deleteCart();
                            },
                            child: Text(
                              "Delete All",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Poppins SemiBold",
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, i) {
                              final x = list[i];
                              // final z = list_quantity[i];
                              return ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 4, bottom: 4),
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {},
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 110,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                                    //             Details(x.id
                                                    //                 .toString())));
                                                  },
                                                  child: Container(
                                                    height: double.infinity,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                      ),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            AssetsUrl.product +
                                                                x.product_image),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ProductDetail(
                                                                          x.product_assets,
                                                                          x.id)));
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
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
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        x.price.toString() +
                                                            " SGD",
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontFamily:
                                                              "Poppins Regular",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 22,
                                                            height: 22,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  spreadRadius:
                                                                      0.5,
                                                                  blurRadius:
                                                                      0.5,
                                                                  offset: Offset(
                                                                      0,
                                                                      0.5), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              onPressed: () {
                                                                saveMinus(x.id);
                                                                // setState(() {
                                                                //   jumlah--;
                                                                // });
                                                              },
                                                              icon: Icon(
                                                                  Icons.remove,
                                                                  size: 14,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          // for (var o = 0;
                                                          //     o < list.length;
                                                          //     o++)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10.0),
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
                                                                list_quantity
                                                                        .isEmpty
                                                                    ? Text('')
                                                                    : Text(list_quantity[
                                                                            i]
                                                                        .quantity
                                                                        .toString()),
                                                          ),
                                                          Container(
                                                            width: 22,
                                                            height: 22,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  spreadRadius:
                                                                      0.5,
                                                                  blurRadius:
                                                                      0.5,
                                                                  offset: Offset(
                                                                      0,
                                                                      0.5), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              // color: Colors.white,
                                                              onPressed: () {
                                                                saveAdd(x.id);
                                                                // setState(() {
                                                                //   jumlah++;
                                                                // });
                                                              },
                                                              icon: Icon(
                                                                  Icons.add,
                                                                  size: 14,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                // color: Colors.white,
                                                onPressed: () {
                                                  deleteItemCart(x.id);
                                                },
                                                icon: Icon(Icons.delete_outline,
                                                    size: 25,
                                                    color: Color(0xffe3724b)),
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
                        SizedBox(
                          height: 100,
                        ),
                        // ],
                        //   ),
                        // ),
                      ],
                    ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Total Order",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins Bold",
                                fontSize: 11)),
                        SizedBox(
                          height: 3,
                        ),
                        totalPrices.isEmpty
                            ? Text("0 SGD",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: "Poppins Regular",
                                ))
                            : Text(
                                totalPrices[0].total_price.toString() + " SGD",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: "Poppins Regular",
                                )),
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
                        // if (valueVersion == "0") {
                        //   StoreRedirect.redirect();
                        // } else if (list_setting[0].status == 1) {
                        //   Route route =
                        //       MaterialPageRoute(builder: (context) => CheckOut());
                        //   Navigator.pushReplacement(context, route).then(onGoBack);
                        // } else {}
                        if (totalPrices.isEmpty || totalPrices[0].total_price.toString() == "0") {
                          print('no item in cart');
                        } else {
                          Route route = MaterialPageRoute(
                              builder: (context) => CheckOut());
                          Navigator.push(context, route).then(onGoBack);
                        }
                      },
                      // color: Color(0xffe3724b),
                      // color: Colors.blue,
                      style: checkButtonStyle,
                      child: Text("Pay Now",
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
          ])),
    );
  }
}
