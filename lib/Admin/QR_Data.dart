import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Full_Drawer.dart';
import 'Genret_QR.dart';

List<QrImage> QR_Dat = QRDataList();
bool msg = false;
listEmpty() {
  if (QR_Dat.isEmpty) {
    msg = true;
  } else {
    msg = false;
  }
}

class QR_Data extends StatefulWidget {
  @override
  State<QR_Data> createState() => _QR_DataState();
}

class _QR_DataState extends State<QR_Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      endDrawer: Full_Drawer(),
      body: Center(
        child: Container(
          child: SizedBox(
            width: 200,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  child: listEmpty(),
                ),
                Visibility(
                  visible: !msg,
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.delete_forever_rounded),
                      onPressed: () {
                        setState(() {
                          QR_Dat.clear();
                        });
                      },
                      label: Text("Delete All QR ")),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    for (QrImage item in QR_Dat)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white24,
                          child: Column(children: [
                            item,
                            ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    QR_Dat.remove(item);
                                  });
                                },
                                icon: Icon(Icons.delete),
                                label: Text("Delete this QR")),
                          ]),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: msg,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.blue[400],
                        child: Text(
                          "No QR code available, Please add QR Code",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 1.7),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "Genret_QR", (route) => false);
                        },
                        icon: Icon(Icons.add_box),
                        label: Text(
                          "Generate QR Code",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
