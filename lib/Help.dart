import 'package:flutter/material.dart';

import 'Full_Drawer.dart';

class Help extends StatefulWidget {
  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      endDrawer: Full_Drawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Below are instructions how to use the application",
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionPanelList.radio(
              animationDuration: Duration(milliseconds: 500),
              children: [
                ExpansionPanelRadio(
                  canTapOnHeader: true,
                  backgroundColor: Colors.blue,
                  value: Text("Create Account"),
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text("Create Account:",
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    );
                  },
                  body: ListTile(
                    tileColor: Colors.grey,
                    title: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "To create new account, Go to Sign In on the homepage",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image:
                              AssetImage("lib/assets/HelpMaterial/SignIn.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "Then click on \"Create Account\" button",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/CreateAccount.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "Enter the required information",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/CreateAccountInfo.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "Final step is click on \"Sign Up\" button",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/CreateAccountDone.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    backgroundColor: Colors.blue,
                    value: Text("Sign In"),
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text("Sign In:",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      );
                    },
                    body: ListTile(
                        tileColor: Colors.grey,
                        title: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.blue[400],
                              child: Text(
                                "To Login to your account, Go to Sign In on the homepage",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  "lib/assets/HelpMaterial/SignIn.png"),
                              height: 400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.blue[400],
                              child: Text(
                                "Enter your E-mail address and password",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  "lib/assets/HelpMaterial/SigninPage.png"),
                              height: 400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  "lib/assets/HelpMaterial/SigninPage_1.png"),
                              height: 400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.blue[400],
                              child: Text(
                                "Finally, Press \"Sign In\" button",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  "lib/assets/HelpMaterial/SigninPageDone.png"),
                              height: 400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ))),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    backgroundColor: Colors.blue,
                    value: Text("Reset Password:"),
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text("Reset Password:",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      );
                    },
                    body: ListTile(
                      tileColor: Colors.grey,
                      title: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.blue[400],
                            child: Text(
                              "To reset your Password, Go to Sign In on the homepage",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/SignIn.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.blue[400],
                            child: Text(
                              "Then Press \"Forget Password\" Word",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordStep1.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.blue[400],
                            child: Text(
                              "Enter the account E-mail",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordStep2.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordStep2_1.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.blue[400],
                            child: Text(
                              "Answer the security question",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordStep3.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordStep3_1.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.blue[400],
                            child: Text(
                              "Enter new password",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordStep4.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordStep4_1.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.blue[400],
                            child: Text(
                              "Congratulations, You have successfully reset your password",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image(
                            image: AssetImage(
                                "lib/assets/HelpMaterial/ForgetPasswordDone.png"),
                            height: 400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    backgroundColor: Colors.blue,
                    value: Text("QR Code Map:"),
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text("QR Code Map:",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      );
                    },
                    body: ListTile(
                      tileColor: Colors.grey,
                      title: Column(children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "To see QR locations, go to the QR code map on the homepage",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image:
                              AssetImage("lib/assets/HelpMaterial/QRMap.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                              "Choose the floor you want to know the QR locations",
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/ChooseFloor.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/FloorMenu.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                              "You can now zoom in and out to discover the QR code closest to you",
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/QRLocations.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                    )),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    backgroundColor: Colors.blue,
                    value: Text("Scan QR Code:"),
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text("Scan QR Code:",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      );
                    },
                    body: ListTile(
                      tileColor: Colors.grey,
                      title: Column(children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "To scan QR Code, Go to \"QR CODE SCAN\" on the homepage",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/ScanQRButton.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "Then scan the QR code closest to you",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image:
                              AssetImage("lib/assets/HelpMaterial/ScanQR.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                    )),
                ExpansionPanelRadio(
                  canTapOnHeader: true,
                  backgroundColor: Colors.blue,
                  value: Text("Display Map:"),
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text("Display Map:",
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    );
                  },
                  body: ListTile(
                    tileColor: Colors.grey,
                    title: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "To Display Map, Scan closest QR code to you",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/CurrentLocation.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "Choose the floor you want to go to",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/DestinationFloor.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "Then choose the room you want to go to",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/DestinationRoom.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          color: Colors.blue[400],
                          child: Text(
                            "Finally click on \"Display Map\" button",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage(
                              "lib/assets/HelpMaterial/DisplayMap.png"),
                          height: 400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
