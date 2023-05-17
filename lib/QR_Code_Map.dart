import 'package:flutter/material.dart';
import 'Full_Drawer.dart';

class QR_Code_Map extends StatefulWidget {
  @override
  State<QR_Code_Map> createState() {
    return _QR_Code_MapState();
  }
}

class _QR_Code_MapState extends State<QR_Code_Map> {
  var floor = ["Ground Floor", "First Floor", "Second Floor"];
  var InitialValue = null;
  bool isVisible = false;
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
            padding: EdgeInsets.only(left: 5),
            height: 35,
            color: Colors.blue,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  hint: Text(
                    "Choose a Floor",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: InitialValue,
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
                      InitialValue = newValue!;
                      if (InitialValue == "Ground Floor") {
                        isVisible = true;
                      } else {
                        isVisible = false;
                      }
                      ;
                    });
                  }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: isVisible,
            child: InteractiveViewer(
              child: Container(
                width: double.infinity,
                color: Colors.black,
                child: Image(
                  image: AssetImage("lib/assets/img/QR_Map_Floor1.png"),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 250,
                ),
              ),
            ),
          )
        ]));
  }
}
