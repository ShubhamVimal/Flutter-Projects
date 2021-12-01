import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my__weather_app/screens/HomePageNew.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Oxygen',
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
