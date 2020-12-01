import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pay_app/helpers/FirestoreHelper.dart';
import 'package:pay_app/models/User.dart';
import 'dashboard.dart';
import 'login.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

bool isBusy = false;

void _setBusy(bool busy) {
    setState(() {
      this.isBusy = busy;
    });
  }


  @override
  void initState() {
    super.initState();
        proceed();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: 1.0,
                  duration: Duration(milliseconds: 1000),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    child: Image.asset('assets/images/khelbuddy-logo.png'),
                  ),
                ),
              ),
            ),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void proceed() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    _setBusy(true);
    if (firebaseUser != null) {
      debugPrint('${firebaseUser.email} is logged in');
      User user = await FirestoreHelper.getUserFromData(firebaseUser);
        debugPrint('${firebaseUser.email} is a complete user');
        _setBusy(false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => DashboardScreen(user)));
    } else {
      debugPrint(' no one is logged in');
      _setBusy(false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
    }
  }
}

