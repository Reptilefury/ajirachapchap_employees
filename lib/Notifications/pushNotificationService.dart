import 'package:ajirachapchap_employees/configMaps.dart';
import 'package:ajirachapchap_employees/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;


class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future initialize() async {

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
     print(" Message received $RemoteMessage");
     print(event.notification .body);
     print(event.data.values);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Message clicked!:$message");
      getTicketRequestId(message);
    });

    /*firebaseMessaging.requestPermission(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onResume: $message");
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    }); */
  }

  Future<String> getToken() async {
    String token = await firebaseMessaging.getToken();
    print("This is token::");
    print(token);
    employeesRef.child(currentfirebaseUser.uid).child("token").set(token);
 firebaseMessaging.subscribeToTopic("allEmployees");
    firebaseMessaging.subscribeToTopic("allEmployers");
    firebaseMessaging.getToken().then((value){
      print(" this is the token: $value");
    });

  }
  String getTicketRequestId(Map<String, dynamic> message){

String ticketRequestId = "";
    if(Platform.isAndroid) {
      print("This is Ride Request Id::");
       ticketRequestId = message['data']['ticket_request_id'];
       print(ticketRequestId);
    }
    else{
      print("This is Ride Request Id::");

      ticketRequestId = message['ticket_request_id'];
      print(ticketRequestId);

    }
    return ticketRequestId;

  }
}
