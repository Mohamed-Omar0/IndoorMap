import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indoor_map_application/Full_Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:indoor_map_application/Profile.dart';
import 'UserData.dart';
import 'main.dart';

bool isSignIn = sharedPref.getString("email") != null ? true : false;
bool admin = false;
String emailVar = "";
bool secure = true;

void signinState(bool state) {
  isSignIn = state;
}

bool isSignin() {
  return isSignIn;
}

bool isAdmin() {
  if (sharedPref.getString("email") != null) {
    return sharedPref.getString("email")!.toUpperCase() ==
            "admin@admin.com".toUpperCase()
        ? true
        : false;
  } else {
    return false;
  }
}

setEmail(String email) {
  emailVar = email;
}

getEmail() {
  return emailVar;
}

class EmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Email Field can\'t be empty" : null;
  }
}

class PasswordFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Password Field can\'t be empty" : null;
  }
}

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Full_Drawer fDrawer = new Full_Drawer();
  final Profile_Data profile = new Profile_Data();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future SignIn(BuildContext cont) async {
    if (email.text == "" || password.text == "") {
      Fluttertoast.showToast(
        msg: "The email or the password field can't be empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
      );
    } else {
      String url = "https://10.0.2.2/server/login.php";
      var response = await http.post(Uri.parse(url),
          body: {"email": email.text, "password": password.text});
      String data = json.decode(response.body);
      if (data == "success") {
        if (email.text.toUpperCase() == "admin@admin.com".toUpperCase()) {
          admin = true;
        }
        setEmail(email.text.toUpperCase());
        await saveData(email.text);
        fDrawer.fullD.quickInfo();
        if (sharedPref.getString("email") != null) {
          isSignIn = true;
        }
        ;
        sleep(Duration(milliseconds: 60));
        Navigator.of(cont).pushNamedAndRemoveUntil("Home", (route) => false);
      } else {
        Fluttertoast.showToast(
            msg: "The email and password does not exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
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
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 350,
              child: Image(
                  image: AssetImage("lib/assets/img/aou.jpg"),
                  fit: BoxFit.cover),
            ),
            Container(
              width: 200,
              color: Colors.blue[200],
              child: TextFormField(
                key: Key("Email"),
                validator: (value) => EmailFieldValidator.validate(value!),
                keyboardType: TextInputType.emailAddress,
                controller: email,
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
                key: Key("Password"),
                validator: (value) => PasswordFieldValidator.validate(value!),
                controller: password,
                obscureText: secure,
                decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          secure = !secure;
                        });
                      },
                      icon: secure == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: TextButton(
                    key: Key("Forget_Password"),
                    onPressed: () {
                      Navigator.of(context).pushNamed("Forget_Password");
                    },
                    child: Text("Forget Password ?"))),
            ElevatedButton.icon(
              key: Key("SignIn_action"),
              icon: Icon(Icons.login),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await SignIn(context);
                signOutVisible();
                visibleForAdmin();
              },
              label: Text("Sign In"),
            ),
            ElevatedButton.icon(
              key: Key("Create_Account"),
              icon: Icon(Icons.person_add_alt_1),
              onPressed: () {
                Navigator.of(context).pushNamed("CreateAccount");
              },
              label: Text("Create Account"),
            ),
          ]),
        ));
  }
}
