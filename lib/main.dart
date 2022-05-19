import 'package:flutter/material.dart';
import 'package:numericalcomputing/bisection.dart';
import 'package:numericalcomputing/newtonRaphason.dart';
import 'package:numericalcomputing/secant.dart';
import 'package:numericalcomputing/falsePosition.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FalsePosition(),
    );
  }
}
