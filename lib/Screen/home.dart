
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  User firebaseuser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Google Sign In Authentication'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.power_settings_new),
            )
          ],
        ),
        body: isSignIn? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                 CircleAvatar(
                   radius: 90,
                   backgroundImage: NetworkImage(firebaseuser.photoURL) ,),
                 Text(firebaseuser.displayName,textScaleFactor: 2,),
                  Text(firebaseuser.email,textScaleFactor: 2,),
                  
               OutlinedButton(onPressed: (){
       
               gooleSignout();
      },
      child: Text('Log Out'),
      
      )
                   
             
              
                           ],
                         ),
        ):
         Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Center(
                        child: Text(
                      'Google Sign In',
                      style: TextStyle(
                          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                   ),
                    FlatButton.icon(
                   color: Colors.blueGrey,
                  onPressed: () {
                  gsign();
                                 },
                                icon: Icon(EvaIcons.google),
                               label: Text('Google Sign In'),
                               textColor: Colors.black,
                               ),
             ],
           ),
         ),
                     );
                   }
                   bool isSignIn= false;
                Future<void>   gsign() async{
                  GoogleSignIn _googleSignIn = GoogleSignIn(
                   
                 );
                 GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn(); // Trigger Authentication Floe
                 
    GoogleSignInAuthentication authentication = await googleSignInAccount.authentication; // obtain auth detail fromthe request
                 AuthCredential credential =      GoogleAuthProvider.credential(idToken: authentication.idToken, accessToken: authentication.accessToken); // creating new credential
                 FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                 UserCredential result= await firebaseAuth.signInWithCredential(credential);
                 
                 firebaseuser = result.user;
                 setState(() {
                   isSignIn= true;
                 });
               
                   }
                Future<void> gooleSignout() async {
    await firebaseAuth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    });
  }
                 }
                 
                

