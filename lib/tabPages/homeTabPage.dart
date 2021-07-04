import 'dart:async';
import 'package:ajirachapchap_employees/Assistants/assistantMethods.dart';
import 'package:ajirachapchap_employees/Notifications/pushNotificationService.dart';
import 'package:ajirachapchap_employees/configMaps.dart';
import 'package:ajirachapchap_employees/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeTabPage extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;

  Position currentPosition;

  var geoLocator = Geolocator();

  String EmployeeStatusText = "Offline Now - Go Online? ";

  Color EmployeeStatusColor = Colors.black;

  bool isEmployeeAvailable = false;
  @override
  void initState() {
    super.initState();
    getCurrentEmployeeinfo();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //  String address =
    //await AssistantMethods.searchCoordinateAddress(position, context);
    //print("This is your address ::" + address);
  }

  void getCurrentEmployeeinfo() async {
    currentfirebaseUser = (await FirebaseAuth.instance.currentUser);
    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.initialize();
    pushNotificationService.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          //     padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: HomeTabPage._kGooglePlex,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;
            locatePosition();
          },
        ),
        Container(
          height: 140.0,
          width: double.infinity,
          color: Colors.black54,
        ),
        Positioned(
          top: 60.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (isEmployeeAvailable != true) {
                      makeEmployeeOnlineNow();
                      getLocationLiveUpdates();
                      setState(() {
                        EmployeeStatusColor = Colors.green;
                        EmployeeStatusText = "Online Now";
                        isEmployeeAvailable = true;
                      });
                      displayToastMessage("You're online now", context);
                    } else {
                      makeEmployeeOfflineNow();
                      setState(() {
                        EmployeeStatusColor = Colors.black;
                        EmployeeStatusText = "Offline Now - Go Online?";
                        isEmployeeAvailable = false;
                      });
                      /*  Geofire.removeLocation(currentfirebaseUser.uid);
                      ticketRequestRef.onDisconnect();
                      ticketRequestRef.remove();
                      ticketRequestRef=null;
                      displayToastMessage("you're currently offline", context); */
                      //makeEmployeeOfflineNow();
                      displayToastMessage("you're currently offline", context);
                    }
                  },
                  color: EmployeeStatusColor,
                  child: Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          EmployeeStatusText,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 26.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    //return Container();
  }

  void makeEmployeeOnlineNow() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    Geofire.initialize("availableEmployees");
    Geofire.setLocation(currentfirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);
    ticketRequestRef.onValue.listen((event) {});
  }

  void getLocationLiveUpdates() {
    homeTabPageStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isEmployeeAvailable == true) {
        Geofire.setLocation(
            currentfirebaseUser.uid, position.latitude, position.longitude);
      }
      LatLng latLng = LatLng(position.latitude, position.longitude);
      newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  void makeEmployeeOfflineNow() {
    Geofire.removeLocation(currentfirebaseUser.uid);
    ticketRequestRef.onDisconnect();
    ticketRequestRef.remove();
    ticketRequestRef = null;
    // displayToastMessage("you're currently offline", context);
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
