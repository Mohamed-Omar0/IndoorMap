import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

saveData(String email) async {
  String url = "https://10.0.2.2/server/getData.php";
  var response = await http.post(Uri.parse(url), body: {"email": email});
  var data = json.decode(response.body);
  if (data == "error" || data == false) {
  } else {
    sharedPref.setString("first_name", data["first_name"]);
    sharedPref.setString("second_name", data["second_name"]);
    sharedPref.setString("email", data["email"]);
    sharedPref.setString("country", data["country"]);
    if (data["phone_number"] == null) {
      sharedPref.setString("phone_number", "");
    } else {
      sharedPref.setString("phone_number", data["phone_number"].toString());
    }
    sharedPref.setString("age", data["age"].toString());
    sharedPref.setString("rate", data["rating"].toString());
  }
  ;
}
