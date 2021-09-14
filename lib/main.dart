import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutteruber/AllScreens/registerationScreen.dart';
import 'package:flutteruber/AllScreens/loginScreen.dart';
import 'package:flutteruber/AllScreens/mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutteruber/DataHandler/appData.dart';
import 'package:provider/provider.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Taxi Rider App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,

        ),

        initialRoute: MainScreen.idScreen,
        routes:
        {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),

        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
