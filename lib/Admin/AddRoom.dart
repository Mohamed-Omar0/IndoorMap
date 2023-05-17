import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Full_Drawer.dart';

class AddRoom extends StatefulWidget {
  @override
  State<AddRoom> createState() => _AddRoomState();
}

List<String> rooms = <String>[];

RoomsList() {
  return rooms;
}

class _AddRoomState extends State<AddRoom> {
  bool isVisible = true;
  TextEditingController floorController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  AddRoom() {
    if (rooms.contains(
        "${floorController.text.toUpperCase()}, ${roomController.text.toUpperCase()}")) {
      Fluttertoast.showToast(
          msg: "The Room is already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      if (floorController.text != "" && roomController.text != "") {
        rooms.add(
            "${floorController.text.toUpperCase()}, ${roomController.text.toUpperCase()}");
        Timer(Duration(milliseconds: 100), () {
          setState(() {
            isVisible = false;
          });
        });
      } else {
        Fluttertoast.showToast(
            msg: "The floor field or the room field can't be empty!",
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
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: Visibility(
            visible: isVisible,
            child: Column(children: [
              Container(
                color: Colors.white,
                width: 300,
                child: TextFormField(
                    controller: floorController,
                    maxLength: 2,
                    decoration: InputDecoration(
                      hintText: "Please enter the floor number",
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                width: 300,
                child: TextFormField(
                    controller: roomController,
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: "Please enter the room number",
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  AddRoom();
                },
                label: Text("Generate"),
              ),
            ]),
          )),
          Visibility(
            visible: !isVisible,
            child: Column(children: [
              ElevatedButton.icon(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(() {
                    isVisible = true;
                    floorController.clear();
                    roomController.clear();
                  });
                },
                label: Text("Add another room"),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.list_alt),
                onPressed: () {
                  setState(() {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("RoomData", (route) => false);
                  });
                },
                label: Text("Display room list"),
              ),
            ]),
          ),
        ]));
  }
}
