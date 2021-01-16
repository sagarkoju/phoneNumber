import 'dart:ffi';

import 'package:crud/Page/firstpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String verification;

  Future <Void> loginUser( String phone ,BuildContext context){
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      firebaseAuth.verifyPhoneNumber(
        timeout: Duration(seconds: 10),
      phoneNumber: phone,
     verificationCompleted: (AuthCredential credential) async{
       Navigator.pop(context);
          UserCredential  result= await firebaseAuth.signInWithCredential(credential);

          User firebaseUser = result.user;
        
        if(firebaseUser!= null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Sagar(firebaseUser: firebaseUser,)));
        }
        else {
          print ('Error');
        }
          

     },
     verificationFailed:( FirebaseAuthException authException){
       print(authException.message);
     }, 
     codeSent: (String verificationId, [int forceResendingToken]){
       showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text('Give the code'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: codeController,
                )
              ],
              
            ),
            actions: [
              FlatButton(
              onPressed: () async{
                final code = codeController.text.trim();
              AuthCredential credential = PhoneAuthProvider.credential(verificationId:verificationId , smsCode: code);
               UserCredential  result= await firebaseAuth.signInWithCredential(credential);

               User firebaseUser = result.user;
                if(firebaseUser!= null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Sagar(firebaseUser: firebaseUser,)));
        }
        else {
          print ('Error');
        }
              },
             child: Text('Confirm'),
             textColor: Colors.white,
             color: Colors.blue,
             )
            ],
          );
        }
        
        
        );
     }, 
     codeAutoRetrievalTimeout: (String verId){
         setState(() {
           verification= verId;
         });
     });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Verification'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
       body: Column(
         children: [
           Text('Login', style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.bold),),
           SizedBox(
             height: 30,
           ),
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: TextFormField(
               
               
               controller: _controller,
               decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[100])
                 ),
                hintText: "Mobile Number",
                fillColor: Colors.grey[100],
                  ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                 color: Colors.blue,
               ),
               
               width: double.infinity,
               child: FlatButton(
                child: Text('Login'),
                textColor: Colors.white,
                onPressed: (){
                  final phone = _controller.text.trim();
                  loginUser(phone , context);
                }),
             ),
           )
         ],
       ),
    );
  }
}