import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'editPetrol.dart';

class Tabscreen3 extends StatefulWidget {
  Tabscreen3({this.user, this.googleSignIn, this.email});
  final String email;
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _Tabscreen3State createState() => new _Tabscreen3State();
}

class _Tabscreen3State extends State<Tabscreen3> {
  DateTime _petrolDate = new DateTime.now();
  String _dateText = '';

  String car = '';
  String petrolcost = '';
  String petrollog = '';

  Future<Null> _selectPetrolDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _petrolDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _petrolDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _addPetrol() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('petrol');
      await reference.add({
        "email": widget.email,
        "car": car,
        "petrolcost": petrolcost,
        "petroldate": _dateText,
        "petrollog": petrollog,
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _dateText = "${_petrolDate.day}/${_petrolDate.month}/${_petrolDate.year}";
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
          padding: const EdgeInsets.fromLTRB(0.0, 230.0, 0.0, 1.0),
          child: new Stack(children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection("petrol")
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

                return new PetrolList(
                  document: snapshot.data.documents,
                );
              },
            )
          ]),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: new AssetImage("assets/images/petrol.jpeg"),
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
          SizedBox(height: 352),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext bc) {
          return Container(
            child: ListView(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                        car = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.drive_eta),
                        labelText: 'License Car Plate',
                        border: InputBorder.none),
                    style: new TextStyle(fontSize: 17.0, color: Colors.black54),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                        petrolcost = str;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.local_gas_station),
                        labelText: 'Petrol Cost',
                        hintText: "RM",
                        border: InputBorder.none),
                    style: new TextStyle(fontSize: 17.0, color: Colors.black54),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Icon(Icons.date_range),
                      ),
                      new Expanded(
                        child: Text("Date",
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.black54)),
                      ),
                      new FlatButton(
                          onPressed: () => _selectPetrolDate(context),
                          child: Text(_dateText,
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.black54))),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                        petrollog = str;
                      });
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.previous,
                    maxLines: 2,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.info),
                        hintText: "Mileage Log",
                        border: InputBorder.none),
                    style: new TextStyle(fontSize: 17.0, color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.check, size: 40.0),
                          onPressed: () {
                            _addPetrol();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 40.0),
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

class PetrolList extends StatelessWidget {
  PetrolList({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String car = document[i].data['car'].toString();
        String petrolcost = document[i].data['petrolcost'].toString();
        String petroldate = document[i].data['petroldate'].toString();
        String petrollog = document[i].data['petrollog'].toString();

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
                      leading: Icon(Icons.calendar_today, color: Colors.red),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new EditPetrol(
                                    car: car,
                                    petrolcost: petrolcost,
                                    petroldate: petroldate,
                                    petrollog: petrollog,
                                    index: document[i].reference,
                                  )));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      title: Text(
                        petroldate,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("RM" + petrolcost),
                    ),
                  ),
                  actions: <Widget>[],
                  secondaryActions: <Widget>[
                    IconSlideAction(
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
