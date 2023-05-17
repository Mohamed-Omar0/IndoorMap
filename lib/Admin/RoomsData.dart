import 'package:flutter/material.dart';
import '../Full_Drawer.dart';
import 'AddRoom.dart';

List<String> RoomsData = RoomsList();
bool msg = false;

listEmpty() {
  if (RoomsData.isEmpty) {
    msg = true;
  } else {
    msg = false;
  }
}

List<String> RoomsDataList() {
  return RoomsData;
}

class Room_Data extends StatefulWidget {
  @override
  State<Room_Data> createState() => _Room_DataState();
}

class _Room_DataState extends State<Room_Data> {
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
                          RoomsData.clear();
                        });
                      },
                      label: Text("Delete All Rooms ")),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    for (String item in RoomsData)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          color: Colors.white24,
                          child: Column(children: [
                            Text(item, style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    RoomsData.remove(item);
                                  });
                                },
                                icon: Icon(Icons.delete),
                                label: Text("Delete this Room")),
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
                          "No Room available, Please add Room",
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
                              "AddRoom", (route) => false);
                        },
                        icon: Icon(Icons.add_box),
                        label: Text(
                          "Add Room",
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
