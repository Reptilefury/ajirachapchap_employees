import 'package:ajira_chapchap/AllScreens/ProfessionDetails.dart';
import 'package:ajira_chapchap/AllScreens/loginScreen.dart';
import 'package:ajira_chapchap/AllScreens/mainscreen.dart';
import 'package:ajira_chapchap/AllScreens/registrationScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ajira_chapchap/DataHandler/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AllScreens/loginScreen.dart';
import 'AllScreens/mainscreen.dart';
import 'AllScreens/registrationScreen.dart';
import 'DataHandler/appData.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//final databaseReference = FirebaseDatabase.instance.reference();

/*void createData(){
  DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
  DatabaseReference employeesRef = FirebaseDatabase.instance.reference().child("employees");

}*/
 DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
DatabaseReference employeesRef = FirebaseDatabase.instance.reference().child("employees");
 //final databaseReference = FirebaseDatabase.instance.reference();


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Ajira chap chap Employees',
        theme: ThemeData(
         // fontFamily: "Brand Bold",
          primarySwatch: Colors.indigo,
        ),
      initialRoute: MainScreen.idScreen,
     //  initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen: MainScreen.idScreen,
        //initialRoute: MainScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          ProfessionScreen.idScreen: (context) => ProfessionScreen(),
          ProfessionScreen.idScreen: (context) => ProfessionScreen(),

//test

        },
        debugShowCheckedModeBanner: false,
      //  home: RegistrationScreen(),
      ),
    );
  }
}
