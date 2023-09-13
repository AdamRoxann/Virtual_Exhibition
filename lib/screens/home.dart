// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

import 'lobby/lobby.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void dispose() {
    // _tapGallery.dispose();
    // _tapCamera.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this, // must add with TickerProviderStateMixin
      duration: const Duration(milliseconds: 750) //Animation Durations
      );
    
    _animation = Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();

    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if(status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width/1.5,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          const SizedBox(height: 30.0,),
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text("Discover", style: TextStyle(color: Color(0xff034EA2), fontWeight: FontWeight.bold, fontSize: 25.0)),
              Text("Discover the different booths"),
            ],
          ),
          SizedBox(height: 30.0,),
          ScaleTransition(
            scale: _animation,
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstLobby()));
                setState(() {
                  _animationController.stop();
                });
              },
              child: Image.asset("assets/images/map.png")))
        ],
      )
    );
  }
}