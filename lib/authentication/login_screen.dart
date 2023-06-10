

import 'package:driver_app/authentication/signup_screen.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/splash_screen.dart';
import 'package:driver_app/widgets/progress_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditinController = TextEditingController();
  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      // ScaffoldMessenger.of(context).showSnackBar(const
      const SnackBar(
        content: Text("Email address is not valid"),
        duration: Duration(seconds: 1),
      );
    } else if (passwordTextEditinController.text.isEmpty) {
      const SnackBar(
        content: Text("password is required"),
        duration: Duration(seconds: 1),
      );
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "processing,please wait...",
          );
        });
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditinController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      SnackBar(content: Text("Error :" + msg.toString()));
    }))
        .user;

    if (firebaseUser != null) {
      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverkey) {
        final snap = driverkey.snapshot;
        if (snap.value != null) {
          currentFirebaseUse = firebaseUser;
          const SnackBar(content: Text("Login Successful"));
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        } else {
          SnackBar(content: Text("No records exist with this email"));
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      const SnackBar(content: Text("Error occured during login"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.network(
                    "https://th.bing.com/th/id/OIP.HyJD9gI5jXZyEqIZewRDnQHaDn?w=302&h=171&c=7&r=0&o=5&pid=1.7"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Login as a Driver',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                controller: passwordTextEditinController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'password',
                    hintText: 'password',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    validateForm();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreenAccent),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => SignUpscreen()));
                  },
                  child: const Text(
                    "Do not have an Account?Signup here",
                    style: TextStyle(color: Colors.grey),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
