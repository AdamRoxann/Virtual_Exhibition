import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/conversation.dart';
import 'package:virtual_exhibition_beta/screens/chat/chat_screen.dart';
import 'package:virtual_exhibition_beta/screens/chat/list_user.dart';

class ListConversation extends StatefulWidget {
  const ListConversation({Key? key}) : super(key: key);

  @override
  _ListConversationState createState() => _ListConversationState();
}

class _ListConversationState extends State<ListConversation> {
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
  // ignore: deprecated_member_use
  final list = <ListConversationModel>[];
  Future<void> _listChat() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response =
        await http.post(Uri.parse(ChatUrl.listConversation), body: {
      "user_id": user_id.toString(),
    });
    if (response.contentLength == 2) {
      print("no data");
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
        final ab = ListConversationModel(
            api['id'],
            api['user_id'],
            api['second_user_id'],
            api['user1'],
            api['user2'],
            api['body'],
            api['date']);
        list.add(ab);
      });
      if(this.mounted){
        setState(() {
        loading = false;
        print(data);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listChat();
  }

  // getbooth() async {
  //   final response = await http.post(Uri.parse(ChatUrl.listConversation), body: {
  //     "user_id": "6",
  //   });

  //   final data = jsonDecode(response.body);
  //   int id = data['id'];
  //   int booth_id = data['booth_id'];
  //   String booth_header_title = data['booth_header_title'];
  //   String booth_header = data['booth_header'];
  //   String booth_stand = data['booth_stand'];
  //   String booth_tv_display = data['booth_tv_display'];
  //   // String tokenAPI = data['api_key'];
  //   // print(data);

  //   // if (booth_id == 1) {
  //   //   // Navigator.pop(context);
  //     setState(() {
  //       booth_header_title = booth_header_title;
  //       booth_header_link = booth_header;
  //       booth_stand_link = booth_stand;
  //       booth_tv_display_link = booth_tv_display;
  //     });

  //     print(booth_header_title);
  //     print(booth_header_link);
  //     print(booth_stand_link);
  //     print(booth_tv_display_link);
  //   //   // print(message);
  //   //   print(data);
  //   //   // _showToast(message);
  //   // } else {
  //   //   // Navigator.pop(context);
  //   //   print("fail");
  //   //   // print(message);
  //   // }
  // }

  Future<void> _refreshChat() async {
    _listChat();
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = CircleAvatar(
      backgroundColor: Color(0xFF7F8C8D),
      child: ClipOval(
        child: Image(
          image: AssetImage("assets/man.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
    var placeholder2 = CircleAvatar(
      backgroundColor: Color(0xFF7F8C8D),
      child: ClipOval(
        child: Image(
          image: AssetImage("assets/old-woman.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
         actions: <Widget>[
          IconButton(
          icon: Icon(
            Icons.create_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ListOnline()));
          },
          )
        ],
        centerTitle: true,
        title: Text(
          "Chats",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Poppins Medium",
          ),
        ),
      ),
      body: list.isEmpty
          ? RefreshIndicator(
            onRefresh: _refreshChat,
            child: Center(
                child: Container(
                child: Text("You haven't chat anyone"),
              )),
          )
          : RefreshIndicator(
            onRefresh: _refreshChat,
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: placeholder
                        // ),
                        // ),
                        ),
                    title: Text(
                      // name,
                      x.user_id.toString() == user_id ? x.user2 : x.user1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins Semibold",
                      ),
                    ),
                    subtitle: Text(
                      // chat,
                      x.body,
                      style: TextStyle(
                        color: Color(0xFF7F8C8D),
                        fontSize: 15,
                        fontFamily: "Poppins Regular",
                      ),
                    ),
                    trailing: Text(
                      // time,
                      x.date,
                      style: TextStyle(
                        color: new Color(0xFF7F8C8D),
                        fontFamily: "Poppins Regular",
                      ),
                    ),
                    onTap: () async {
                      x.user_id.toString() == user_id
                          ? Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    conversation_id: x.id,
                                    chat_user_id: x.second_user_id,
                                    name: x.user2),
                              ),
                            )
                          : Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    conversation_id: x.id,
                                    chat_user_id: x.user_id,
                                    name: x.user1),
                              ),
                            );
                    },
                  );
                },
                // children: <Widget>[
                // new ListChatModel(
                //   profile: "assets/img/icon_one.jpg",
                //   name: "Tia Nurmala",
                //   chat: "Ini adalah isi chatnya",
                //   time: "05.00",
                // ),
                // new ListChatModel(
                //   profile: "assets/img/icon_two.png",
                //   name: "Taye",
                //   chat: "Ini adalah isi chatnya",
                //   time: "06.00",
                // ),
                // new ListChatModel(
                //   profile: "assets/img/icon_three.jpg",
                //   name: "Baby",
                //   chat: "Ini adalah isi chatnya",
                //   time: "07.00",
                // ),
                // new ListChatModel(
                //   profile: "assets/img/icon_four.jpg",
                //   name: "Mala",
                //   chat: "Ini adalah isi chatnya",
                //   time: "08.00",
                // ),
                // new ListChatModel(
                //   profile: "assets/img/icon_five.jpg",
                //   name: "Roxann",
                //   chat: "Ini adalah isi chatnya",
                //   time: "09.00",
                // ),
                // new ListChatModel(
                //   profile: "assets/img/icon_six.jpg",
                //   name: "Joe",
                //   chat: "Ini adalah isi chatnya",
                //   time: "12.00",
                // ),
                // ],
              ),
          ),
    );
  }
}
