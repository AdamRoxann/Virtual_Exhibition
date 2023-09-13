import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tucartpoin/in_app/home/detail.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/orders_model.dart';
import 'package:virtual_exhibition_beta/profile/history_detail.dart';
// import 'package:tucartpoin/in_app/home/packageSend.dart';
// import 'package:tucartpoin/in_app/profile/historyDetail.dart';
// import 'package:tucartpoin/model/order_model.dart';
// import 'package:tucartpoin/url.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
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
  final list = <OrderList>[];
  Future<void> _allAddress() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http
        .post(Uri.parse(VendorUrl.order_list), body: {"user_id": user_id});
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
        final ab = new OrderList(
          api['id'],
          api['user_id'],
          api['name'],
          api['product_id'],
          api['product_name'],
          api['product_image'],
          api['product_description'],
          api['price'],
          api['quantity'],
          api['status'],
          api['address'],
          api['total_price'],
          api['invoice_id'],
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
    getPref();
    _allAddress();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          title: Text("All Order",
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
          key: _refresh,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          final x = list[i];
                          return Center(
                            child: Container(
                              width: 360.0,
                              child: Card(
                                margin: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child:
                                              Text("Invoice: " + x.invoice_id)),
                                    ),
                                    Divider(height: 1.0),
                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Image.network(AssetsUrl.product +
                                            x.product_image)),
                                    Divider(height: 1.0),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Product Name: " +
                                                  x.product_name),
                                              Text("Quantity: " +
                                                  x.quantity.toString()),
                                              Text("Total price: " +
                                                  x.total_price.toString()),
                                            ],
                                          )),
                                    ),
                                    Divider(height: 1.0),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Buyer Name: " + x.name),
                                              Text("Buyer Address: " +
                                                  x.address),
                                            ],
                                          )),
                                    ),
                                    // _DeliveryProcesses(processes: x.deliveryProcesses),
                                    Divider(height: 1.0),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      // child: _ProceedButton(status: x.status),
                                      child: x.status == 3
                                          ? Container(
                                              child:
                                                  Text("Product In Shipping"),
                                            )
                                          : x.status == 4
                                              ? Container(
                                                  child: Text(
                                                      "Product Arrived at Destination"),
                                                )
                                              : x.status == 5
                                                  ? Container(
                                                      child: Text(
                                                          "Product Received by Buyer"),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            // ScaffoldMessenger.of(context).showSnackBar(
                                                            //   SnackBar(
                                                            //     content: Text('On-time!'),
                                                            //   ),
                                                            // );
                                                            save(x.id, 6);
                                                          },
                                                          elevation: 0,
                                                          shape:
                                                              StadiumBorder(),
                                                          color: Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          child: Text(
                                                              'Cancel Order'),
                                                        ),
                                                        x.status == 1
                                                            ? MaterialButton(
                                                                onPressed: () {
                                                                  // ScaffoldMessenger.of(context).showSnackBar(
                                                                  //   SnackBar(
                                                                  //     content: Text('On-time!'),
                                                                  //   ),
                                                                  // );
                                                                  save(x.id, 2);
                                                                },
                                                                elevation: 0,
                                                                shape:
                                                                    StadiumBorder(),
                                                                color: Color(
                                                                    0xff66c97f),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                child: Text(
                                                                    'Packing Now'),
                                                              )
                                                            : x.status == 2
                                                                ? MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      // ScaffoldMessenger.of(context).showSnackBar(
                                                                      //   SnackBar(
                                                                      //     content: Text('On-time!'),
                                                                      //   ),
                                                                      // );
                                                                      save(x.id,
                                                                          3);
                                                                    },
                                                                    elevation:
                                                                        0,
                                                                    shape:
                                                                        StadiumBorder(),
                                                                    color: Color(
                                                                        0xff66c97f),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    child: Text(
                                                                        'Process Shipping'),
                                                                  )
                                                                : Container()
                                                      ],
                                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
      ),
    );
  }
}

// class _ProceedButton extends StatelessWidget {
//   const _ProceedButton({Key? key, required this.status}) : super(key: key);

//   final int status;

//   @override
//   Widget build(BuildContext context) {
//     return status == 3
//         ? Container(
//             child: Text("Product In Shipping"),
//           )
//         : status == 4
//             ? Container(
//                 child: Text("Product Arrived at Destination"),
//               )
//             : status == 5
//                 ? Container(
//                     child: Text("Product Received by Buyer"),
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           // ScaffoldMessenger.of(context).showSnackBar(
//                           //   SnackBar(
//                           //     content: Text('On-time!'),
//                           //   ),
//                           // );
//                         },
//                         elevation: 0,
//                         shape: StadiumBorder(),
//                         color: Colors.red,
//                         textColor: Colors.white,
//                         child: Text('Cancel Order'),
//                       ),
//                       status == 1
//                           ? MaterialButton(
//                               onPressed: () {
//                                 // ScaffoldMessenger.of(context).showSnackBar(
//                                 //   SnackBar(
//                                 //     content: Text('On-time!'),
//                                 //   ),
//                                 // );
//                               },
//                               elevation: 0,
//                               shape: StadiumBorder(),
//                               color: Color(0xff66c97f),
//                               textColor: Colors.white,
//                               child: Text('Packing Now'),
//                             )
//                           : status == 2
//                               ? MaterialButton(
//                                   onPressed: () {
//                                     // ScaffoldMessenger.of(context).showSnackBar(
//                                     //   SnackBar(
//                                     //     content: Text('On-time!'),
//                                     //   ),
//                                     // );
//                                   },
//                                   elevation: 0,
//                                   shape: StadiumBorder(),
//                                   color: Color(0xff66c97f),
//                                   textColor: Colors.white,
//                                   child: Text('Process Shipping'),
//                                 )
//                               : Container()
//                     ],
//                   );
//   }
// }
