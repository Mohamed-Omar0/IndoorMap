import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'Full_Drawer.dart';

class Forget_Password extends StatefulWidget {
  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class EmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Email Field can\'t be empty" : null;
  }
}

class QuestionAnswerFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Question Answer Field can\'t be empty" : null;
  }
}

class PasswordFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Password Field can\'t be empty" : null;
  }
}

class ConfirmPasswordFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Confirm Password Field can\'t be empty" : null;
  }
}

class _Forget_PasswordState extends State<Forget_Password> {
  final TextEditingController email = TextEditingController();
  final TextEditingController questionAnswer = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool emailVisible = true;
  bool questionVisible = false;
  bool resetVisivle = false;
  String security_Question = "";
  String security_Question_Answer = "";

  securityQuestion() async {
    if (email.text == "") {
      Fluttertoast.showToast(
          msg: "The email field can't be empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      String url = "https://10.0.2.2/server/security_Question.php";
      var response =
          await http.post(Uri.parse(url), body: {"email": email.text});
      var data = json.decode(response.body);
      if (data != false) {
        setState(() {
          security_Question = data["security_question"];
          security_Question_Answer = data["security_question_answer"];
          emailVisible = false;
          questionVisible = true;
        });
      } else {
        Fluttertoast.showToast(
            msg: "The email does not exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
  }

  resetPass() async {
    String url = "https://10.0.2.2/server/forget_Password.php";
    var response = await http.post(Uri.parse(url),
        body: {"email": email.text, "password": password.text});
    String data = json.decode(response.body);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("DONE"),
              content: Text("Password Changed successfully"),
              actions: [
                ElevatedButton(
                    key: Key("Update_Password_Done"),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("Home", (route) => false);
                    },
                    child: Text("Close"))
              ],
            );
          });
    } else {
      Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
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
              Visibility(
                visible: emailVisible,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Enter Your E-mail",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: emailVisible,
                child: Container(
                  width: 200,
                  color: Colors.blue[200],
                  child: TextFormField(
                    key: Key("Forget_Password_Email"),
                    validator: (value) => EmailFieldValidator.validate(value!),
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "Your E-mail",
                        icon: Icon(Icons.email),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: emailVisible,
                child: ElevatedButton.icon(
                  key: Key("Reset_button"),
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    setState(() {
                      securityQuestion();
                    });
                  },
                  label: Text("Reset Password"),
                ),
              ),
              Visibility(
                visible: questionVisible,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Please answer the next question",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: questionVisible,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("$security_Question ?",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: questionVisible,
                child: Container(
                  width: 200,
                  color: Colors.blue[200],
                  child: TextFormField(
                    key: Key("Question_Answer_Field"),
                    validator: (value) =>
                        QuestionAnswerFieldValidator.validate(value!),
                    controller: questionAnswer,
                    decoration: InputDecoration(
                        icon: Icon(Icons.star),
                        hintText: "Question Answer",
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: questionVisible,
                child: ElevatedButton.icon(
                  key: Key("submit_Button"),
                  icon: Icon(Icons.done),
                  onPressed: () {
                    if (questionAnswer.text == "") {
                      Fluttertoast.showToast(
                          msg:
                              "Please answer the question to reset your password",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0,
                          backgroundColor: Colors.red[400],
                          textColor: Colors.white);
                    } else {
                      if (questionAnswer.text.toUpperCase() !=
                          security_Question_Answer.toUpperCase()) {
                        Fluttertoast.showToast(
                            msg:
                                "The answer is incorrect, please re-enter the answer",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0,
                            backgroundColor: Colors.red[400],
                            textColor: Colors.white);
                      } else {
                        setState(() {
                          questionVisible = false;
                          resetVisivle = true;
                        });
                      }
                    }
                  },
                  label: Text("Submit"),
                ),
              ),
              Visibility(
                visible: resetVisivle,
                child: Container(
                  width: 200,
                  color: Colors.blue[200],
                  child: TextFormField(
                    key: Key("New_Password_Field"),
                    validator: (value) =>
                        PasswordFieldValidator.validate(value!),
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        icon: Icon(Icons.star),
                        hintText: "New Password",
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: resetVisivle,
                child: Container(
                  width: 200,
                  color: Colors.blue[200],
                  child: TextFormField(
                    key: Key("Confirm_New_Password_Field"),
                    validator: (value) =>
                        ConfirmPasswordFieldValidator.validate(value!),
                    obscureText: true,
                    controller: confirmPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.star),
                        hintText: "Confirm New Password",
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: resetVisivle,
                child: ElevatedButton.icon(
                  key: Key("Update_Password_button"),
                  icon: Icon(Icons.done),
                  onPressed: () {
                    if (password.text == "" || confirmPassword.text == "") {
                      Fluttertoast.showToast(
                          msg:
                              "Password or Confirm Password fields can't be empty",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0,
                          backgroundColor: Colors.red[400],
                          textColor: Colors.white);
                    } else if (password.text != confirmPassword.text) {
                      Fluttertoast.showToast(
                          msg: "Password and Confirm Password must be the same",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0,
                          backgroundColor: Colors.red[400],
                          textColor: Colors.white);
                    } else {
                      setState(() {
                        resetPass();
                      });
                    }
                  },
                  label: Text("Update Password"),
                ),
              ),
            ])));
  }
}
