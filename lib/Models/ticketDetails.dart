import 'package:google_maps_flutter/google_maps_flutter.dart';

class TicketDetails {
  String pickup_address;
  String dropOff_address;
  LatLng pickup;
  LatLng dropOff;
  String ticket_request_id;
  String payment_method;
  String employer_name;
  String employer_phone;

  TicketDetails(
      {this.payment_method,
      this.employer_name,
      this.dropOff,
      this.dropOff_address,
      this.employer_phone,
      this.pickup,
      this.pickup_address,
      this.ticket_request_id});
}
