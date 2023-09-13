import 'package:flutter/material.dart';
import 'package:virtual_exhibition_beta/widgets/floatingButton.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({ Key? key }) : super(key: key);

  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
    child: Image.asset("assets/images/vendor.png"),),
      floatingActionButton: FloatingButton(isVendor: true,),
    );
  }
}