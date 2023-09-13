import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'package:virtual_exhibition_beta/auth/login.dart';
import 'package:virtual_exhibition_beta/profile/address.dart';
import 'package:virtual_exhibition_beta/profile/history.dart';
import 'package:virtual_exhibition_beta/profile/shipping.dart';
import 'package:virtual_exhibition_beta/profile/timeline.dart';
// import 'package:quantum/in_app/explore/search.dart';

class ProfilePage extends StatefulWidget {
  final bool? isVendor;
  ProfilePage({Key? key, this.isVendor = false}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '', email = '';
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name")!;
      email = preferences.getString("email")!;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  LoginStatus loginStatus = LoginStatus.notSignIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Text("Profile",
            style: TextStyle(
                fontFamily: "Poppins SemiBold",
                fontSize: 16,
                color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Color(0xFFECF0F1),
      body: SafeArea(
        child: 
        widget.isVendor == true ?
        Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Color(0xFF264C95),
                  height: 200,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: Align(
                //     alignment: Alignment.topCenter,
                //     child: Text(
                //       'Profile',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontFamily: 'Poppins Medium',
                //         fontSize: 20,
                //       ),
                //     ),
                //   ),
                // ),
                // Profile Picture
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CircleAvatar(
                      //   minRadius: 30,
                      //   maxRadius: 30,
                      //   backgroundImage:
                      //       AssetImage('assets/images/profile1.jpg'),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins Medium',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins Regular',
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // ButtonTheme(
            //   minWidth: double.infinity,
            //   height: 70,
            //   child: MaterialButton(
            //     onPressed: () {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => HistoryPage(),
            //         ),
            //       );
            //     },
            //     color: Colors.white,
            //     elevation: 0,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           'Order History',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontFamily: 'Poppins Medium',
            //             fontSize: 16,
            //           ),
            //         ),
            //         Icon(Icons.arrow_forward_ios),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 2),
            //   child: ButtonTheme(
            //     minWidth: double.infinity,
            //     height: 70,
            //     child: MaterialButton(
            //       onPressed: () {
            //         // Navigator.pushReplacement(
            //         //   context,
            //         //   MaterialPageRoute(
            //         //     builder: (context) => TrackingPage(),
            //         //   ),
            //         // );
            //       },
            //       color: Colors.white,
            //       elevation: 0,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Shipping Information',
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontFamily: 'Poppins Medium',
            //               fontSize: 16,
            //             ),
            //           ),
            //           Icon(Icons.arrow_forward_ios),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 2),
            //   child: ButtonTheme(
            //     minWidth: double.infinity,
            //     height: 70,
            //     child: MaterialButton(
            //       onPressed: () {
            //         Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => AddressPage(),
            //           ),
            //         );
            //       },
            //       color: Colors.white,
            //       elevation: 0,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'My Address',
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontFamily: 'Poppins Medium',
            //               fontSize: 16,
            //             ),
            //           ),
            //           Icon(Icons.arrow_forward_ios),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 70,
                child: MaterialButton(
                  onPressed: () async {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SearchClick(),
                    //   ),
                    // );
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    setState(() {
                      preferences.setInt('value', 0);
                      preferences.commit();
                      loginStatus = LoginStatus.notSignIn;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginPage(false)));
                  },
                  color: Colors.white,
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Poppins Medium',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ) : 
        Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Color(0xFF264C95),
                  height: 200,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: Align(
                //     alignment: Alignment.topCenter,
                //     child: Text(
                //       'Profile',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontFamily: 'Poppins Medium',
                //         fontSize: 20,
                //       ),
                //     ),
                //   ),
                // ),
                // Profile Picture
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CircleAvatar(
                      //   minRadius: 30,
                      //   maxRadius: 30,
                      //   backgroundImage:
                      //       AssetImage('assets/images/profile1.jpg'),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins Medium',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins Regular',
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            ButtonTheme(
              minWidth: double.infinity,
              height: 70,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(),
                    ),
                  );
                },
                color: Colors.white,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order History',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins Medium',
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 70,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackageDeliveryTrackingPage(),
                        // builder: (context) => TrackingPage(),
                      ),
                    );
                  },
                  color: Colors.white,
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping Information',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins Medium',
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 70,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressPage(),
                      ),
                    );
                  },
                  color: Colors.white,
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins Medium',
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 70,
                child: MaterialButton(
                  onPressed: () async {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SearchClick(),
                    //   ),
                    // );
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    setState(() {
                      preferences.setInt('value', 0);
                      preferences.commit();
                      loginStatus = LoginStatus.notSignIn;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginPage(false)));
                  },
                  color: Colors.white,
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Poppins Medium',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
