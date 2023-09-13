// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/model/message.dart';
import 'package:virtual_exhibition_beta/screens/chat/chat_url.dart';

class ChatScreen extends StatefulWidget {
  final int conversation_id;
  final int chat_user_id;
  final String name;
  final bool? isNew;
  // ChatScreen(this.conversation_id);
  const ChatScreen(
      {Key? key,
      required this.conversation_id,
      required this.chat_user_id,
      required this.name,
      this.isNew = false})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController txtChat = TextEditingController();

  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  final _key = GlobalKey<FormState>();

  var user_id;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id");
    });
  }

  String body = "";

  // List<MessageTemplate> templates = [
  //   MessageTemplate(
  //     '1',
  //     'Hellow, How Are you?',
  //   ),
  //   MessageTemplate(
  //     '2',
  //     'Are you okay?',
  //   ),
  //   MessageTemplate(
  //     '3',
  //     'What is the meaning?',
  //   ),
  //   MessageTemplate(
  //     '4',
  //     'Hellow',
  //   ),
  // ];
  // var loading = false;
  // ignore: deprecated_member_use
  final templates = <MessageTemplate>[];
  Future<void> _listTemplate() async {
    await getPref();
    templates.clear();
    // setState(() {
    //   loading = true;
    // });
    final response =
        await http.post(Uri.parse(ChatUrl.messageTemplate), body: {
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
        final ab = MessageTemplate(
            api['id'],
            api['message']);
        templates.add(ab);
      });
      if(this.mounted){
        // setState(() {
        // loading = false;
        // print(data);
        // });
      }
    }
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {
    if (_image == null) {
      // if (_imageFile == null) {
      // await getPref();
      final response = await http.post(Uri.parse(ChatUrl.sendChat), body: {
        // "user_id": user_id,
        // "post_user_id": widget.model.post_user_id,
        // "chat_content": chat_content,
        "user_id": user_id.toString(),
        "conversation_id": widget.conversation_id.toString(),
        "body": body,
      });
      final data = jsonDecode(response.body);
      int value = data['value'];
      String pesan = data['message'];
      if (value == 1) {
        print(pesan);
        setState(() {
          txtChat.clear();
          _refresh.currentState?.show();
        });
      } else {
        print(pesan);
      }
      // }
      // try {
      //   var stream =
      //       http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      //   var length = await _image.length();
      //   var uri = Uri.parse(
      //       "https://dipena.com/flutter/api/chat/sendMessageWithImage2_0.php");
      //   final request = http.MultipartRequest("POST", uri);
      //   request.fields['user_id'] = user_id;
      //   request.fields['user_id_two'] = widget.model.chat_user_one;
      //   // request.fields['chat_content'] = chat_content;

      //   request.files.add(http.MultipartFile("chat_img", stream, length,
      //       filename: path.basename(_image.path)));
      //   var response = await request.send();
      //   final respStr = await response.stream.bytesToString();
      //   if (response.statusCode > 2) {
      //     final data = jsonDecode(respStr);
      //     String img = data['img'];
      //     print("Image uploaded");
      //     print(img);
      //     setState(() {
      //       txtChat.clear();
      //       _image = null;
      //     });
      //   } else {
      //     print("Image failed to be upload");
      //   }
      // } catch (e) {
      //   debugPrint("Error $e");
      // }
    } else {
      try {
        var stream =
            http.ByteStream(DelegatingStream.typed(_image!.openRead()));
        var length = await _image!.length();
        var uri = Uri.parse(ChatUrl.sendChat);
        final request = http.MultipartRequest("POST", uri);
        request.fields['user_id'] = user_id.toString();
        request.fields['conversation_id'] = widget.conversation_id.toString();
        request.fields['body'] = body;
        request.files.add(http.MultipartFile("image", stream, length,
            filename: path.basename(_image!.path)));
        var response = await request.send();
        final respStr = await response.stream.bytesToString();
        if (response.statusCode > 2) {
          setState(() {
            txtChat.clear();
            _refresh.currentState?.show();
            _image = null;
          });
          // print("Image uploaded");
        } else {
          // return false;
          print('gagal');
        }
      } catch (e) {
        debugPrint("Error $e");
        // return false;
        print('$e');
      }
    }
  }

  // var loading = false;
  // // ignore: deprecated_member_use
  // final list = <Messages>[];
  // Future<void> _listChat() async {
  //   // await getPref();
  //   list.clear();
  //   setState(() {
  //     loading = true;
  //   });
  //    final response = await http.post(Uri.parse(ChatUrl.showChat), body: {
  //     "conversation_id": widget.conversation_id.toString(),
  //   });
  //   if (response.contentLength == 2) {
  //     //   await getPref();
  //     // final response =
  //     //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
  //     //   "user_id": user_id,
  //     //   "location_country": location_country,
  //     //   "location_city": location_city,
  //     //   "location_user_id": user_id
  //     // });

  //     // final data = jsonDecode(response.body);
  //     // int value = data['value'];
  //     // String message = data['message'];
  //     // String changeProf = data['changeProf'];
  //   } else {
  //     final data = jsonDecode(response.body);
  //     data.forEach((api) {
  //       final ab = Messages(
  //           api['id'],
  //           api['body'],
  //           api['date'],
  //           api['read'],
  //           api['user_id'],
  //           api['conversation_id']);
  //       list.add(ab);
  //     });
  //     setState(() {
  //       loading = false;
  //       // print(data);
  //     });
  //   }
  // }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return 'last seen ${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return 'last seen ${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return 'last seen ${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return 'last seen ${diff.inSeconds} second(s) ago';
    } else {
      return 'last seen just now';
    }
  }

  int online = 0;
  String lastSeen = "";
  DateTime seen = DateTime.now();

  checkOnline() async {
    final response = await http.post(Uri.parse(ChatUrl.checkOnline),
        body: {"user_id": widget.chat_user_id.toString()});

    final data = jsonDecode(response.body);
    int is_online = data['is_online'];
    String last_seen = data['updated_at'];

    if (is_online == 1) {
      if (this.mounted) {
        setState(() {
          online = is_online;
        });
      }

      // print(is_online);
      // print(last_seen);
      // print(data);
      // _showToast(message);
    } else {
      if (this.mounted) {
        setState(() {
          online = 0;
          lastSeen = last_seen;
          seen = DateTime.parse(lastSeen);
        });
      }

      // print(is_online);
      // print(last_seen);
      // print("fail");
      // print(message);
    }
  }

  int count = 1;
  Timer? timer;
  int counter = 0;

  StreamController? _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future fetchPost() async {
    // await getPref();
    await widget.conversation_id;
    final response = await http.post(Uri.parse(ChatUrl.showChat), body: {
      "conversation_id": widget.conversation_id.toString(),
      // "post_user_id": user_id,
      // "post_user_id": widget.model.chat_user_two,
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  void addValue() {
    // if(list.insert == true){
    setState(() {
      // counter++;
      //  print("nambah");
      // list[i]
      checkOnline();
      _refresh.currentState?.show();
      // _messages.clear();
    });
    // }
  }

  loadPosts() async {
    fetchPost().then((res) async {
      _postsController?.add(res);
      print(res);
      return res;
    });
  }

  Future<Null> _handleRefresh() async {
    // count++;
    // print(count);
    fetchPost().then((res) async {
      _postsController?.add(res);
      // showSnack();
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    timer =
        Timer.periodic(Duration(milliseconds: 1000), (Timer t) => addValue());
    checkOnline();
    // _listChat();
    _postsController = new StreamController();
    loadPosts();
    _listTemplate();
  }

  @override
  void dispose() {
    // _tapGallery.dispose();
    // _tapCamera.dispose();
    timer?.cancel();
    super.dispose();
  }

  Widget _template() {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.black,
      // minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          return BorderSide(
            color: Colors.black,
            width: 1,
          );
        },
      ),
    );
    return Container(
      width: MediaQuery.of(context).size.width / 1.05,
      height: MediaQuery.of(context).size.height / 13,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: templates.length,
        itemBuilder: (BuildContext context, int index) {
          final x = templates[index];
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: OutlinedButton(
                  // borderSide: BorderSide(
                  //   color: Colors.black,
                  // ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                  child: Text(
                    x.message,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: "Poppins Regular",
                    ),
                  ),
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   new MaterialPageRoute(
                    //     builder: (context) => CategoryPage(x),
                    //   ),
                    // );
                    txtChat.text = x.message;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  XFile? _image;

  void _pilihGallery() async {
    // Uint8List img = await pickImage(ImageSource.gallery);
    // setState(() {
    //   _image = img;
    // });
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _pilihCamera() async {
    // Uint8List img = await pickImage(ImageSource.camera);
    // setState(() {
    //   _image = img;
    // });
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Images Selected');
  }

  // File _imageFile;

  // _pilihGallery() async {
  //   var image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
  //   setState(() {
  //     _imageFile = image;
  //   });
  // }

  // _pilihCamera() async {
  //   var image = await ImagePicker.pickImage(
  //       source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
  //   setState(() {
  //     _imageFile = image;
  //   });
  // }

  Widget _popUpImage(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
            content: Text("Choose Method"),
            actions: <Widget>[
              Container(
                color: Colors.white,
                child: CupertinoDialogAction(
                  child: Text(
                    'Camera',
                    style: new TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _pilihCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: CupertinoDialogAction(
                  child: Text(
                    'Gallery',
                    style: new TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _pilihGallery();
                    // delete();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]),
      ),
    );
  }

  Widget _chatField() {
    return Form(
      key: _key,
      child: Container(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.all(10),
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              // ignore: prefer_const_constructors
              BoxShadow(
                color: Colors.grey,
                offset: Offset(-2, 0),
                blurRadius: 5,
              ),
            ],
          ),
          child: _image == null
              ? Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _popUpImage(context),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: txtChat,
                        onSaved: (e) => body = e!,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Enter Message",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: "Poppins Regular",
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        check();
                      },
                    ),
                  ],
                )
              : Row(
                  children: <Widget>[
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.image,
                    //     color: Colors.black,
                    //   ),
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) =>
                    //           _popUpImage(context),
                    //     );
                    //   },
                    // ),
                    InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _popUpImage(context),
                          );
                        },
                        child: Image.file(
                          File(_image!.path),
                          width: 50,
                          height: 50,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: txtChat,
                        onSaved: (e) => body = e!,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Enter Message",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: "Poppins Regular",
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        check();
                        print('a');
                      },
                    ),
                  ],
                )

          // Container(
          //     height: MediaQuery.of(context).size.height / 2 - 75,
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         Image.memory(_image!, width: 50,),
          //         IconButton(
          //           icon: Icon(
          //             Icons.send,
          //             color: Colors.black,
          //           ),
          //           onPressed: () {
          //             // check();
          //           },
          //         ),
          //       ],
          //     ))),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = CircleAvatar(
      backgroundImage: AssetImage(
        "assets/man.png",
      ),
      backgroundColor: Colors.grey[200],
      minRadius: 30,
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            int count = 0;
            widget.isNew == true
                ? Navigator.of(context).popUntil((_) => count++ >= 2)
                : Navigator.pop(context);
          },
        ),
        title: Row(
          children: <Widget>[
            Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                child:
                    // widget.model.user_img_from == null
                    // ?
                    placeholder
                // : CircleAvatar(
                //     backgroundImage: NetworkImage(
                //         // "assets/img/icon_one.jpg",
                //         ImageUrl.imageProfile + widget.model.user_img_from),
                //     backgroundColor: Colors.grey[200],
                //     minRadius: 30,
                //   ),
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  // "Sasha Witt",
                  widget.name,
                  // widget.model.user_fullname_from,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Poppins Medium",
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: '',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                      children: <TextSpan>[
                        TextSpan(
                            // text: widget.model.user_username_from,
                            text: online == 1 ? "online" : convertToAgo(seen),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins Regular",
                              fontSize: 13,
                            )),
                      ]),
                ),
                // Text(
                //   // "@sasha",
                //   widget.model.user_username_from,
                //   style: TextStyle(
                //     color: Color(0xFF7F8C8D),
                //     fontSize: 13,
                //     fontFamily: "Poppins Regular",
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
      body: Container(
        // color: Colors.white,
        // backgroundColor: Colors.white,
        // Function(ScrollNotification:)
        // notificationPredicate: Notification,
        // onRefresh: _handleRefresh,
        // key: _refresh,
        child: Column(
          children: <Widget>[
            // Flexible(
            //   child: Column(
            //           children: <Widget>[
            //             Expanded(
            //               child: Scrollbar(
            //                 child: Padding(
            //                       padding:
            //                           EdgeInsets.only(left: 10, right: 10),
            //                       child: Column(
            //                         children: <Widget>[
            //                           // post["chat_user_one"] == user_id
            //                           //     ? Bubble(
            //                           //         message: post["chat_content"],
            //                           //         isMe: true,
            //                           //       )
            //                           //     : Bubble(
            //                           //         message: post["chat_content"],
            //                           //         isMe: false,
            //                           //       ),
            //                           // post['chat_img'] == null
            //                           //     ? post["chat_user_one"] == user_id
            //                           //         ? Bubble(
            //                           //             message:
            //                           //                 post["chat_content"],
            //                           //             isMe: true,
            //                           //           )
            //                           //         :
            //                                   Bubble(
            //                                       message:
            //                                           "Hiii!",
            //                                       isMe: false,
            //                                     ),
            //                                    Bubble(
            //                                       message:
            //                                           "Hellow",
            //                                       isMe: true,
            //                                     ),
            //                                   Bubble(
            //                                       message:
            //                                           "Where are you now?",
            //                                       isMe: false,
            //                                     ),
            //                                    Bubble(
            //                                       message:
            //                                           "I'm Here",
            //                                       isMe: true,
            //                                     ),
            //                         ],
            //                       ),
            //                     ),
            //               ),
            //             ),
            //           ],
            //         ),
            // ),
            //  ),
            RefreshIndicator(
              onRefresh: _handleRefresh,
              key: _refresh,
              child: Container(),
            ),
            Flexible(
              child: StreamBuilder(
                stream: _postsController!.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // print('Has error: ${snapshot.hasError}');
                  // print('Has data: ${snapshot.hasData}');
                  // print('Snapshot Data ${snapshot.data}');

                  // if (snapshot.hasError) {
                  //   return Text(snapshot.error);
                  // }

                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Scrollbar(
                            child: RefreshIndicator(
                              onRefresh: _handleRefresh,
                              child: ListView.builder(
                                reverse: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  var post = snapshot.data[index];
                                  // print(user_id);
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: <Widget>[
                                        // post["chat_user_one"] == user_id
                                        //     ? Bubble(
                                        //         message: post["chat_content"],
                                        //         isMe: true,
                                        //       )
                                        //     : Bubble(
                                        //         message: post["chat_content"],
                                        //         isMe: false,
                                        //       ),
                                        // post['chat_img'] == null
                                        // ?
                                        post['image'] == null
                                            ? post["user_id"].toString() ==
                                                    user_id
                                                ? post["body"].contains('http')
                                                    ? Bubble(
                                                        message: post["body"],
                                                        isMe: true,
                                                        isLink: true,
                                                      )
                                                    : Bubble(
                                                        message: post["body"],
                                                        isMe: true,
                                                      )
                                                : post["body"].contains('http')
                                                    ? Bubble(
                                                        message: post["body"],
                                                        isMe: false,
                                                        isLink: true,
                                                      )
                                                    : Bubble(
                                                        message: post["body"],
                                                        isMe: false,
                                                      )
                                            : post["user_id"].toString() ==
                                                    user_id
                                                ? Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0, top: 8.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                            child: Image.network(
                                                                AssetsUrl.chat_image +
                                                                    post[
                                                                        'image']),
                                                          ),
                                                        ),
                                                      ),
                                                      Bubble(
                                                        message: post[
                                                            "body"],
                                                        isMe: true,
                                                      )
                                                    ],
                                                  )
                                                : Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0, top: 8.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                            child: Image.network(
                                                                AssetsUrl.chat_image +
                                                                    post[
                                                                        'image']),
                                                          ),
                                                        ),
                                                      ),
                                                      Bubble(
                                                        message: post[
                                                            "body"],
                                                        isMe: false,
                                                      )
                                                    ],
                                                  )
                                        // Text("Gk ada gambar ")

                                        //     ? post["chat_user_one"] == user_id
                                        //         ? Bubble(
                                        //             message:
                                        //                 post["chat_content"],
                                        //             isMe: true,
                                        //           )
                                        //         : Bubble(
                                        //             message:
                                        //                 post["chat_content"],
                                        //             isMe: false,
                                        //           )
                                        //     : Column(
                                        //         children: <Widget>[
                                        //           post["chat_user_one"] ==
                                        //                   user_id
                                        //               ?  Column(
                                        //                   children: <Widget>[
                                        // post["chat_user_one"] == user_id
                                        //     ? Column(
                                        //         children: <Widget>[
                                        //           Padding(
                                        //             padding: const EdgeInsets.only(bottom: 8.0),
                                        //             child: Align(
                                        //               alignment: Alignment
                                        //                   .centerRight,
                                        //               child: Container(
                                        //                 width: MediaQuery.of(
                                        //                             context)
                                        //                         .size
                                        //                         .width /
                                        //                     2,
                                        //                 child: Image.network(
                                        //                     ImageUrl.imageChat +
                                        //                         post[
                                        //                             'chat_img']),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           // Bubble(
                                        //           //   message: post[
                                        //           //       "chat_content"],
                                        //           //   isMe: true,
                                        //           // )
                                        //         ],
                                        //       )
                                        //     : Column(
                                        //         children: <Widget>[
                                        //           Padding(
                                        //             padding: const EdgeInsets.only(bottom: 8.0),
                                        //             child: Align(
                                        //               alignment: Alignment
                                        //                   .centerLeft,
                                        //               child: Container(
                                        //                 width: MediaQuery.of(
                                        //                             context)
                                        //                         .size
                                        //                         .width /
                                        //                     2,
                                        //                 child: Image.network(
                                        //                     ImageUrl.imageChat +
                                        //                         post[
                                        //                             'chat_img']),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           // Bubble(
                                        //           //   message: post[
                                        //           //       "chat_content"],
                                        //           //   isMe: false,
                                        //           // )
                                        //         ],
                                        //       )
                                        //                     Bubble(
                                        //                       message: post[
                                        //                           "chat_content"],
                                        //                       isMe: true,
                                        //                     )
                                        //                   ],
                                        //                 )
                                        //               : Column(
                                        //                   children: <Widget>[
                                        //                     Image.network(ImageUrl
                                        //                             .imageChat+
                                        //                         post[
                                        //                             'chat_img']),
                                        //                     Bubble(
                                        //                       message: post[
                                        //                           "chat_content"],
                                        //                       isMe: false,
                                        //                     ),
                                        //                   ],
                                        //                 )
                                        //         ],
                                        //       )

                                        //  Bubble(
                                        //             message:
                                        //                 post["chat_content"],
                                        //             isMe: false,
                                        //           )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Text('No Posts');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
            Container(child: _template()),
            Container(child: _chatField())
          ],
        ),
      ),
      //     Container(child: _chatField())
      //   ],
      // ),
    );
  }
}

class Bubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final bool? isLink;

  Bubble({required this.message, required this.isMe, this.isLink = false});

  Widget build(BuildContext context) {
    return isLink == true
        ? InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
              padding: isMe
                  ? EdgeInsets.only(
                      left: 40,
                    )
                  : EdgeInsets.only(
                      right: 40,
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: isLink == true
                              ? Colors.grey[200]
                              : isMe
                                  ? Colors.grey[600]
                                  : Colors.grey[300],
                          borderRadius: isMe
                              ? BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(15),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(0),
                                ),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ChatUrlScreen(url: message)));
                              },
                              child: Text(
                                message,
                                textAlign:
                                    isMe ? TextAlign.end : TextAlign.start,
                                style: TextStyle(
                                  color: isLink == true
                                      ? Colors.blue
                                      : isMe
                                          ? Colors.white
                                          : Colors.black,
                                  fontFamily: "Poppins Regular",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
            padding: isMe
                ? EdgeInsets.only(
                    left: 40,
                  )
                : EdgeInsets.only(
                    right: 40,
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.grey[600] : Colors.grey[300],
                        borderRadius: isMe
                            ? BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(15),
                              )
                            : BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(0),
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            message,
                            textAlign: isMe ? TextAlign.end : TextAlign.start,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                              fontFamily: "Poppins Regular",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
