import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Screen/home.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class Sagar extends StatefulWidget {
  @override
  _SagarState createState() => _SagarState();
}

class _SagarState extends State<Sagar> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
      onPressed:
      (){
             Get.off(HomePage());
      },
      child: Icon(Icons.arrow_back),
      ),
      appBar: AppBar(
        title: Text('Save Image'),
        centerTitle: true,
        backgroundColor: Colors.green,
        
      ),
      body: StreamBuilder(
        stream: firebaseFirestore.collection("Images").snapshots(),
           builder: (context, snapshot) { 
             return !snapshot.hasData ? Center(
               child: CircularProgressIndicator(),
             ):
          Container(
            padding: EdgeInsets.all(8),
            child: GridView.builder(
            itemCount: snapshot.data.documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:3 ), 
            itemBuilder: (context, index){
              return Container(
                margin: EdgeInsets.all(8),
                child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                 image: snapshot.data.documents[index].get('url')
                 ),
              );
            }),
          );
        
            
           },
           ),
 

      //     body: Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   color: Colors.greenAccent,
      //   child: Text('THANK YOU', textScaleFactor: 5, textAlign: TextAlign.center,),
      // ),
    );
  }
 
}