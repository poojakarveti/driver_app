import 'dart:async';

import 'package:driver_app/authentication/login_screen.dart';
import 'package:driver_app/authentication/signup_screen.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/mainScreen/main_screen.dart';
import 'package:driver_app/tab_Pages/home_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});
  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUse = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) =>LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  height: 300,
                  fit: BoxFit.cover,
                  "https://th.bing.com/th/id/OIP.HyJD9gI5jXZyEqIZewRDnQHaDn?w=302&h=171&c=7&r=0&o=5&pid=1.7"
                  ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Uber &indriver Clone App",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
