import 'package:driver_app/authentication/car_info_screen.dart';
import 'package:driver_app/authentication/login_screen.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/widgets/progress_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({super.key});
  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {
  TextEditingController nameTextedtingController = TextEditingController();
  TextEditingController emailTextedtingController = TextEditingController();
  TextEditingController phoneTextedtingController = TextEditingController();
  TextEditingController passwordTextedtingController = TextEditingController();
  validateForm() {
    if (nameTextedtingController.text.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("name must be atleast 3 Characters"),
        duration: Duration(seconds: 1),
      ));
    } else if (!emailTextedtingController.text.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Phone Number is requried"),
        duration: Duration(seconds: 1),
      ));
    } else if (passwordTextedtingController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("password must be atleast 6 Characters"),
        duration: Duration(seconds: 1),
      ));
    } else {
      saveDividerInfoNew();
    }
  }

  saveDividerInfoNew() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait..",
          );
        });
    final User? FirebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
                email: emailTextedtingController.text.trim(),
                password: passwordTextedtingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      SnackBar(content: Text("Error:" + msg.toString()));
    }))
        .user;
    if (FirebaseUser != null) {
      Map driverMap = {
        "id": FirebaseUser.uid,
        "name": nameTextedtingController.text.trim(),
        "email": emailTextedtingController.text.trim(),
        "phone": phoneTextedtingController.text.trim(),
      };
    DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(FirebaseUser.uid).set(driverMap);
      currentFirebaseUse = FirebaseUser;
      SnackBar(content: Text("Account has been created."));
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
    } else {
      Navigator.pop(context);
      SnackBar(content: Text("Accout has not been created"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                "https://th.bing.com/th/id/OIP.HyJD9gI5jXZyEqIZewRDnQHaDn?w=302&h=171&c=7&r=0&o=5&pid=1.7",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Registar as a Driver",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: nameTextedtingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Name",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextField(
              controller: emailTextedtingController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Email",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextField(
              controller: phoneTextedtingController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                labelText: "Phone Number",
                hintText: "Phone Number",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextField(
              controller: passwordTextedtingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                labelText: "password",
                hintText: "Password",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  validateForm();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CarInfoScreen()));
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.black45),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  "Already have an Account?Sign here",
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        ),
      )),
    );
  }
}
