import 'package:crud/screen/home.dart';
import 'package:crud/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    theme: Themes().lightTheme,
    darkTheme: Themes().darkTheme,
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
