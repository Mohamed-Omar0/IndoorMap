import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:indoor_map_application/main.dart';
import 'package:http/http.dart' as http;
import 'Full_Drawer.dart';

class Rate extends StatefulWidget {
  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  double rate = 1;
  bool isVisible = true;
  bool rated = false;

  Widget IsLogin() {
    if (sharedPref.getString("email") == null) {
      isVisible = false;
      rated = false;
      return AlertDialog(
        title: Text("Please Sign in first"),
        content: Text("Sign in to be able to rate the app"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("SignIn", (route) => false);
              },
              child: Text("Sign In"))
        ],
      );
    } else {
      return Container();
    }
  }

  RateSubmit() async {
    String url = "https://10.0.2.2/server/Rate.php";
    var response = await http.post(Uri.parse(url),
        body: {"email": sharedPref.getString("email"), "rate": "$rate"});
    var data = json.decode(response.body);
    if (data == "success") {
      sharedPref.setString("rate", "$rate");
    }
  }

  IsRated() {
    if (sharedPref.getString("rate") != "null" &&
        sharedPref.getString("rate") != null) {
      isVisible = false;
      rated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        endDrawer: Full_Drawer(),
        body: Stack(
          children: [
            Container(
              color: Colors.black,
            ),
            Container(
              child: IsLogin(),
            ),
            Container(
              child: IsRated(),
            ),
            Visibility(
              visible: isVisible,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Rating: ${rate.toInt()}",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        child: SmoothStarRating(
                            allowHalfRating: false,
                            onRatingChanged: (v) {
                              setState(() {
                                if (v >= 1) {
                                  rate = v;
                                }
                              });
                            },
                            starCount: 5,
                            rating: rate,
                            size: 40.0,
                            color: Colors.yellow,
                            borderColor: Colors.white24,
                            spacing: 4.0)),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            RateSubmit();
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "Home", (route) => false);
                        },
                        icon: Icon(Icons.send, size: 20),
                        label: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: rated,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Thanks For Rating The App",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Positioned(
                left: MediaQuery.of(context).size.width / 3.3,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Rate The App",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
