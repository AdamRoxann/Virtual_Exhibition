// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RegularHotspotButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  const RegularHotspotButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.text})
      : super(key: key);

  @override
  _RegularHotspotButtonState createState() => _RegularHotspotButtonState();
}

class _RegularHotspotButtonState extends State<RegularHotspotButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor: MaterialStateProperty.all(Colors.black38),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Icon(widget.icon),
        onPressed: widget.onPressed,
      ),
      widget.text != null
          ? Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white),)),
            )
          : Container(),
    ],
    );
  }
}