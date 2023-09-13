import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/address_model.dart';
import 'package:virtual_exhibition_beta/profile/add_address.dart';
import 'package:virtual_exhibition_beta/profile/edit_address.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  var user_id, color;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id");
      // token = preferences.getString("token");
    });
  }

  var loading = false;
  final list = <AddressModel>[];
  Future<void> _allAddress() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.post(Uri.parse(UserUrl.myAddress),
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

  activateAddress(id) async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(Uri.parse(UserUrl.activateAddress), body: {
      "user_id": user_id.toString(),
      "id": id,
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
      // _quantity_refresh.currentState.show();
      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast('Delete All items from cart failed');
      // registerToast(message);
    }
  }

  deleteAddress(id) async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(Uri.parse(UserUrl.deleteAddress), body: {
      "user_id": user_id.toString(),
      "id": id.toString(),
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

  Future onGoBack(dynamic value) async {
    _allAddress();
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _allAddress();
    print(color);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle checkButtonStyle = TextButton.styleFrom(
      backgroundColor: Color(0xFF264C95),
      primary: Color(0xFF264C95),
      // minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
          title: Text("Shipping Address",
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
        body: Stack(
          children: [
            RefreshIndicator(
              child: Container(),
              onRefresh: _allAddress,
              key: _refresh,
            ),
            list.isEmpty
                ? Center(
                    child: Container(
                      child: Text("You don't have any addresses yet"),
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, i) {
                              final x = list[i];
                              return InkWell(
                                onTap: () {
                                  activateAddress(x.id.toString());
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    color: x.status == 1
                                        ? Color(0xff2a9d8f)
                                        : Colors.white,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: Text(
                                                          // "Nama Alamat",
                                                          x.address_name,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "Poppins Bold",
                                                            color: x.status == 1
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: IconButton(
                                                                icon: Icon(
                                                                    Icons.edit),
                                                                onPressed: () {
                                                                  Route route =
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              EditAddress(x.id));
                                                                  Navigator.push(
                                                                          context,
                                                                          route)
                                                                      .then(
                                                                          onGoBack);
                                                                },
                                                              )),
                                                          x.status == 0
                                                              ? Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(
                                                                        color: Colors
                                                                            .red,
                                                                        Icons
                                                                            .delete),
                                                                    onPressed:
                                                                        () {
                                                                      deleteAddress(
                                                                          x.id);
                                                                    },
                                                                  ))
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                      // "Alamat",
                                                      x.address,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "Poppins Regular",
                                                        color: x.status == 1
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      maxLines: 3,
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily:
                                                          "Poppins SemiBold",
                                                      color:
                                                          x.status == 'Active'
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 8.0),
                                            child: Text(
                                              x.created_at.substring(0, 10),
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Poppins Regular",
                                                color: x.status == 1
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),

                            ),
                      ),
                      SizedBox(
                        height: 75,
                      )
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
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(3),
                    // ),
                    // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (context) => AddAddress());
                      Navigator.push(context, route).then(onGoBack);
                    },
                    style: checkButtonStyle,
                    // color: Color(0xFF264C95),
                    child: Text("Add Address",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: "Poppins Regular",
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
//     return 
//   }
// }
