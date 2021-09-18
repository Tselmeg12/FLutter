import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteruber/AllScreens/mainScreen.dart';
import 'package:flutteruber/AllScreens/registerationScreen.dart';
import 'package:flutteruber/AllWidgets/progressDialog.dart';
import 'package:flutteruber/main.dart';


class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 45.0,),

              SizedBox(height: 15.0,),
              Text(
                "Login as a Rider",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,

              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 1.0,),
                      TextField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,

                          ),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 1.0,),
                      TextField(
                        controller: passwordTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,

                          ),
                        ),
                        style: TextStyle(fontSize: 14.0),

                      ),

                      SizedBox(height: 1.0,),
                      RaisedButton(
                          color: Colors.yellow,
                          textColor: Colors.white,
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0),
                          ),
                          onPressed: ()
                          {
                              if(!emailTextEditingController.text.contains("@"))
                                {
                                  displayToastMessage("Email addres is not valid", context);

                                }
                              else if(passwordTextEditingController.text.isEmpty)
                                {
                                  displayToastMessage("Password be at lease 6 character", context);
                                }
                              else {
                                loginAuthenticateUser(context);
                              }
                          },

                      ),

                    ],
                  )
              ),
              FlatButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Do not we have account Register here",
                ),
              ),

            ],
          ),
        ),
      ),
    );


  }
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  void  loginAuthenticateUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
        return ProgressDialog(message: "Authentication, Please wait....",);
      }
    );
    final User firebaseUser = (await _firebaseAuth
          .signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text
      ).catchError((errMsg) {
        Navigator.pop(context);
        displayToastMessage("Error" + errMsg.toString(), context);

      })).user;
    if(firebaseUser != null)
    {

      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {

        if(snap.value != null)
          {

            Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
            displayToastMessage("you are logged in now", context);
          }


        else

          {
            _firebaseAuth.signOut();
            Navigator.pop(context);
            displayToastMessage("No record there ", context);
          }

      });
    }
    else
  {
    displayToastMessage("Error occured", context);

    Navigator.pop(context);
  }
  }
}
