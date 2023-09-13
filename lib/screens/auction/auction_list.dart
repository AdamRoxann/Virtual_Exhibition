import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tucartpoin/in_app/home/detail.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/auction_model.dart';
import 'package:virtual_exhibition_beta/screens/auction/auction_detail.dart';
// import 'package:tucartpoin/in_app/home/packageSend.dart';
// import 'package:tucartpoin/in_app/profile/historyDetail.dart';
// import 'package:tucartpoin/model/order_model.dart';
// import 'package:tucartpoin/url.dart';

class AuctionList extends StatefulWidget {
  final booth_id;
  AuctionList(this.booth_id);
  @override
  _AuctionListState createState() => _AuctionListState();
}

class _AuctionListState extends State<AuctionList> {
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
  final list = <AuctionProduct>[];
  Future<void> _allAddress() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response =
        await http.post(Uri.parse(AuctionUrl.auctionList), body: {"booth_id": widget.booth_id.toString()});
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
        final ab = new AuctionProduct(
          api['id'],
          api['booth_id'],
          api['vendor_id'],
          api['product_id'],
          api['product_name'],
          api['product_description'],
          api['product_image'],
          api['last_bidder_id'],
          api['name'],
          api['start_amount'],
          api['bin_amount'],
          api['current_amount'],
          api['minimum_amount'],
          api['maximum_amount'],
          api['start_time'],
          api['finish_time'],
          api['order_available_time'],
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
        title: Text("Booth "+widget.booth_id.toString()+" Auction List",
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
                      child: Text("This booth don't have any auction available"),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          final x = list[i];
                          return InkWell(
                            onTap: () {
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //       builder: (context) => HistoryDetail(
                                  //         x.product_id.toString(),
                                  //         x.order_list_id.toString(),
                                  //       ),
                                  //     ),
                                  //   );
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => AuctionDetail()
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
                                                    x.product_description,
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
