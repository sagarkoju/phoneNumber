import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool togglevisibilty = false;
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: AutofillGroup(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                  validator: (email) => !EmailValidator.validate(email)
                      ? 'Enter the Valida email'
                      : null,
                  enabled: true,
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      focusColor: Colors.green,
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: Colors.green)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: Colors.green)),
                      hintText: " Enter the Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: togglevisibilty,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: [AutofillHints.password],
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  textInputAction: TextInputAction.done,
                  validator: (password) =>
                      password != null && password.length < 5
                          ? 'Enter the min 5 password'
                          : null,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    focusColor: Colors.green,
                    hintText: " Enter the password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          togglevisibilty = !togglevisibilty;
                        });
                      },
                      icon: togglevisibilty
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildPadding(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: FlatButton(
          onPressed: () {
            final form = formkey.currentState;
            if (form.validate()) {
              TextInput.finishAutofillContext(shouldSave: true);
              final email = emailcontroller.text;
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              Get.snackbar('your email is', '$email',
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
