// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison, file_names

import 'package:flutter/material.dart';

class SeeProduct extends StatefulWidget {
  final double width;
  final double height;
  final VoidCallback onPressed;
  final String? image;
  final double? opacity;

  const SeeProduct({ Key? key, required this.width,
      required this.height,
      required this.onPressed, this.image, this.opacity}) : super(key: key);
  @override
  _SeeProductState createState() => _SeeProductState();
}

class _SeeProductState extends State<SeeProduct> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.opacity == null ?
          Opacity(
            opacity: 0.5,
            child: Container(
                // decoration:
                //     BoxDecoration(border: Border.all(width: 3, color: Colors.blueAccent)),
                // color: Colors.white,
                height: widget.height,
                width: widget.width,
                child: widget.image == null ?
                Container(): Container(
                child: Image.network(widget.image ?? ''),
                )),
          ) :
          Opacity(
            opacity: widget.opacity ?? 0,
            child: Container(
                // decoration:
                //     BoxDecoration(border: Border.all(width: 3, color: Colors.blueAccent)),
                // color: Colors.white,
                height: widget.height,
                width: widget.width,
                child: widget.image == null ?
                Container(): Container(
                child: Image.network(widget.image ?? '', width: widget.width,),
                )),
          )
        ],
      ),
    );
  }
}