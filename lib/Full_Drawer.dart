import 'package:flutter/material.dart';
import 'package:indoor_map_application/main.dart';
import 'Profile.dart';
import 'Sign_In.dart';

bool isSignOutVisible = isSignin();
bool admin = isAdmin();

visibleForAdmin() {
  admin = isAdmin();
}

signOutVisible() {
  isSignOutVisible = isSignin();
}

class Full_Drawer extends StatefulWidget {
  final _Full_DrawerState fullD = new _Full_DrawerState();
  @override
  State<Full_Drawer> createState() => _Full_DrawerState();
}

String name = sharedPref.getString("first_name") != null
    ? sharedPref.getString("first_name") as String
    : "user";
String email = sharedPref.getString("email") != null
    ? sharedPref.getString("email") as String
    : "";

class _Full_DrawerState extends State<Full_Drawer> {
  quickInfo() {
    if (sharedPref.getString("email") != null) {
      name = sharedPref.getString("first_name") as String;
      email = sharedPref.getString("email") as String;
    }
  }

  logout() {
    name = "user";
    email = "";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo.shade900,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Hello, $name"),
            accountEmail: Text(email),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/assets/img/neon.gif"),
                    fit: BoxFit.fill)),
          ),
          ListTile(
            title: Text(
              "Home Page",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.home, color: Colors.white),
            onTap: () {
              Navigator.of(context).pushNamed("Home");
            },
          ),
          ListTile(
            key: Key("Profile"),
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.person, color: Colors.white),
            onTap: () {
              if (!isSignin()) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("SignIn", (route) => false);
              } else {
                dataVisible();
                Navigator.of(context).pushNamed("Profile");
              }
            },
          ),
          ListTile(
            title: Text("Help", style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.help, color: Colors.white),
            onTap: () {
              Navigator.of(context).pushNamed("Help");
            },
          ),
          ListTile(
            title: Text("Rate", style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.rate_review, color: Colors.white),
            onTap: () {
              Navigator.of(context).pushNamed("Rating");
            },
          ),
          Visibility(
            visible: isSignOutVisible,
            child: ListTile(
              title: Text("Sign Out", style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.logout, color: Colors.white),
              onTap: () {
                admin = false;
                signinState(false);
                signOutVisible();
                logout();
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Home", (route) => false);
              },
            ),
          ),
          Visibility(
            visible: admin,
            child: ListTile(
              title: Text("Add Room", style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.door_sliding, color: Colors.white),
              onTap: () {
                visibleForAdmin();
                Navigator.of(context).pushNamed("AddRoom");
              },
            ),
          ),
          Visibility(
            visible: admin,
            child: ListTile(
              title: Text("All Rooms", style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.list_alt, color: Colors.white),
              onTap: () {
                visibleForAdmin();
                Navigator.of(context).pushNamed("RoomData");
              },
            ),
          ),
          Visibility(
            visible: admin,
            child: ListTile(
              title: Text("Genret QR", style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.qr_code_2, color: Colors.white),
              onTap: () {
                visibleForAdmin();
                Navigator.of(context).pushNamed("Genret_QR");
              },
            ),
          ),
          Visibility(
            visible: admin,
            child: ListTile(
              title: Text("All QR", style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.list_alt, color: Colors.white),
              onTap: () {
                visibleForAdmin();
                Navigator.of(context).pushNamed("QR_Data");
              },
            ),
          ),
        ],
      ),
    );
  }
}
