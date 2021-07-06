import 'dart:async';

import 'package:ajirachapchap_employees/Models/ticketDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewTicketScreen extends StatefulWidget {

  final TicketDetails ticketDetails;
  NewTicketScreen({this.ticketDetails});

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  //const NewTicketScreen({Key key}) : super(key: key);

  @override
  _NewTicketScreenState createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newTicketGoogleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          //     padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: NewTicketScreen._kGooglePlex,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newTicketGoogleMapController = controller;
           
          },
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))
          ),
        )
      ],),
    );
  }
}
