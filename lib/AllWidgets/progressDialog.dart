import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;

  // final ProgressDialog progressDialog;
  ProgressDialog({
     this.message,
    //this.progressDialog
  });

  /*const ProgressDialog({
    Key key,
    //  this.progressDialog
  }) : super(key: key);*/

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.indigoAccent,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 6.0,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(
                width: 26.0,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
