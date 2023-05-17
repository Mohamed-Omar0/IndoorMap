import 'dart:io';
import 'package:flutter/material.dart';
import 'package:indoor_map_application/Full_Drawer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QR_SCANNER extends StatefulWidget {
  @override
  State<QR_SCANNER> createState() => _QR_SCANNERState();
}

Barcode? barcodeData;

class _QR_SCANNERState extends State<QR_SCANNER> {
  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  Barcode? barcode;

  setQrData() {
    barcodeData = barcode;
  }

  switchWindow(BuildContext cont) {
    if (barcode != null) {
      controller?.stopCamera();
      controller?.dispose();
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(cont)
            .pushNamedAndRemoveUntil("Select_Destination", (route) => false);
      });
    }
    ;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        endDrawer: Full_Drawer(),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
                borderWidth: 10,
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 20,
              ),
            ),
            Positioned(
                top: 30,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white24),
                  child: IconButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: FutureBuilder<bool?>(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return Icon(snapshot.data!
                                  ? Icons.flash_on
                                  : Icons.flash_off);
                            } else {
                              return Container();
                            }
                          })),
                )),
            Positioned(
                bottom: 20,
                child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("Please scan QR code"))),
            Container(
              child: setQrData(),
            ),
            Container(
              child: switchWindow(context),
            ),
          ],
        ));
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}

getLocation() {
  return barcodeData;
}
