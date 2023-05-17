import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Full_Drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'RoomsData.dart';

class GenerateQR extends StatefulWidget {
  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

List<QrImage> QR_List = <QrImage>[];
QRDataList() {
  return QR_List;
}

class _GenerateQRState extends State<GenerateQR> {
  List<String> rooms = RoomsDataList();
  List<String> created = [];
  bool isVisible = true;
  bool decisionVisible = false;
  var InitialValue;

  CreateQR() {
    if (InitialValue != "") {
      QR_List.add(QrImage(
        backgroundColor: Colors.white,
        data: (InitialValue),
        size: 200,
      ));
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          InitialValue = null;
          isVisible = false;
          decisionVisible = !isVisible;
        });
      });
    }
  }

  Widget NoRoom() {
    if (rooms.isEmpty) {
      isVisible = false;
      decisionVisible = false;
      return AlertDialog(
        title: Text("Please Add Room first"),
        content: Text("Add Room Before Create QR Code"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("AddRoom", (route) => false);
              },
              child: Text("Add Room"))
        ],
      );
    } else {
      return Container();
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
          Container(child: NoRoom()),
          Center(
              child: Visibility(
            visible: isVisible,
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(left: 5),
                height: 35,
                color: Colors.blue,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      hint: Text(
                        "Choose Room",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: InitialValue,
                      style: TextStyle(color: Colors.white),
                      items:
                          rooms.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      dropdownColor: Colors.blue,
                      onChanged: (String? newValue) {
                        setState(() {
                          InitialValue = newValue!;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  if (created.contains(InitialValue)) {
                    Fluttertoast.showToast(
                        msg: "The Room QR exists, Please Choose another room",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 16.0,
                        backgroundColor: Colors.red[400],
                        textColor: Colors.white);
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();
                    CreateQR();
                  }
                  created.add(InitialValue);
                },
                label: Text("Generate"),
              ),
            ]),
          )),
          Visibility(
            visible: decisionVisible,
            child: Column(children: [
              ElevatedButton.icon(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(() {
                    isVisible = true;
                    decisionVisible = false;
                  });
                },
                label: Text("Generate Another QR Code"),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.list_alt),
                onPressed: () {
                  setState(() {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("QR_Data", (route) => false);
                  });
                },
                label: Text("see QR list"),
              ),
            ]),
          ),
        ]));
  }
}
