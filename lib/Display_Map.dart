//import required packages
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indoor_map_application/QR_Code_Scan.dart';
import 'package:indoor_map_application/Select_Destination.dart';
import 'Full_Drawer.dart';
import 'package:a_star_algorithm/a_star_algorithm.dart';
import 'package:csv/csv.dart';
import 'Select_Destination.dart';

//Display_Map class which extends StatefulWidget
class Display_Map extends StatefulWidget {
  @override
  State<Display_Map> createState() => _Display_MapState();
}

//_Display_MapState which extends State<Display_Map>
class _Display_MapState extends State<Display_Map> {
  //Create all list and variable needed
  Map<String, Offset> groundFloorRoomsPoints = {
    "EX1".toUpperCase(): Offset(27, 10),
    "Girls Bathroom".toUpperCase(): Offset(22.3, 9),
    "stair 2".toUpperCase(): Offset(19, 6),
    "Stage".toUpperCase(): Offset(17.15, 19),
    "G03".toUpperCase(): Offset(21.2, 10.5),
    "E1".toUpperCase(): Offset(21, 20),
    "EX4".toUpperCase(): Offset(20, 27),
    "E2".toUpperCase(): Offset(21, 32),
    "Media".toUpperCase(): Offset(20, 44),
    "stair 3".toUpperCase(): Offset(19, 46),
    "Library".toUpperCase(): Offset(17.17, 35),
    "EX3".toUpperCase(): Offset(9, 3),
    "stair 1".toUpperCase(): Offset(8, 4),
    "G15".toUpperCase(): Offset(7, 8),
    "G16".toUpperCase(): Offset(8, 10),
    "G17".toUpperCase(): Offset(7, 17),
    "G18".toUpperCase(): Offset(7, 18),
    "G19".toUpperCase(): Offset(7, 22.5),
    "G20".toUpperCase(): Offset(7, 27),
    "G21".toUpperCase(): Offset(7, 32),
    "G22".toUpperCase(): Offset(7, 33),
    "G23".toUpperCase(): Offset(7, 37.3),
    "Clinic".toUpperCase(): Offset(8, 42),
    "Staff".toUpperCase(): Offset(8, 48.5),
    "stair 4".toUpperCase(): Offset(7, 51.5),
    "EX2".toUpperCase(): Offset(9, 50.5),
    "Elevated 1".toUpperCase(): Offset(21, 21),
    "Elevated 2".toUpperCase(): Offset(21, 33),
  };
  Map<String, Offset> firstFloorRoomsPoints = {
    "Students Affairs".toUpperCase(): Offset(24, 21),
    "stair 1".toUpperCase(): Offset(24, 54),
    "stair 2".toUpperCase(): Offset(17, 52),
    "stair 3".toUpperCase(): Offset(17, 6),
    "stair 4".toUpperCase(): Offset(24, 2),
    "Elevated 1".toUpperCase(): Offset(16, 34),
    "Elevated 2".toUpperCase(): Offset(16, 21),
  };
  Map<String, Offset> startSelectedFloor = {};
  Map<String, Offset> endSelectedFloor = {};
  List<ui.Image> image = [];
  bool isImageloaded = false;
  late Iterable<Offset> result;
  bool isPathReady = false;
  GlobalKey _myCanvasKey = GlobalKey();
  var file;
  static List<Offset> offsetList = [];
  double listRow = 0;
  double listCol = 0;
  final Select_Destination sd = new Select_Destination();
  late Offset startPoint;
  late Offset endPoint;
  late String start;
  late String end;
  bool samePlace = false;

// first method to call
  @override
  void initState() {
    super.initState();
    init();
  }

// load floors images
  Future<Null> init() async {
    for (int i = 0; i < 3; i++) {
      final ByteData data =
          await rootBundle.load('lib/assets/img/Floor${i + 1}.png');
      image.add(await loadImage(Uint8List.view(data.buffer)));
    }
    await locationInfo();
  }

// get user location information and decide which csv file to load
  locationInfo() async {
    start = getLocation()!.code;
    end = sd.sdstate.getDestination();
    List<String> currentLocation_split = start.split(',');
    List<String> finalDestination_split = end.split(',');
    if (currentLocation_split.first.toUpperCase() == "F1".toUpperCase()) {
      file = await rootBundle.loadString("lib/assets/floors/ground_floor.csv");
      startSelectedFloor.addAll(groundFloorRoomsPoints);
    }
    if (currentLocation_split.first.toUpperCase() == "F2".toUpperCase()) {
      file = await rootBundle.loadString("lib/assets/floors/first_floor.csv");
      startSelectedFloor.addAll(firstFloorRoomsPoints);
    }
    if (finalDestination_split.first.toUpperCase() ==
        "Ground Floor".toUpperCase()) {
      endSelectedFloor.addAll(groundFloorRoomsPoints);
    }
    if (finalDestination_split.first.toUpperCase() ==
        "First Floor".toUpperCase()) {
      endSelectedFloor.addAll(firstFloorRoomsPoints);
    }
    if (currentLocation_split.first.toUpperCase() !=
        (finalDestination_split.first.toUpperCase() ==
                "Ground Floor".toUpperCase()
            ? "F1".toUpperCase()
            : finalDestination_split.first.toUpperCase() ==
                    "First Floor".toUpperCase()
                ? "F2".toUpperCase()
                : "F3")) {
      await multiFloors();
    } else {
      await setPoints();
      await path();
    }
  }

// decide which is the shortest way between the user location and staris
  multiFloors() async {
    Map<String, int> startFloor = {};
    int min = 0;
    if (start.split(",").last.toUpperCase() == "stair 1".toUpperCase() ||
        start.split(",").last.toUpperCase() == "stair 2".toUpperCase() ||
        start.split(",").last.toUpperCase() == "stair 3".toUpperCase() ||
        start.split(",").last.toUpperCase() == "stair 4".toUpperCase() ||
        start.split(",").last.toUpperCase() == "Elevated 1".toUpperCase() ||
        start.split(",").last.toUpperCase() == "Elevated 2".toUpperCase()) {
      startPoint = Offset(
        startSelectedFloor[start.split(",").last.toUpperCase()]!.dx,
        startSelectedFloor[start.split(",").last.toUpperCase()]!.dy,
      );
      endPoint = Offset(
        startSelectedFloor[start.split(",").last.toUpperCase()]!.dx,
        startSelectedFloor[start.split(",").last.toUpperCase()]!.dy,
      );
      await path();
    } else {
      if (end.split(",").last.toUpperCase() == "stair 1".toUpperCase() ||
          end.split(",").last.toUpperCase() == "stair 2".toUpperCase() ||
          end.split(",").last.toUpperCase() == "stair 3".toUpperCase() ||
          end.split(",").last.toUpperCase() == "stair 4".toUpperCase() ||
          end.split(",").last.toUpperCase() == "Elevated 1".toUpperCase() ||
          end.split(",").last.toUpperCase() == "Elevated 2".toUpperCase()) {
        startPoint = Offset(
          startSelectedFloor[start.split(",").last.toUpperCase()]!.dx,
          startSelectedFloor[start.split(",").last.toUpperCase()]!.dy,
        );
        endPoint = Offset(
          startSelectedFloor[end.split(",").last.toUpperCase()]!.dx,
          startSelectedFloor[end.split(",").last.toUpperCase()]!.dy,
        );
        await path();
      } else {
        startPoint = Offset(
          startSelectedFloor[start.split(",").last.toUpperCase()]!.dx,
          startSelectedFloor[start.split(",").last.toUpperCase()]!.dy,
        );
        for (int i = 0; i < 6; i++) {
          if (i < 4) {
            endPoint = Offset(
                startSelectedFloor["stair ${i + 1}".toUpperCase()]!.dx,
                startSelectedFloor["stair ${i + 1}".toUpperCase()]!.dy);
            result = await path2();
            startFloor.addAll({"stair ${i + 1}".toUpperCase(): result.length});
          } else {
            endPoint = Offset(
                startSelectedFloor["Elevated ${i - 3}".toUpperCase()]!.dx,
                startSelectedFloor["Elevated ${i - 3}".toUpperCase()]!.dy);
            result = await path2();
            startFloor
                .addAll({"Elevated ${i - 3}".toUpperCase(): result.length});
          }
        }
        min = startFloor["stair 1".toUpperCase()]!;
        endPoint = Offset(
          startSelectedFloor["stair 1".toUpperCase()]!.dx,
          startSelectedFloor["stair 1".toUpperCase()]!.dy,
        );
        for (int i = 0; i < 6; i++) {
          if (i < 4) {
            if (startFloor["stair ${i + 1}".toUpperCase()]! < min) {
              min = startFloor["stair ${i + 1}".toUpperCase()]! * 1;
              endPoint = Offset(
                startSelectedFloor["stair ${i + 1}".toUpperCase()]!.dx,
                startSelectedFloor["stair ${i + 1}".toUpperCase()]!.dy,
              );
            }
          } else {
            if (startFloor["Elevated ${i - 3}".toUpperCase()]! < min) {
              min = startFloor["Elevated ${i - 3}".toUpperCase()]! * 1;
              endPoint = Offset(
                startSelectedFloor["Elevated ${i - 3}".toUpperCase()]!.dx,
                startSelectedFloor["Elevated ${i - 3}".toUpperCase()]!.dy,
              );
            }
          }
        }
        await path();
      }
    }
  }

// set start and end points
  setPoints() async {
    List<String> arr = start.split(',');
    startPoint = Offset(startSelectedFloor[arr.last.toUpperCase()]!.dx,
        startSelectedFloor[arr.last.toUpperCase()]!.dy);
    List<String> arr2 = end.split(',');
    endPoint = Offset(startSelectedFloor[arr2.last.toUpperCase()]!.dx,
        startSelectedFloor[arr2.last.toUpperCase()]!.dy);
    if (startPoint == endPoint) {
      samePlace = true;
    }
  }

// to return the path calculated
  path2() {
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(file);
    for (int i = 0; i < rowsAsListOfValues.length; i++) {
      listCol = rowsAsListOfValues.length * 1.0;
      for (int j = 0; j < rowsAsListOfValues[i].length; j++) {
        listRow = rowsAsListOfValues[i].length * 1.0;
        if (rowsAsListOfValues[i][j].toUpperCase() == "N".toUpperCase()) {
          offsetList.add(Offset((j + 1) * 1.0, (i + 1) * 1.0));
        }
      }
    }
    return AStar(
      rows: 55,
      columns: 28,
      start: startPoint,
      end: endPoint,
      barriers: offsetList,
    ).findThePath();
  }

//calculate the path between two points
  path() async {
    offsetList = [];
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(file);
    for (int i = 0; i < rowsAsListOfValues.length; i++) {
      listCol = rowsAsListOfValues.length * 1.0;
      for (int j = 0; j < rowsAsListOfValues[i].length; j++) {
        listRow = rowsAsListOfValues[i].length * 1.0;
        if (rowsAsListOfValues[i][j] == "N".toUpperCase()) {
          offsetList.add(Offset((j + 1) * 1.0, (i + 1) * 1.0));
        }
      }
    }
    result = AStar(
      rows: 55,
      columns: 28,
      start: startPoint,
      end: endPoint,
      barriers: offsetList,
    ).findThePath();
    setState(() {
      isPathReady = true;
    });
  }

//decode the floor image
  Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

//build widget
  @override
  Widget build(BuildContext context) {
    if (isImageloaded && isPathReady) {
      //check if the image loaded and the path is found
      myPainter editor = myPainter(
        image: image[start.split(",").first.toUpperCase() == "F1".toUpperCase()
            ? 0
            : start.split(",").first.toUpperCase() == "F2".toUpperCase()
                ? 1
                : 2],
        points: result,
        imageCol: listCol,
        imageRow: listRow,
      );
      return GestureDetector(
          //get user touch on screen
          onScaleUpdate: (detailData) {
            editor.Scale(detailData.scale);
            editor.Move(detailData.focalPointDelta);
            _myCanvasKey.currentContext?.findRenderObject()?.markNeedsPaint();
          },
          onScaleEnd: (detailData) {
            editor.FinishScale();
          },
          child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              endDrawer: Full_Drawer(),
              body: Stack(
                children: [
                  CustomPaint(
                    key: _myCanvasKey,
                    painter: editor,
                    child: Container(),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: ElevatedButton(
                      onPressed: () {
                        samePlace = false;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "QR_SCAN", (route) => false);
                      },
                      child: Icon(Icons.qr_code_scanner),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 5,
                      left: 5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: Colors.red,
                              ),
                              Text(
                                ": Your Location",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Serif",
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: Colors.blue,
                              ),
                              Text(
                                ": Your Destination",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Serif",
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: Colors.green,
                              ),
                              Text(
                                ": Path",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "Serif",
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                  Visibility(
                    visible: samePlace,
                    child: Center(
                        child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.black,
                      child: Text(
                        "You are at your final destination",
                        style:
                            TextStyle(color: Colors.blue, fontFamily: "Serif"),
                      ),
                    )),
                  )
                ],
              )));
    } else {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

//class myPainter which extends CustomPainter
class myPainter extends CustomPainter {
  myPainter({
    //set up the myPainter constructor
    required this.image,
    required this.points,
    required this.imageCol,
    required this.imageRow,
  });
//create all variable needed
  ui.Image image;
  Iterable<Offset> points;
  Offset mapOffset = const Offset(0, 0);
  double mapScale = 1;
  double mapScale2 = 1;
  double imageCol = 0;
  double imageRow = 0;
  double imageScaleX = 0;
  double imageScaleY = 0;

  final Paint startPainter = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  final Paint pathPainter = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill;

  final Paint endPainter = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;
  void Scale(double scale) {
    mapScale = scale;
    if (mapScale2 * mapScale < .90) {
      mapScale = .90 / mapScale2;
    }
    if (mapScale2 * mapScale > 2) {
      mapScale = 2 / mapScale2;
    }
  }

//calculate the final scale
  void FinishScale() {
    mapScale2 = mapScale * mapScale2;
    mapScale = 1;
  }

//update the view of the screen
  void Move(Offset delta) {
    mapOffset = Offset(mapOffset.dx + delta.dx, mapOffset.dy + delta.dy);
  }

//draw the image and points and the path
  @override
  void paint(Canvas canvas, Size size) {
    ApplyConstraint(size);
    canvas.scale(mapScale * mapScale2);
    canvas.drawImage(image, mapOffset, Paint());
    for (Offset offset in points) {
      canvas.drawCircle(
        Offset(offset.dx * imageScaleX, offset.dy * imageScaleY) + mapOffset,
        7 / (mapScale * mapScale2),
        pathPainter,
      );
    }
    canvas.drawCircle(
      Offset(points.first.dx * imageScaleX, points.first.dy * imageScaleY) +
          mapOffset,
      7 / (mapScale * mapScale2),
      startPainter,
    );
    canvas.drawCircle(
      Offset(points.last.dx * imageScaleX, points.last.dy * imageScaleY) +
          mapOffset,
      7 / (mapScale * mapScale2),
      endPainter,
    );
  }

// set shouldRepaint method to true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

//set limits to user to move the image on screen
  void ApplyConstraint(Size size) {
    double limitX = (image.width * mapScale * mapScale2) - size.width;
    double limitY = (image.height * mapScale * mapScale2) - size.height;
    limitX = limitX / (mapScale * mapScale2);
    limitY = limitY / (mapScale * mapScale2);
    if (mapOffset.dx > 0) {
      ;
      mapOffset = Offset(0, mapOffset.dy);
    }
    if (mapOffset.dx < -limitX) {
      mapOffset = Offset(-limitX, mapOffset.dy);
    }
    if (mapOffset.dy > 0) {
      mapOffset = Offset(mapOffset.dx, 0);
    }
    if (mapOffset.dy < -limitY) {
      mapOffset = Offset(mapOffset.dx, -limitY);
    }
    imageScaleX = image.width / imageRow;
    imageScaleY = image.height / imageCol;
  }
}
