import 'dart:ffi';

import 'package:driver_app/assistants/request_assistant.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/global/map_key.dart';
import 'package:driver_app/infoHandler/app_info.dart';
import 'package:driver_app/models/direction_details_info.dart';
import 'package:driver_app/models/directions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/user_models.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoOrdinates(
      Position position, context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress = "";
    var requestResponse = await RequestAssistant.recieveRequest(apiUrl);
    if (requestResponse != "Error Occured,Failed, No Response.") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];
      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }
    return humanReadableAddress;
  }

  static void readCurrentOnlineUserInfo() async {
    currentFirebaseUse = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child("currentFirebaseUser!.uid");
    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        var userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
        print("name =" + userModelCurrentInfo.name.toString());
        print("email =" + userModelCurrentInfo.email.toString());
      }
    });
  }

  static Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails(
      LatLng originPosition, LatLng destinationPosition) async {
    String urlOriginToDestinationDirectionDetails =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";
    var responseDirectionApi = await RequestAssistant.recieveRequest(
        urlOriginToDestinationDirectionDetails);
    if (responseDirectionApi == "Error Ocurred,Failed,No Response") {
      return null;
    }
    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points =
        responseDirectionApi["routes"][0]["overview_polyline"]["points"];

    directionDetailsInfo.distance_text =
        responseDirectionApi["routes"][0]["legs"]["distance"]["text"];

    directionDetailsInfo.duration_value =
        responseDirectionApi["routes"][0]["legs"]["distance"]["value"];

    directionDetailsInfo.duration_text =
        responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];

    directionDetailsInfo.duration_value =
        responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetailsInfo;
  }
}
