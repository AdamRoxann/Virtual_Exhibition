import 'package:flutter/material.dart';
import 'package:virtual_exhibition_beta/screens/chat/new_message.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: (){
        Navigator.pop(context);
      },)),
      body: Column(children: [
        Image.network(
            'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=2000'),
        Text('Menu'),
        Container(
          // alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              // deleteCart();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewMessage(chat_user_id: 3, name: 'Reza', messageTemplate: 'Hello, I would like to know more about your products!',),
                ),
              );
            },
            child: Text(
              "1. Chat With Me",
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Poppins SemiBold",
              ),
            ),
          ),
        ),
        // Text('1. Chat With Me'),
      ]),
    );
  }
}
