import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_page/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/auth/signup.dart';
import 'package:login_page/auth/forgot_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences prefs;
  bool isValidEmail(String emailVal) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailVal);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 0), () => navigateUser(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'ParkingOps',
                  style: TextStyle(fontFamily: 'montserrat1', fontSize: 30),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: loginController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPass()),
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontFamily: 'montserrat'),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontFamily: 'montserrat1'),
                  ),
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: loginController.text,
                              password: passwordController.text);
                      prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', true);
                      prefs.setString('email', loginController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                      Fluttertoast.showToast(
                        msg: "Login successsful!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } on FirebaseAuthException catch (e) {
                      passwordController.clear();
                      Fluttertoast.showToast(
                        msg: "Invalid username or password!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Do not have an account?',
                      style: TextStyle(fontFamily: 'montserrat'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Text(
                        'Sign Up',
                        style:
                            TextStyle(fontFamily: 'montserrat', fontSize: 17),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signup()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;

    if (status) {
      // Map userMap = jsonDecode(prefs.getString('user'));
      // Users user = Users.fromJson(userMap);
      // user = await getuserdocDetails(user.userId);
      // print("Token-$token");
      // Provider.of<UserProfileProvider>(context, listen: false).updateUser(user);

      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    } else {
      // Navigator.pushReplacementNamed(context, "/signup_option");
    }
  }
}
