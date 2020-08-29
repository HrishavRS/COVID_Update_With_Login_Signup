import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName='/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('This is home screen',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize:20),
        ),
      ),
    );
  }
}
