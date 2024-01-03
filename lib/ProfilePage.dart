import 'package:flutter/material.dart';
import 'package:login_page/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  profilestate createState() => profilestate();
}

class profilestate extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String name;
  String email;
  @override
  void initState() async {
    await firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      name = "USER NAME   :   " + value.data()["User name"];
    });
    await firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      email = "USER EMAIL   :   " + value.data()["User email"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // The following comments contain some unused code which could be helpful in reading data from Cloud Firestore

    fetchdata() {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('users');
      collectionReference.snapshots().listen((snapshot) {
        setState(() {
          // name = snapshot.docs[firebaseUser.uid].data()["User name"];
        });
      });
    }

    Future<String> getData() async {
      final User user = FirebaseAuth.instance.currentUser;
      final String uid = user.uid.toString();
      return uid;
    }

    Stream<DocumentSnapshot> getUserStream() async* {
      final uid = await getData();
      print(uid);
      yield* FirebaseFirestore.instance.doc("Users/$uid").snapshots();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          // title: Text('CODE SHINOBIS',style: TextStyle(fontFamily: 'painter'))
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'USER PROFILE',
                      style: TextStyle(
                          fontFamily: 'montserrat1',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Customer',
                      style: TextStyle(fontFamily: 'montserrat', fontSize: 20),
                    )),
                SizedBox(height: 10),
                Text(name != null ? name : 'USER NAME   :   UserXYZ'),
                SizedBox(height: 10),
                Text(email != null
                    ? email
                    : 'USER EMAIL   :   UserXYZ@gmail.com'),
                Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.black)),
                        textColor: Colors.white,
                        color: Colors.black,
                        child: Text('Log out',
                            style: TextStyle(fontFamily: 'montserrat1')),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs?.setBool("isLoggedIn", false);
                          prefs.remove('email');
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        })),
              ],
            )));
  }
}
