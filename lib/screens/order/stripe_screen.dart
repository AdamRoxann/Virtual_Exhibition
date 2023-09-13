import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/screens/order/orderPlaced.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeScreen extends StatefulWidget {
  final String user_id;
  const StripeScreen({Key? key, required this.user_id}) : super(key: key);

  @override
  _StripeScreenState createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  late WebViewController _webViewController;

  void getData() {
    _webViewController
        .evaluateJavascript("document.body.innerText")
        .then((data) {
      var decodedJSON = jsonDecode(data);
      // Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      print(decodedJSON);
      //print(data.toString());
      if (decodedJSON["result"] == false) {
        // Toast.show(responseJSON["message"], context,
        //     duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        print('payment failed');
        Navigator.pop(context);
      } else if (decodedJSON["result"] == true) {
        print('payment  success');
        // Toast.show(responseJSON["message"], context,
        //     duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        // if (widget.payment_type == "cart_payment") {
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //     return OrderList(from_checkout: true);
        //   }));
        // } else if (widget.payment_type == "wallet_payment") {
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //     return Wallet(from_recharge: true);
        //   }));
        // }
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => OrderPlaced(
                decodedJSON["total_amount"].toString(),
                decodedJSON["order_id"].toString()),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // String initial_url = 'http://google.com';
    String initial_url = OrderUrl.checkout + "?user_id=${widget.user_id}";
    print(initial_url);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
            debuggingEnabled: false,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _webViewController = controller;
              _webViewController.loadUrl(initial_url);
            },
            onWebResourceError: (error) {
              print(error.description);
            },
            onPageFinished: (page) {
              //print(page.toString());

              if (page.contains("/stripe/success")) {
                print('success');
                getData();
              } else if (page.contains("/stripe/cancel")) {
                // ToastComponent.showDialog(
                //     AppLocalizations.of(context).common_payment_cancelled,
                //     context,
                //     gravity: Toast.CENTER,
                //     duration: Toast.LENGTH_LONG);
                Navigator.of(context).pop();
                return;
              }
            },
          ),
        ),
      ),
    );
  }
}
