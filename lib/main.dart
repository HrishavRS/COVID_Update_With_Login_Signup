import 'package:flutter/material.dart';
import 'package:covidupdate/homepage.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'models/authentication.dart';
import 'models/http_exception.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';


void main() {
  runApp(CovidUpdate());
}

class CovidUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child:MaterialApp(
        title: 'COVID Update',
        home: LoginScreen(),
        routes:{
          SignupScreen.routeName:(ctx)=>SignupScreen(),
          LoginScreen.routeName:(ctx)=>LoginScreen(),
          HomePage.routeName:(ctx)=>HomePage()
        },
    )
    );
  }
}
