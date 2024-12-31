import 'package:flutter/material.dart';
import 'get_started.dart';

void main() {
  runApp(LuxuryTechApp());
}

class LuxuryTechApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxury Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GetStartedScreen(),
      
    );
  }
}
