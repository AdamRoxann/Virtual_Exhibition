import 'package:flutter/material.dart';

class OrderPlaced extends StatefulWidget {
  final String poin, order_id;
  OrderPlaced(this.poin, this.order_id);
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Colors.white,
      // minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(vertical: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFF264C95),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Image.asset("assets/checked.png"),
                height: 140,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // widget.poin.isEmpty
            //     ? Text(
            //         "O POIN",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20.0,
            //             fontFamily: "Poppins Bold"),
            //       )
            //     :
            Text(
              widget.poin + " SGD",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "Poppins Bold"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Order #" + widget.order_id,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "Poppins Bold"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your payment is complete.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "Poppins Regular"),
            ),
            Text(
              "Please check the delivery status at",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "Poppins Regular"),
            ),
            Text(
              "Delivery Page.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "Poppins Regular"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 45.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ElevatedButton(
                    // color: Colors.white,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(5),
                    // ),
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             KeranjangPage()));
                      // save();
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 3);
                    },
                    child: Text(
                      "Continue Shopping",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: "Poppins Bold",
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
