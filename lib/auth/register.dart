import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tucartpoin/in_app/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_exhibition_beta/auth/login.dart';
import 'package:virtual_exhibition_beta/config/url.dart';
import 'package:virtual_exhibition_beta/screens/home.dart';
// import 'package:quantum/in_app/explore/filter.dart';

class RegisterPage extends StatefulWidget {
   final bool value;
   RegisterPage(this.value);
  // RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum LoginStatus { notSignIn, signIn }

class _RegisterPageState extends State<RegisterPage> {
  LoginStatus loginStatus = LoginStatus.notSignIn;
  String email = "", password = "", cpassword = "", name = "";
  final key = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isObscure = true;
  bool _isObscureConfirm = true;

  check() {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      register();
    }
  }

  Widget _loading(BuildContext context) {
    return new Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
          title: Text("Please Wait..."),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
                // height: 50,
                // width: 50,
                child: Center(child: CircularProgressIndicator())),
          ),
        ),
      ),
    );
  }

  register() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => _loading(context),
    );
    final response = await http.post(Uri.parse(AuthUrl.register), body: {
      "name": name,
      "email": email,
      "password": password,
      "cpassword": cpassword,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String idAPI = data['id'];
    String tokenAPI = data['api_key'];

    if (value == 1) {
      Navigator.pop(context);
      setState(() {
        loginStatus = LoginStatus.signIn;
        savePref(value, idAPI, emailAPI, nameAPI, tokenAPI);
      });
      print(message);
      print(data);
      // _showToast(message);
    } else {
      Navigator.pop(context);
      print("fail");
      print(message);
      _showToast(message);
    }
  }

  _showToast(String toast) {
    final snackbar = SnackBar(
      content: new Text(toast),
      backgroundColor: Colors.red,
    );
    // scaffoldkey.currentState!.showSnackBar(snackbar);
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  savePref(
      int value, String id, String email, String name, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("id", id);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("token", token);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  // String validateEmail(String value) {
  //   Pattern pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = RegExp(pattern);
  //   if (!regex.hasMatch(value))
  //     return 'Enter Valid Email';
  //   else
  //     return null;
  // }

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.blue[900],
      primary: Colors.blue[900],
      // minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    switch (loginStatus) {
      case LoginStatus.notSignIn:
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        return WillPopScope(
          onWillPop: () => Future.value(widget.value),
          child: ScaffoldMessenger(
            key: scaffoldMessengerKey,
            child: Scaffold(
              key: scaffoldkey,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottom),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            // Image(
                            //   image: AssetImage(
                            //     'assets/images/blob.png',
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 88.0),
                              child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.5,
                                    child: Image.asset("assets/images/logo.png"),
                                  ),
                                  SizedBox(height: 20,),
                                  Text("Register as Visitor.", style: TextStyle(color: Color(0xFF264C95), fontSize: 35.0),),
                                ],
                              ),
                          ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 30, horizontal: 20),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         'Halo,',
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 20,
                            //           fontFamily: 'Poppins Medium',
                            //         ),
                            //       ),
                            //       Text(
                            //         'Masuk \ndengan Quantum!',
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 25,
                            //           fontFamily: 'Poppins Medium',
                            //           height: 1.2,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        Form(
                          key: key,
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              children: [
                                SizedBox(height: 40),
                                TextFormField(
                                  // validator: validateEmail,
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Name can't be empty";
                                    }
                                  },
                                  onSaved: (e) => name = e!,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                      color: Color(0xFFBDC3C7),
                                      fontSize: 15,
                                      fontFamily: 'Poppins Regular',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF7F8C8D),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  // validator: validateEmail,
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Email Can't be Empty";
                                    }
                                  },
                                  onSaved: (e) => email = e!,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      color: Color(0xFFBDC3C7),
                                      fontSize: 15,
                                      fontFamily: 'Poppins Regular',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF7F8C8D),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Password Can't be Empty";
                                  //   }
                                  // },
                                  controller: _pass,
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return "Password Can't be Empty";
                                    return null;
                                  },
                                  onSaved: (e) => password = e!,
                                  obscureText: _isObscure,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color(0xFF7F8C8D),
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            _isObscure = !_isObscure;
                                          },
                                        );
                                      },
                                    ),
                                    labelStyle: TextStyle(
                                      color: Color(0xFFBDC3C7),
                                      fontSize: 15,
                                      fontFamily: 'Poppins Regular',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF7F8C8D),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Confirm Password Can't be Empty";
                                  //   }
                                  // },
                                  controller: _confirmPass,
                                  validator: (val) {
                                    if (val!.isEmpty) return 'Empty';
                                    if (val != _pass.text)
                                      return 'Password Not Match';
                                    return null;
                                  },
                                  onSaved: (e) => cpassword = e!,
                                  obscureText: _isObscureConfirm,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscureConfirm
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color(0xFF7F8C8D),
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            _isObscureConfirm = !_isObscureConfirm;
                                          },
                                        );
                                      },
                                    ),
                                    labelStyle: TextStyle(
                                      color: Color(0xFFBDC3C7),
                                      fontSize: 15,
                                      fontFamily: 'Poppins Regular',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF7F8C8D),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Poppins Regular',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  // ignore: deprecated_member_use
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => Navigation(),
                                      //   ),
                                      // );
                                      check();
                                    },
                                    style: flatButtonStyle,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    // color: Colors.blue[900],
                                    child: Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                        maxWidth: double.infinity,
                                        minHeight: 50,
                                      ),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Poppins Medium',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomePage();
        break;
    }
  }
}
