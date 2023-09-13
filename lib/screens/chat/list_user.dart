// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/users.dart';
import 'package:virtual_exhibition_beta/screens/chat/new_message.dart';
class ListOnline extends StatefulWidget {
  const ListOnline({Key? key}) : super(key: key);

  @override
  _ListOnlineState createState() => _ListOnlineState();
}

class _ListOnlineState extends State<ListOnline> {

  var user_id;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id");
    });
  }

  List<Users> _list = [];
  List<Users> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    await getPref();
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =
        await http.post(Uri.parse(UserUrl.listOnline), body: {
          'user_id': user_id
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Users.formJson(i as Map<String, dynamic>));
          loading = false;
          print(data);
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.name.contains(text) ||
          f.email.contains(text)) _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50.0),
            // color: Colors.blue,
            child: ListTile(
              // leading: IconButton(
              //     onPressed: () {
              //       // Navigator.pop(context);
              //     },
              //     icon: Icon(Icons.search),
              //     color: Colors.black),
              title: TextField(
                cursorColor: Colors.grey,
                cursorWidth: 1,
                autofocus: false,
                style: TextStyle(
                  color: Colors.black,
                  //  Color.fromRGBO(244, 217, 66, 1),
                  fontSize: 20,
                  // fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
                controller: controller,
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFBDC3C7),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  controller.clear();
                  onSearch('');
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Divider(
              color: Colors.black,
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child:
                      _search.length != 0 || controller.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _search.length,
                              itemBuilder: (context, i) {
                                final b = _search[i];
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12.0, left: 20.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // user_detail_id = b.user_id;
                                         Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) =>
                                              NewMessage(name: b.name, chat_user_id: b.id),
                                        ),
                                        );
                                      });
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   new MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         UserProfile(user_detail_id),
                                      //   ),
                                      // );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            // b.user_img == null
                                            //     ? placeholder
                                            //     : CircleAvatar(
                                            //         backgroundImage: NetworkImage(
                                            //             ImageUrl.imageProfile +
                                            //                 b.user_img),
                                            //         minRadius: 23,
                                            //       ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 12.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: 165,
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(b.name,
                                                          textAlign: TextAlign.left,
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold)),
                                                      // Flexible(
                                                      // child:
                                                      // Text(
                                                      //   b.is_online.toString(),
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      //   textAlign: TextAlign.left,
                                                      //   softWrap: false,
                                                      //   // ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(right: 20.0),
                                        //   child: FlatButton(
                                        //     textColor: Colors.black,
                                        //     shape: RoundedRectangleBorder(
                                        //         side: BorderSide(
                                        //             color: Colors.grey,
                                        //             width: 1,
                                        //             style: BorderStyle.solid),
                                        //         borderRadius:
                                        //             BorderRadius.circular(10)),
                                        //     onPressed: () {
                                        //       // print(x.user_id);
                                        //       // setState(() {
                                        //       //   block_user_two_id = x.user_id;
                                        //       // });
                                        //       // block();
                                        //       // _refresh.currentState.show();
                                        //     },
                                        //     child: Text("Unblock"),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                                // Container(
                                //     padding: EdgeInsets.all(10.0),
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: <Widget>[
                                //         Text(
                                //           b.user_username,
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: 18.0),
                                //         ),
                                //         SizedBox(
                                //           height: 4.0,
                                //         ),
                                //         Text(b.user_id),
                                //       ],
                                //     ));
                              },
                            )
                          : ListView.builder(
                              itemCount: _list.length,
                              itemBuilder: (context, i) {
                                final a = _list[i];
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) =>
                                              NewMessage(name: a.name, chat_user_id: a.id),
                                        ),
                                        );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            a.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          // Text(a.is_online.toString()),
                                        ],
                                      )
                                      ),
                                );
                              },
                            ),
              )
                //       ListView(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 1.0, left: 20.0),
                //       child: InkWell(
                //         onTap: () {
                //           setState(() {
                //             // user_detail_id = b.user_id;
                //           });
                //           // Navigator.pushReplacement(
                //           //   context,
                //           //   new MaterialPageRoute(
                //           //     builder: (context) =>
                //           //         UserProfile(user_detail_id),
                //           //   ),
                //           // );
                //         },
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Row(
                //               children: <Widget>[
                //                 // b.user_img == null
                //                 //     ? placeholder
                //                 //     : CircleAvatar(
                //                 //         backgroundImage: NetworkImage(
                //                 //             ImageUrl.imageProfile +
                //                 //                 b.user_img),
                //                 //         minRadius: 23,
                //                 //       ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 12.0),
                //                   child: Align(
                //                     alignment: Alignment.centerLeft,
                //                     child: Container(
                //                       width: 165,
                //                       child: Column(
                //                         // mainAxisAlignment: MainAxisAlignment.start,
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: <Widget>[
                //                           Text("User1",
                //                               textAlign: TextAlign.left,
                //                               style: new TextStyle(
                //                                   fontWeight: FontWeight.bold)),
                //                           // Flexible(
                //                           // child:
                //                           Text(
                //                             'Test',
                //                             overflow: TextOverflow.ellipsis,
                //                             textAlign: TextAlign.left,
                //                             softWrap: false,
                //                             // ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                 )
                //               ],
                //             ),
                //             // Padding(
                //             //   padding: const EdgeInsets.only(right: 20.0),
                //             //   child: FlatButton(
                //             //     textColor: Colors.black,
                //             //     shape: RoundedRectangleBorder(
                //             //         side: BorderSide(
                //             //             color: Colors.grey,
                //             //             width: 1,
                //             //             style: BorderStyle.solid),
                //             //         borderRadius:
                //             //             BorderRadius.circular(10)),
                //             //     onPressed: () {
                //             //       // print(x.user_id);
                //             //       // setState(() {
                //             //       //   block_user_two_id = x.user_id;
                //             //       // });
                //             //       // block();
                //             //       // _refresh.currentState.show();
                //             //     },
                //             //     child: Text("Unblock"),
                //             //   ),
                //             // )
                //           ],
                //         ),
                //       ),
                //     )
                //   ],
                // )),
        ],
      ),
    ));
  }
}
