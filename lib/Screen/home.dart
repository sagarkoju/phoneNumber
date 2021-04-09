import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crud/page/dell.dart';
import 'package:crud/page/layout.dart';
import 'package:crud/page/login.dart';
import 'package:crud/page/orientationbuilder.dart';
import 'package:crud/page/page.dart';
import 'package:crud/page/sanam.dart';
import 'package:crud/page/scan_barcode.dart';
import 'package:crud/page/speech_to_text.dart';
import 'package:crud/widget/custom_widget.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';

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
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Do you want to exist the app"),
                backgroundColor: Colors.amber,
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text('Yes')),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text("No"))
                ],
              );
            });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "File Upload",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          // elevation: 10,
          // backgroundColor: Colors.transparent,
          // brightness: Brightness.light,
          actions: [
            IconButton(
                icon: Icon(Icons.lightbulb_outline),
                color: Colors.black,
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
                /// Image Picker from gallery
                RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Pick Image'),
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

                /// Image upload to the firebase
                RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Upload'),
                    onPressed: () {
                      _upload(context);
                    }),
                SizedBox(
                  height: 30,
                ),
                // / pdf Viewer button
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('PDF Viewer'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PDFViewer()));
                    }),
                // /snackbar raised button
                RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Show SnackBar'),
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
                // show dialog button
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
                // Show bottom sheet bottom
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
                // / show barcode
                // RaisedButton(
                //     color: Colors.blue,
                //     child: Text('show Barcode'),
                //     textColor: Colors.white,
                //     onPressed: () {
                //       Get.to(ShowBarcode());
                //     }),

                Raised(
                  child: Text('show barcode'),
                  color: Colors.blue,
                  textcolor: Colors.white,
                  onPressed: () {
                    Get.to(ShowBarcode());
                  },
                ),

                Raised(
                  child: Text('Login'),
                  color: Colors.blue,
                  textcolor: Colors.white,
                  onPressed: () {
                    Get.to(Login());
                  },
                ),
                // Show orientation builder

                Raised(
                  color: Colors.blue,
                  child: Text('Orientation Builder'),
                  textcolor: Colors.white,
                  onPressed: () {
                    Get.to(OrientationBuilders());
                  },
                ),
                Raised(
                  color: Colors.blue,
                  child: Text('speech to text'),
                  textcolor: Colors.white,
                  onPressed: () {
                    Get.to(Speech());
                  },
                ),
                RaisedButton(
                    child: Text("sanam map"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Sanam()));
                    }),
                RaisedButton(
                    child: Text("Layout Builder"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Lay()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Pick image from the gallery
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

//  upload the image to the firebase
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
