import 'dart:io';
import 'package:flutter/material.dart';
import 'package:indoor_map_application/Admin/AddRoom.dart';
import 'package:indoor_map_application/Admin/Genret_QR.dart';
import 'package:indoor_map_application/Admin/QR_Data.dart';
import 'package:indoor_map_application/Create_Account.dart';
import 'package:indoor_map_application/Forget_Password.dart';
import 'package:indoor_map_application/Help.dart';
import 'package:indoor_map_application/Home_Page.dart';
import 'package:indoor_map_application/Profile.dart';
import 'package:indoor_map_application/QR_Code_Map.dart';
import 'package:indoor_map_application/QR_Code_Scan.dart';
import 'package:indoor_map_application/Rate.dart';
import 'package:indoor_map_application/Select_Destination.dart';
import 'package:indoor_map_application/Sign_In.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/RoomsData.dart';
import 'Display_Map.dart';

late SharedPreferences sharedPref;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  await Future.delayed(Duration(seconds: 2));
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.3,
                fontFamily: "Caveat",
              ),
        ),
        home: HomePage(),
        routes: {
          "QR_MAP": (context) => QR_Code_Map(),
          "Home": (context) => HomePage(),
          "QR_SCAN": (context) => QR_SCANNER(),
          "Select_Destination": (context) => Select_Destination(),
          "Display_Map": (context) => Display_Map(),
          "SignIn": (context) => SignIn(),
          "CreateAccount": (context) => SignUp(),
          "AddRoom": (context) => AddRoom(),
          "RoomData": (context) => Room_Data(),
          "Genret_QR": (context) => GenerateQR(),
          "QR_Data": (context) => QR_Data(),
          "Profile": (context) => Profile_Data(),
          "Forget_Password": (context) => Forget_Password(),
          "Rating": (context) => Rate(),
          "Help": (context) => Help(),
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
