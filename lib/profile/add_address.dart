import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/config/url.dart';

class AddAddress extends StatefulWidget {
  // final String notif_id, buyer_notif_id, order_id;
  // AddAddress(this.notif_id, this.buyer_notif_id, this.order_id);
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final key = new GlobalKey<FormState>();
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id")!;
    });
  }

  String address_name = '',
      receiver_name = '',
      phone_number = '',
      unit_number = '',
      block_number = '',
      street_name = '',
      postal_code = '',
      _mySelection = '',
      order_idNya = '',
      user_id = '',
      no_telp = '';
  var catOngkir = TextEditingController();
  var catResi = TextEditingController();
  // catOngkir.text = ongkir;
  // catResi.text = no_resi;

  // String _baseUrl = "https://admin.tucartpoin.com/api/showVendor";
  // List _data;
  // void getVendor() async {
  //   final response = await http.get(_baseUrl);
  //   var listData = jsonDecode(response.body);
  //   print("data : $listData");
  //   setState(() {
  //     _data = listData;
  //   });
  // }

  confirmShipping() async {
    await getPref();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => _loading(context),
    );
    final response = await http.post(Uri.parse(UserUrl.addAddress), body: {
      "user_id": user_id,
      "address_name": address_name,
      "receiver_name": receiver_name,
      "phone_number": phone_number,
      "unit_number": unit_number,
      "block_number": block_number,
      "street_name": street_name,
      "postal_code": postal_code,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    // String messageEnglish = data['messageEnglish'];
    if (value == 1) {
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
      // registerToast(message);

    } else {
      Navigator.pop(context);
      // print(message);
      _showToast('Fail creating address');
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

  Widget _loading(BuildContext context) {
    return new Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
          title: Text("Please Wait..."),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
                // height: 50,
                // width: 50,
                child: Center(child: CircularProgressIndicator())),
          ),
        ),
      ),
    );
  }

  check() {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      confirmShipping();
    }
  }

  @override
  void initState() {
    super.initState();
    // getVendor();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.grey[400],
      primary: Colors.grey[400],
      // minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
    );
    final ButtonStyle checkButtonStyle = TextButton.styleFrom(
      backgroundColor: Color(0xFF264C95),
      primary: Color(0xFF264C95),
      // minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          key: _scaffoldkey,
          body: Form(
              key: key,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                // Container(
                                //   child:
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 20.0),
                                  child: Text(
                                    "Add Address Detail",
                                    style: TextStyle(
                                        fontFamily: "Poppins Bold",
                                        fontSize: 20.0),
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  color: Colors.black,
                                  thickness: 0.5,
                                ),
                                TextFormField(
                                  onSaved: (e) => address_name = e!,
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Field cannot be empty";
                                    }
                                  },
                                  // controller: catOngkir,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      // labelText: 'Contoh: Sambalnya dipisah ya!',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFBDC3C7),
                                        fontSize: 15,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                      hintText:
                                          "Address title, Example: Home, Office"
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(
                                      //     color: Color(0xFF7F8C8D),
                                      //   ),
                                      // ),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                      ),
                                ),
                                TextFormField(
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Field cannot be empty";
                                    }
                                  },
                                  onSaved: (e) => receiver_name = e!,
                                  // controller: catResi,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      // labelText: 'Contoh: Sambalnya dipisah ya!',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFBDC3C7),
                                        fontSize: 15,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                      // border: InputBorder.none,
                                      // focusedBorder: InputBorder.none,
                                      // enabledBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // disabledBorder: InputBorder.none,
                                      hintText:
                                          "Receiver Name, Example : Richard, Han so he"
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(
                                      //     color: Color(0xFF7F8C8D),
                                      //   ),
                                      // ),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                      ),
                                ),
                                TextFormField(
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Field cannot be empty";
                                    }
                                  },
                                  onSaved: (e) => unit_number = e!,
                                  // controller: catResi,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      // labelText: 'Contoh: Sambalnya dipisah ya!',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFBDC3C7),
                                        fontSize: 15,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                      // border: InputBorder.none,
                                      // focusedBorder: InputBorder.none,
                                      // enabledBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // disabledBorder: InputBorder.none,
                                      hintText: "Your unit number"
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(
                                      //     color: Color(0xFF7F8C8D),
                                      //   ),
                                      // ),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                      ),
                                ),
                                TextFormField(
                                  validator: (e) {
                                    //   if (e!.isEmpty) {
                                    // return "Field cannot be empty";
                                    // }
                                  },
                                  onSaved: (e) => block_number = e!,
                                  // controller: catResi,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      // labelText: 'Contoh: Sambalnya dipisah ya!',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFBDC3C7),
                                        fontSize: 15,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                      // border: InputBorder.none,
                                      // focusedBorder: InputBorder.none,
                                      // enabledBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // disabledBorder: InputBorder.none,
                                      hintText: "Your block number (optional)"
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(
                                      //     color: Color(0xFF7F8C8D),
                                      //   ),
                                      // ),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                      ),
                                ),
                                TextFormField(
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Field cannot be empty";
                                    }
                                  },
                                  onSaved: (e) => street_name = e!,
                                  // controller: catResi,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      // labelText: 'Contoh: Sambalnya dipisah ya!',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFBDC3C7),
                                        fontSize: 15,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                      // border: InputBorder.none,
                                      // focusedBorder: InputBorder.none,
                                      // enabledBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // disabledBorder: InputBorder.none,
                                      hintText: "Your address street name"
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(
                                      //     color: Color(0xFF7F8C8D),
                                      //   ),
                                      // ),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                      ),
                                ),
                                TextFormField(
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Field cannot be empty";
                                    }
                                  },
                                  onSaved: (e) => postal_code = e!,
                                  // controller: catResi,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      // labelText: 'Contoh: Sambalnya dipisah ya!',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFBDC3C7),
                                        fontSize: 15,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                      // border: InputBorder.none,
                                      // focusedBorder: InputBorder.none,
                                      // enabledBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // disabledBorder: InputBorder.none,
                                      hintText: "Your postal code number"
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(
                                      //     color: Color(0xFF7F8C8D),
                                      //   ),
                                      // ),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                      ),
                                ),
                                TextFormField(
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Field cannot be empty";
                                    }
                                  },
                                  onSaved: (e) => phone_number = e!,
                                  // controller: catResi,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      // labelText: 'Contoh: Sambalnya dipisah ya!',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFBDC3C7),
                                        fontSize: 15,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                      // border: InputBorder.none,
                                      // focusedBorder: InputBorder.none,
                                      // enabledBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // disabledBorder: InputBorder.none,
                                      hintText: "Your phone number"
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(
                                      //     color: Color(0xFF7F8C8D),
                                      //   ),
                                      // ),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                      ),
                                ),
                                // ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 15.0),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(3),
                                      // ),
                                      // padding: EdgeInsets.symmetric(
                                      //     vertical: 0, horizontal: 25),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: flatButtonStyle,
                                      // color: Colors.grey[400],
                                      child: Text("Cancel",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Poppins Regular",
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(3),
                                      // ),
                                      // padding: EdgeInsets.symmetric(
                                      //     vertical: 0, horizontal: 25),
                                      onPressed: () {
                                        // if (totalPrices.isEmpty) {
                                        //   _showToast("Keranjang Kosong");
                                        // } else {
                                        //   check();
                                        // }
                                        // orderNow();
                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   new MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         OrderPlaced(totalPrices[0].total_price.toString()),
                                        //   ),
                                        // );
                                        // setState(() {
                                        //   order_idNya = widget.order_id;
                                        // });
                                        check();
                                      },
                                      style: checkButtonStyle,
                                      // color: Color(0xFF264C95),
                                      child: Text("Save",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Poppins Regular",
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
