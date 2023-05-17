import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Full_Drawer.dart';
import 'Sign_In.dart';
import 'main.dart';

bool isVisible = true;

dataVisible() {
  isVisible = true;
}

class EmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Email Field can\'t be empty" : null;
  }
}

class PhoneNumberFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Phone Number Field can\'t be empty" : null;
  }
}

class Profile_Data extends StatefulWidget {
  final _Profile_DataState profileState = new _Profile_DataState();

  @override
  State<Profile_Data> createState() => _Profile_DataState();
}

class _Profile_DataState extends State<Profile_Data> {
  final Full_Drawer fDrawer = new Full_Drawer();
  final TextEditingController newEmail = TextEditingController();
  final TextEditingController newPhone = TextEditingController();

  updateData() async {
    if (newEmail.text == "" && newPhone.text == "") {
      Fluttertoast.showToast(
          msg: "The email and Phone Number fields can't be empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      String url = "https://10.0.2.2/server/updateData.php";
      var response = await http.post(Uri.parse(url), body: {
        "oldemail": sharedPref.getString("email") as String,
        "newemail": newEmail.text,
        "phonenum": newPhone.text,
      });
      String data = json.decode(response.body);
      if (data == "success") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("DONE"),
                content: Text("Data Changed successfully"),
                actions: [
                  ElevatedButton(
                      key: Key("Close_Button"),
                      onPressed: () {
                        if (newEmail.text != "") {
                          setState(() {
                            sharedPref.setString("email", newEmail.text);
                            setEmail(email);
                            fDrawer.fullD.quickInfo();
                          });
                        }
                        if (newPhone.text != "") {
                          setState(() {
                            sharedPref.setString("phone_number", newPhone.text);
                          });
                        }

                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("Home", (route) => false);
                      },
                      child: Text("Close"))
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Failed"),
                content: Text("An error occurred !"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("Home", (route) => false);
                      },
                      child: Text("Close"))
                ],
              );
            });
      }
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
      body: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.all(10),
          child: Stack(children: [
            Column(
              children: [
                Text(
                  "Profile Details",
                  style: TextStyle(color: Colors.blue[400], fontSize: 20),
                ),
                Container(
                  child: Image(image: AssetImage("lib/assets/img/Profile.jpg")),
                ),
                Container(
                  color: Colors.black,
                  child: Column(children: [
                    Visibility(
                      visible: isVisible,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "First Name: ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text("${sharedPref.getString("first_name")}",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: "Serif",
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Second Name: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text("${sharedPref.getString("second_name")}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Serif",
                                )),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Email Address: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text("${sharedPref.getString("email")}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Serif",
                                )),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Phone Number: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text("${sharedPref.getString("phone_number")}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Serif",
                                )),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Age: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text("${sharedPref.getString("age")}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Serif",
                                )),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Country: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text("${sharedPref.getString("country")}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Serif",
                                )),
                          ]),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                          ),
                          ElevatedButton.icon(
                            key: Key("Edit_Profile_Information"),
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                isVisible = false;
                              });
                            },
                            label: Text("Edit Phone Number or Email Address"),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !isVisible,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Text(
                            "Change Email or Phone Number",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            color: Colors.blue[200],
                            child: TextFormField(
                              validator: (value) =>
                                  EmailFieldValidator.validate(value!),
                              keyboardType: TextInputType.emailAddress,
                              controller: newEmail,
                              decoration: InputDecoration(
                                  hintText: "Email Address",
                                  icon: Icon(Icons.person),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            color: Colors.blue[200],
                            child: TextFormField(
                              key: Key("PhoneNumber"),
                              validator: (value) =>
                                  PhoneNumberFieldValidator.validate(value!),
                              keyboardType: TextInputType.phone,
                              controller: newPhone,
                              decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  icon: Icon(Icons.lock),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                            key: Key("Update_Data"),
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                updateData();
                              });
                            },
                            label: Text("Change Data"),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            )
          ])),
    );
  }
}
