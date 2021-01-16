import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sagar extends StatelessWidget {

  final User firebaseUser;

  const Sagar({ @required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text('You are logged in successfully', style: TextStyle(color: Colors.lightBlue, fontSize: 32),),
            SizedBox(
              height: 30,
            ),
            Text("${firebaseUser.phoneNumber}", style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}

 
 