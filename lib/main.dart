import 'package:flutter/material.dart';
import 'package:procurex/requisition/requisitions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Requisitions(),
      debugShowCheckedModeBanner: false,
    );
  }
}
