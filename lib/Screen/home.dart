import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/page.dart/orientationbuilder.dart';

import 'package:crud/page.dart/page.dart';
import 'package:crud/page.dart/scan_barcode.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crud/page.dart/dell.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _imageFile;
  String imgURL;
  Widget _previewWidget = SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Upload"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              RaisedButton(
                  color: Colors.lightBlue,
                  child: Text('Pick Image'),
                  textColor: Colors.white,
                  onPressed: () {
                    _pick();
                  }),
              SizedBox(
                height: 30,
              ),
              _preview(),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                  child: Text('Upload'),
                  textColor: Colors.white,
                  color: Colors.lightBlue,
                  onPressed: () {
                    _upload(context);
                  }),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                  color: Colors.blue,
                  child: Text('PDF Viewer'),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PDFViewer()));
                  }),
              RaisedButton(
                  color: Colors.blue,
                  child: Text('Show SnackBar'),
                  textColor: Colors.white,
                  onPressed: () {
                    Get.snackbar("Welcome to", "Home Page",
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.red,
                        backgroundColor: Colors.black,
                        animationDuration: Duration(milliseconds: 5000),
                        titleText: Text(
                          "Sagar",
                          style: TextStyle(color: Colors.red),
                        ),
                        messageText: Text(
                          "Koju",
                          style: TextStyle(color: Colors.red),
                        ));
                  }),
              RaisedButton(
                  color: Colors.blue,
                  child: Text('Show Dialog'),
                  textColor: Colors.white,
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Welcome",
                      middleText: "to Home Page",
                      content: Text('Welcome to Login Page'),
                      backgroundColor: Colors.purpleAccent,
                      textConfirm: "Confirm",
                      textCancel: "Cancel",
                      buttonColor: Colors.green,
                      barrierDismissible: true,
                    );
                  }),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                  color: Colors.blue,
                  child: Text('bottom sheet'),
                  textColor: Colors.white,
                  onPressed: () {
                    Get.bottomSheet(
                        Container(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.home),
                                title: Text('Home'),
                              ),
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text('About'),
                              ),
                              ListTile(
                                leading: Icon(Icons.shopping_bag),
                                title: Text('Cart'),
                              ),
                              ListTile(
                                leading: Icon(Icons.star),
                                title: Text('Share'),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.greenAccent,
                        barrierColor: Colors.orangeAccent);
                  }),
              RaisedButton(
                  color: Colors.blue,
                  child: Text('show Barcode'),
                  textColor: Colors.white,
                  onPressed: () {
                    Get.to(ShowBarcode());
                  }),
              RaisedButton(
                  color: Colors.blue,
                  child: Text('Orientation Builder'),
                  textColor: Colors.white,
                  onPressed: () {
                    Get.to(OrientationBuilders());
                  })
            ],
          ),
        ),
      ),
    );
  }

  _pick() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      _previewWidget = Image.file(
        _imageFile,
        height: Get.height * .5,
      );
    }
  }

  Future _upload(BuildContext context) async {
    FirebaseStorage firebaseStorage = FirebaseStorage();
    StorageReference reference = firebaseStorage
        .ref()
        .child("images/" + DateTime.now().toIso8601String());
    StorageUploadTask task = reference.putFile(_imageFile);
    StorageTaskSnapshot snapshot = await task.onComplete;
    var downloadurl = await snapshot.ref.getDownloadURL();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection("Images").add({
      "url": downloadurl,
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Upload Successfully'),
            content: Image.network(
              downloadurl,
              height: Get.height * .25,
            ),
            actions: [
              RaisedButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Sagar()));
                  }),
              RaisedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
//   Get.dialog(AlertDialog(
// content: Text("Upload Successfully", style: TextStyle(color: Colors.black, fontSize: 20),)
// ,

//     ));

    setState(() {
      imgURL = downloadurl;
    });
  }

  Widget _preview() {
    return _previewWidget;
  }
}
