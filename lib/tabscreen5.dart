import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hey_driver/main.dart';

class Tabscreen5 extends StatefulWidget {
  Tabscreen5({this.user, this.googleSignIn, this.email});
  final String email;
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _Tabscreen5State createState() => new _Tabscreen5State();
}

class _Tabscreen5State extends State<Tabscreen5> {
  void _signOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 215.0,
              child: new Column(
                children: <Widget>[
                  Expanded(
                    child: new Image.network(widget.user.photoUrl),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Sign Out??",
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                  new Divider(),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          widget.googleSignIn.signOut();
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePage()));
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.check),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                            ),
                            Text("Yes")
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.close),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                            ),
                            Text("Cancel")
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));
    return Scaffold(
      body: Container(
        height: 250,
        width: 480,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(children: <Widget>[
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: new NetworkImage(widget.user.photoUrl),
                      fit: BoxFit.cover)),
            ),
            new Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Welcome",
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      new Text(
                        widget.user.displayName,
                        style:
                            new TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ]),
              ),
            ),
            new IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30.0),
              onPressed: () {
                _signOut();
              },
            ),
          ]),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: new AssetImage("assets/images/profile.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
