import 'package:ajira_chapchap/AllScreens/mainscreen.dart';
import 'package:ajira_chapchap/configMaps.dart';
import 'package:ajira_chapchap/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ajira_chapchap/AllWidgets/progressDialog.dart';


class ProfessionScreen extends StatelessWidget {
  static const String idScreen = "Ticketinfo";
  TextEditingController ProfessionTypetextEditingController =
  TextEditingController();
  TextEditingController ProfessionExperiencetextEditingController =
  TextEditingController();
  TextEditingController WorkingHourstextEditingController =
  TextEditingController();
  TextEditingController ChargestextEditingController = TextEditingController();
  TextEditingController PaymentOptiontextEditingController =
  TextEditingController();

  //const CarInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 22.0,
              ),
              Image.asset(
                "images/93-930840_industrial-worker-clipart-blue-collar-job-cartoon.png",
                width: 390.0,
                height: 250.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Enter your profession Details",
                      style: TextStyle(fontFamily: "Bradley Hand"),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: ProfessionTypetextEditingController,
                      decoration: InputDecoration(
                        labelText: "Profession Type",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: ProfessionExperiencetextEditingController,
                      decoration: InputDecoration(
                        labelText: "Profession Experience",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: WorkingHourstextEditingController,
                      decoration: InputDecoration(
                        labelText: "Working Hours",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: ChargestextEditingController,
                      decoration: InputDecoration(
                        labelText: "Charges per hour",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: PaymentOptiontextEditingController,
                      decoration: InputDecoration(
                        labelText: " Payment Options",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 42.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (ProfessionTypetextEditingController.text
                              .isEmpty) {
                            displayToastMessage(
                                "Please write Profession Type", context);
                          } else
                          if (ProfessionExperiencetextEditingController.text
                              .isEmpty) {
                            displayToastMessage(
                                "please write Profession experience", context);
                          } else if (WorkingHourstextEditingController.text.isEmpty){
                            displayToastMessage("Please write Working hours", context);
                          } else if(ChargestextEditingController.text.isEmpty){
                            displayToastMessage("Please write charges per hour", context);

                          }
                          else
                            {
                           saveEmployeeInfo(context);
                            }
                        },
                        color: Theme
                            .of(context)
                            .accentColor,
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "NEXT",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 26.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveEmployeeInfo(context) {
    String userId = currentfirebaseUser.uid;
    Map carInfoMap = {
      "profession_type": ProfessionTypetextEditingController.text,
      "Profession_experience": ProfessionExperiencetextEditingController.text,
      "Working_hours": WorkingHourstextEditingController.text,
      "charges_per hour": ChargestextEditingController.text,
      "payment options": PaymentOptiontextEditingController.text,
    };
    employeesRef.child(userId).child("employees_details").set(carInfoMap);
    Navigator.pushNamedAndRemoveUntil(
        context, MainScreen.idScreen, (route) => false);
  }

  void displayToastMessage(String message, BuildContext context) {}

}
