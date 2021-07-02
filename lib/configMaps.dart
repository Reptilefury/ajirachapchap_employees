import 'dart:async';

import 'package:ajirachapchap_employees/Models/allUsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
String mapKey = "AIzaSyBl_pT_2EGbXg85O40Wmi5VtwSUYLzzXN0";
//String mapKey ="AIzaSyAJORVTfBFTKvb7RQ8aGkaypVa3-TqX6ZQ";
User firebaseUser;
Users usersCurrentInfo;
User currentfirebaseUser;
StreamSubscription<Position> homeTabPageStreamSubscription;
