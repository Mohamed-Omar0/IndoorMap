import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Full_Drawer.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

List<String> secQuestion = [
  "What city were you born in",
  "What is your oldest sibling's middle name",
  "What was the first concert you attended",
  "What was the make and model of your first car",
  "In what city or town did your parents meet"
];

class FirstNameFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "First Name Field can\'t be empty" : null;
  }
}

class SecondNameFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Second Name Field can\'t be empty" : null;
  }
}

class EmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Email Field can\'t be empty" : null;
  }
}

class ConfirmEmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Confirm Email Field can\'t be empty" : null;
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

class QuestionAnswerFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Question Answer Field can\'t be empty" : null;
  }
}

class AgeFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Age Field can\'t be empty" : null;
  }
}

class CountryFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Country Field can\'t be empty" : null;
  }
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController secondName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController confirmEmail = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String securityQuestion = "";
  final TextEditingController questionAnswer = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController country = TextEditingController();
  var InitialValue = null;

  SignUp() async {
    if (firstName.text == "" ||
        secondName.text == "" ||
        email.text == "" ||
        confirmEmail.text == "" ||
        password.text == "" ||
        confirmPassword.text == "" ||
        age.text == "" ||
        country.text == "") {
      Fluttertoast.showToast(
          msg: "All fields containing a star cannot be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      String url = "https://10.0.2.2/server/signup.php";
      if (email.text == confirmEmail.text &&
          password.text == confirmPassword.text) {
        var response = await http.post(Uri.parse(url), body: {
          "first_name": firstName.text,
          "second_name": secondName.text,
          "email": email.text,
          "phone_number": phoneNumber.text,
          "password": password.text,
          "security_question": securityQuestion,
          "security_question_answer": questionAnswer.text,
          "age": age.text,
          "country": country.text,
        });
        String data = json.decode(response.body);
        if (data == "success") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("DONE"),
                  content: Text("Do you want to sign in ?"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "SignIn", (route) => false);
                        },
                        child: Text("Sign In")),
                    ElevatedButton(
                        key: Key("Create_Account_Done"),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "Home", (route) => false);
                        },
                        child: Text("Not Now"))
                  ],
                );
              });
        } else {
          Fluttertoast.showToast(
              msg: "The email is registered",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0,
              backgroundColor: Colors.red[400],
              textColor: Colors.white);
        }
      } else {
        Fluttertoast.showToast(
            msg:
                "The email and confirm email or password and confirm password must be the same",
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
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  child: Image(
                      image: AssetImage("lib/assets/img/aou.jpg"),
                      fit: BoxFit.cover),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 200,
                        color: Colors.blue[200],
                        child: TextFormField(
                          key: Key("First_Name_Field"),
                          validator: (value) =>
                              FirstNameFieldValidator.validate(value!),
                          keyboardType: TextInputType.name,
                          controller: firstName,
                          decoration: InputDecoration(
                              icon: Icon(Icons.star),
                              hintText: "First Name",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        width: 200,
                        color: Colors.blue[200],
                        child: TextFormField(
                          key: Key("Second_Name_Field"),
                          validator: (value) =>
                              SecondNameFieldValidator.validate(value!),
                          keyboardType: TextInputType.name,
                          controller: secondName,
                          decoration: InputDecoration(
                              icon: Icon(Icons.star),
                              hintText: "Second Name",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 200,
                        color: Colors.blue[200],
                        child: TextFormField(
                          key: Key("Email_Field"),
                          validator: (value) =>
                              EmailFieldValidator.validate(value!),
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          decoration: InputDecoration(
                              icon: Icon(Icons.star),
                              hintText: "Email Address",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 180,
                      color: Colors.blue[200],
                      child: TextFormField(
                        key: Key("Confirm_Email_Field"),
                        validator: (value) =>
                            ConfirmEmailFieldValidator.validate(value!),
                        keyboardType: TextInputType.emailAddress,
                        controller: confirmEmail,
                        decoration: InputDecoration(
                            icon: Icon(Icons.star),
                            hintText: "Confirm Email Address",
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 200,
                        color: Colors.blue[200],
                        child: TextFormField(
                          key: Key("Password_Field"),
                          validator: (value) =>
                              PasswordFieldValidator.validate(value!),
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                              icon: Icon(Icons.star),
                              hintText: "Password",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        width: 200,
                        color: Colors.blue[200],
                        child: TextFormField(
                          key: Key("Confirm_Password_Field"),
                          validator: (value) =>
                              ConfirmPasswordFieldValidator.validate(value!),
                          obscureText: true,
                          controller: confirmPassword,
                          decoration: InputDecoration(
                              icon: Icon(Icons.star),
                              hintText: "Confirm Password",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 20,
                          color: Colors.blue,
                          child: SizedBox(
                            width: 195,
                            child: DropdownButtonHideUnderline(
                              key: Key("Security_Question_Menu"),
                              child: DropdownButton<String>(
                                  isExpanded: true,
                                  icon: Icon(Icons.question_mark,
                                      color: Colors.white, size: 10),
                                  hint: Text(
                                    "Select Security Question",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  value: InitialValue,
                                  style: TextStyle(color: Colors.white),
                                  items: secQuestion
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  dropdownColor: Colors.blue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      InitialValue = newValue!;
                                      securityQuestion = InitialValue;
                                    });
                                  }),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 2,
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          color: Colors.blue[200],
                          child: TextFormField(
                            key: Key("Security_Question_Field"),
                            validator: (value) =>
                                QuestionAnswerFieldValidator.validate(value!),
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                            controller: questionAnswer,
                            decoration: InputDecoration(
                                icon: Icon(Icons.star),
                                hintText: "Question Answer",
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 180,
                      color: Colors.blue[200],
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNumber,
                        decoration: InputDecoration(
                            hintText: "Phone Number", border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 200,
                        color: Colors.blue[200],
                        child: TextFormField(
                          key: Key("Age_Field"),
                          validator: (value) =>
                              AgeFieldValidator.validate(value!),
                          keyboardType: TextInputType.number,
                          controller: age,
                          decoration: InputDecoration(
                              icon: Icon(Icons.star),
                              hintText: "Age",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        width: 200,
                        color: Colors.blue[200],
                        child: TextFormField(
                          key: Key("Country_Field"),
                          validator: (value) =>
                              CountryFieldValidator.validate(value!),
                          keyboardType: TextInputType.text,
                          controller: country,
                          decoration: InputDecoration(
                              icon: Icon(Icons.star),
                              hintText: "Country",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  key: Key("Create_Account"),
                  onPressed: () {
                    SignUp();
                  },
                  child: Text("Sign Up"),
                ),
              ],
            )));
  }
}
