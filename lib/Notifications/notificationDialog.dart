import 'dart:js';

import 'package:ajirachapchap_employees/AllScreens/newTicketScreen.dart';
import 'package:ajirachapchap_employees/Models/ticketDetails.dart';
import 'package:ajirachapchap_employees/configMaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ajirachapchap_employees/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationDialog extends StatelessWidget {
  final TicketDetails ticketDetails;

  NotificationDialog({this.ticketDetails});

  //const NotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            SizedBox(
              height: 30.0,
            ),
            Image.asset(
              "images/worker.png",
              width: 120.0,
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              "New ticket Request",
              style: TextStyle(fontFamily: "Brand-Bold", fontSize: 18.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/pickicon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(child: Container(
                        child: Text(
                          ticketDetails.pickup_address,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),),

                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/pickicon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            ticketDetails.dropOff_address,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(height: 2.0, color: Colors.black, thickness: 2.0,),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red),
                    ),
                    color: Colors.white,
                    textColor: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      assetsAudioPlayer.stop();
                      checkAvailabilityOfTicket(context);
                      // Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green)),
                    onPressed: () {},
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      "Accept".toUpperCase(),
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0,)
          ],
        ),
      ),
    );
  }

  void checkAvailabilityOfTicket(BuildContext context) {
    ticketRequestRef.once().then((DataSnapshot dataSnapShot) {
      Navigator.pop(context);
      String theTicketId = "";
      if (dataSnapShot.value != null) {
        theTicketId = dataSnapShot.value.toString();
      }
      else {
        displayToastMessage("Ticket does not exist", context);
      }

      if (theTicketId == ticketDetails.ticket_request_id) {
        ticketRequestRef.set("Accepted");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewTicketScreen()));
      }
      else if (theTicketId == "cancelled") {
        displayToastMessage("Ticket has been Cancelled", context);
      } else if (theTicketId == "timeout") {
        displayToastMessage("ticket has time out", context);
      } else {
        displayToastMessage("Ticket does not exist", context);
      }
    });
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
