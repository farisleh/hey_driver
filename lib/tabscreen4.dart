import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'editCar.dart';

class Tabscreen4 extends StatefulWidget {
  Tabscreen4({this.user, this.googleSignIn, this.email});
  final String email;
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _Tabscreen4State createState() => new _Tabscreen4State();
}

class _Tabscreen4State extends State<Tabscreen4> {
  String plate = '';
  String brand = '';
  String model = '';
  String roadtax = '';
  String manufacture = '';
  String transmission = '';
  String cc = '';
  String type = '';
  String fuel = '';
  String seat = '';

  void _addMileage() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('car');
      await reference.add({
        "email": widget.email,
        "plate": plate,
        "brand": brand,
        "model": model,
        "roadtax": roadtax,
        "manufacture": manufacture,
        "transmission": transmission,
        "cc": cc,
        "type": type,
        "fuel": fuel,
        "seat": seat,
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));
    return Scaffold(
      body: Container(
        height: 780,
        width: 500,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 232.0, 0.0, 1.0),
          child: new Stack(children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection("car")
                  .where("email", isEqualTo: widget.email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                return new CarList(
                  document: snapshot.data.documents,
                );
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _settingModalBottomSheet(context);
            },
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 355),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 600,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'License Plate Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        plate = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Brand',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        brand = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Model',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        model = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Roadtax Period',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        roadtax = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Year Of Manufacture',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        manufacture = str;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Transmission',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        transmission = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Engine Capacity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        cc = str;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Vehicle Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        type = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Fuel Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        fuel = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Number Of Seat',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: TextField(
                    onChanged: (String str) {
                      setState(() {
                        seat = str;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Unspecified',
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('Save'),
                          color: Colors.green,
                          onPressed: () {
                            _addMileage();
                          },
                        ),
                        RaisedButton(
                          child: Text('Close'),
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                )
              ],
            ),
          );
        });
  }
}

class CarList extends StatelessWidget {
  CarList({this.document, this.car});
  final DocumentSnapshot car;
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String plate = document[i].data['plate'].toString();
        String brand = document[i].data['brand'].toString();
        String model = document[i].data['model'].toString();
        String roadtax = document[i].data['roadtax'].toString();
        String manufacture = document[i].data['manufacture'].toString();
        String transmission = document[i].data['transmission'].toString();
        String cc = document[i].data['cc'].toString();
        String type = document[i].data['type'].toString();
        String fuel = document[i].data['fuel'].toString();
        String seat = document[i].data['seat'].toString();

        return new Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.drive_eta, color: Colors.red),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new EditCar(
                                    plate: plate,
                                    brand: brand,
                                    model: model,
                                    roadtax: roadtax,
                                    manufacture: manufacture,
                                    transmission: transmission,
                                    cc: cc,
                                    type: type,
                                    fuel: fuel,
                                    seat: seat,
                                    index: document[i].reference,
                                  )));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      title: Text(
                        plate,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(brand + " " + model),
                    ),
                  ),
                  actions: <Widget>[],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      key: new Key(document[i].documentID),
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => {
                        Firestore.instance.runTransaction((transaction) async {
                          DocumentSnapshot snapshot =
                              await transaction.get(document[i].reference);
                          await transaction.delete(snapshot.reference);
                        })
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
