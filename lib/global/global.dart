import 'dart:async';

import 'package:driver_app/models/user_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:geolocator/geolocator.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUse;
UserModel? userModelCurrentInfo;
StreamSubscription<Position>? streamSubscriptionPosition;
