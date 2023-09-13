// // ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison, file_names

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayer extends StatefulWidget {
//   final double? width;
//   final double? height;
//   final VoidCallback? onPressed;
//   final String? image;
//   final double? opacity;
//   final String videoUrl;

//   const VideoPlayer({ Key? key, this.width,
//       this.height,
//       this.onPressed, this.image, this.opacity, required this.videoUrl}) : super(key: key);
//   @override
//   _VideoPlayerState createState() => _VideoPlayerState();
// }

// class _VideoPlayerState extends State<VideoPlayer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//         widget.videoUrl)
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: widget.onPressed,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           widget.opacity == null ?
//           Opacity(
//             opacity: 0.5,
//             child: Container(
//                 decoration:
//                     BoxDecoration(border: Border.all(width: 3, color: Colors.blueAccent)),
//                 // color: Colors.white,
//                 height: widget.height,
//                 width: widget.width,
//                 child: widget.image == null ?
//                 Container(): Container(
//                 child: Image.network(widget.image ?? ''),
//                 )),
//           ) :
//           Opacity(
//             opacity: widget.opacity ?? 0,
//             child: Container(
//                 decoration:
//                     BoxDecoration(border: Border.all(width: 3, color: Colors.blueAccent)),
//                 // color: Colors.white,
//                 height: widget.height,
//                 width: widget.width,
//                 child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : Container(),
//                 // child: widget.image == null ?
//                 // Container() 
//                 // : 
//                 // Container(
//                 // child: Image.network(widget.image ?? '', width: widget.width,),
//                 ),
//           )
//         ],
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
