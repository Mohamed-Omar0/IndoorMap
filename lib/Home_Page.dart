import 'package:flutter/material.dart';
import 'package:indoor_map_application/Full_Drawer.dart';
import 'Sign_In.dart';

bool isSignInVisible = isSignin();

signInVisible() {
  isSignInVisible = isSignin();
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        endDrawer: Full_Drawer(),
        body: Column(children: [
          Container(
            width: double.infinity,
            height: 350,
            child: Image(image: AssetImage("lib/assets/img/aou.jpg")),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.location_pin),
            onPressed: () {
              Navigator.of(context).pushNamed("QR_MAP");
            },
            label: Text("QR CODE MAP"),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.of(context).pushNamed("QR_SCAN");
            },
            label: Text("QR CODE SCAN"),
          ),
          Container(
            child: signInVisible(),
          ),
          Visibility(
            visible: !isSignInVisible,
            child: ElevatedButton.icon(
              key: Key("SignIn_page"),
              icon: Icon(Icons.login),
              onPressed: () {
                Navigator.of(context).pushNamed("SignIn");
              },
              label: Text("Sign In"),
            ),
          ),
        ]));
  }
}
