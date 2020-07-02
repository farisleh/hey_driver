import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'tabscreen1.dart';
import 'tabscreen2.dart';
import 'tabscreen3.dart';
import 'tabscreen4.dart';
import 'tabscreen5.dart';

class MainScreen extends StatefulWidget {
 const MainScreen({Key key,this.user, this.googleSignIn}) : super(key: key);
 final FirebaseUser user;
 final GoogleSignIn googleSignIn;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs;

  int currentTabIndex = 0;

final FirebaseAuth firebaseauth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();



    


  @override
  void initState() {
    super.initState();
    tabs = [
      Tabscreen1(email:widget.user.email),
      Tabscreen2(email:widget.user.email),
      Tabscreen3(email:widget.user.email),
      Tabscreen4(email:widget.user.email),
      Tabscreen5(user: widget.user,googleSignIn: googleSignIn,),
    ];
  }


  String $pagetitle = "Hey Driver";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        //backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shutter_speed),
            title: Text("Mileage"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build, ),
            title: Text("Service"),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station, ),
            title: Text("Petrol"),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta, ),
            title: Text("Information"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, ),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}


