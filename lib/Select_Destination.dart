import 'package:flutter/material.dart';
import 'Full_Drawer.dart';
import 'QR_Code_Scan.dart';

class Select_Destination extends StatefulWidget {
  final _Select_DestinationState sdstate = new _Select_DestinationState();
  @override
  State<Select_Destination> createState() => _Select_DestinationState();
}

String? destinationFloor;
String? destinationRoom;
int floorNumber = 0;

class _Select_DestinationState extends State<Select_Destination> {
  String locaion = getLocation()!.code;
  List<String> floors = ["Ground Floor", "First Floor", "Second Floor"];
  List<String> rooms_Ground_Floor = [
    "EX1",
    "EX2",
    "EX3",
    "EX4",
    "G15",
    "G16",
    "G17",
    "G18",
    "G19",
    "G20",
    "G21",
    "G22",
    "G23",
    "G03",
    "Clinic",
    "Staff",
    "Library",
    "Stage",
    "Girls Bathroom",
    "Media",
    "Elevated 1",
    "Elevated 2",
    "stair 1",
    "stair 2",
    "stair 3",
    "stair 4"
  ];
  List<String> rooms_First_Floor = [
    "Students Affairs",
    "stair 1",
    "stair 2",
    "stair 3",
    "stair 4",
    "Elevated 1",
    "Elevated 2",
  ];
  List<String> rooms_Second_Floor = [];
  List<String> floor = [];
  String? floorValue;
  String? roomValue;
  bool isRoomVisible = false;
  bool isbuttonVisible = false;

  setDestinationData() {
    destinationFloor = floorValue;
    destinationRoom = roomValue;
  }

  getDestination() {
    return "$destinationFloor,$destinationRoom";
  }

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
            child: Image(image: AssetImage("lib/assets/img/aou.jpg")),
          ),
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("You are at ${locaion.toUpperCase()}",
                style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("Please Select Your Destination",
                style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 5),
            height: 35,
            color: Colors.blue,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  hint: Text(
                    "Choose Floor",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: floorValue,
                  style: TextStyle(color: Colors.white),
                  items: floors.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  dropdownColor: Colors.blue,
                  onChanged: (String? newValue) {
                    setState(() {
                      floorValue = newValue!;
                      if (floorValue == "Ground Floor") {
                        setState(() {
                          floorNumber = 0;
                        });
                        isRoomVisible = true;
                        roomValue = null;
                        isbuttonVisible = false;
                        floor = rooms_Ground_Floor;
                      } else if (floorValue == "First Floor") {
                        setState(() {
                          floorNumber = 1;
                        });
                        isRoomVisible = true;
                        roomValue = null;
                        isbuttonVisible = false;
                        floor = rooms_First_Floor;
                      } else if (floorValue == "Second Floor") {
                        setState(() {
                          floorNumber = 2;
                        });
                        isRoomVisible = true;
                        roomValue = null;
                        isbuttonVisible = false;
                        floor = rooms_Second_Floor;
                      } else {
                        isRoomVisible = false;
                      }
                    });
                  }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: isRoomVisible,
            child: Container(
              padding: EdgeInsets.only(left: 5),
              height: 35,
              color: Colors.blue,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    value: roomValue,
                    hint: Text(
                      "Choose Room",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    items: floor.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    dropdownColor: Colors.blue,
                    onChanged: (String? newValue) {
                      setState(() {
                        roomValue = newValue!;
                        if (roomValue != null) {
                          isbuttonVisible = true;
                        } else {
                          isbuttonVisible = false;
                        }
                      });
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: isbuttonVisible,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Display_Map", (route) => false);
                setDestinationData();
              },
              child: Text("Display Map"),
            ),
          ),
        ]));
  }
}

getFloorNumber() {
  return floorNumber;
}
