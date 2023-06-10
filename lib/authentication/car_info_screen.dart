import 'package:driver_app/global/global.dart';
import 'package:driver_app/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  List<String> carTypesList = ["uber_x", 'uber_go', 'bike'];
  String? selectedCarType;
  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };
    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driversRef
        .child(currentFirebaseUse!.uid)
        .child("car_details")
        .set(driverCarInfoMap);
    const SnackBar(content: Text("car details has been saved.Congratulations"));
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => MySplashScreen()));
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.network(
                    'https://th.bing.com/th/id/OIP.HyJD9gI5jXZyEqIZewRDnQHaDn?w=302&h=171&c=7&r=0&o=5&pid=1.7'),
              ),
              SizedBox(height: 10),
              Text(
                'Write Car Details',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
                decoration: const InputDecoration(
                    labelText: 'Car Model',
                    suffixStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    hintText: 'Car Model',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                controller: carNumberTextEditingController,
                 keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Car Number',
                    hintText: 'Car Number',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                controller: carColorTextEditingController,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Car Color',
                    hintText: 'Car Color',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              SizedBox(height: 20),
              DropdownButton(
                iconSize: 25,
                // icon: Icon(Icons.map),
                dropdownColor: Colors.black,
                hint: const Text(
                  "Please Choose Car Type",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypesList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (carColorTextEditingController.text.isNotEmpty &&
                        carNumberTextEditingController.text.isNotEmpty &&
                        carModelTextEditingController.text.isNotEmpty &&
                        selectedCarType != null) {
                      saveCarInfo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreenAccent),
                  child: const Text(
                    'Save Now',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
