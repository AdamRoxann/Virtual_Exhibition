// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AnimatedHotspotButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const AnimatedHotspotButton(
      {Key? key,
      required this.onPressed,
      required this.text})
      : super(key: key);

  @override
  _AnimatedHotspotButtonState createState() => _AnimatedHotspotButtonState();
}

class _AnimatedHotspotButtonState extends State<AnimatedHotspotButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/pointer.gif"),
          SizedBox(height: 5,),
          widget.text != null
              ? Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white),)),
                )
              : Container(),
        ],
      )
    );
  }
}