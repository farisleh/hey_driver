import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPetrol extends StatefulWidget {
  EditPetrol(
      {this.car, this.petrolcost, this.petroldate, this.petrollog, this.index});

  final String car;
  final String petrolcost;
  final String petroldate;
  final String petrollog;
  final index;
  @override
  _EditPetrolState createState() => new _EditPetrolState();
}

class _EditPetrolState extends State<EditPetrol> {
  TextEditingController controllerCar;
  TextEditingController controllerPetrolcost;
  TextEditingController controllerPetrollog;

  DateTime _petrolDate = new DateTime.now();
  String _dateText = '';

  String car = '';
  String petrolcost = '';
  String petrollog = '';

  void _editTask() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "car": car,
        "petrolcost": petrolcost,
        "petroldate": _dateText,
        "petrollog": petrollog,
      });
    });

    Navigator.pop(context);
  }

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

  @override
  void initState() {
    super.initState();

    _dateText = "${_petrolDate.day}/${_petrolDate.month}/${_petrolDate.year}";

    car = widget.car;
    petrolcost = widget.petrolcost;
    petrollog = widget.petrollog;

    controllerCar = new TextEditingController(text: widget.car);
    controllerPetrolcost = new TextEditingController(text: widget.petrolcost);
    controllerPetrollog = new TextEditingController(text: widget.petrollog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover),
                color: Colors.blue),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Petrol Details",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                        fontFamily: "BalooBhaina2"),
                  ),
                  Icon(
                    Icons.list,
                    color: Colors.white,
                    size: 30.0,
                  )
                ]),
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                controller: controllerCar,
                onChanged: (String str) {
                  setState(() {
                    car = str;
                  });
                },
                decoration: new InputDecoration(
                    icon: Icon(Icons.drive_eta),
                    hintText: "License Car Plate",
                    border: InputBorder.none),
                style: new TextStyle(fontSize: 22.0, color: Colors.black)),
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                controller: controllerPetrolcost,
                onChanged: (String str) {
                  setState(() {
                    petrolcost = str;
                  });
                },
                decoration: new InputDecoration(
                    icon: Icon(Icons.local_gas_station),
                    labelText: 'Petrol Cost',
                    hintText: 'RM',
                    border: InputBorder.none),
                style: new TextStyle(fontSize: 22.0, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: new Icon(Icons.date_range),
                ),
                new Expanded(
                    child: Text(
                  "Petrol Date",
                  style: new TextStyle(fontSize: 22.0, color: Colors.black),
                )),
                new FlatButton(
                    onPressed: () => _selectPetrolDate(context),
                    child: Text(
                      _dateText,
                      style: new TextStyle(fontSize: 22.0, color: Colors.black),
                    )),
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                controller: controllerPetrollog,
                onChanged: (String str) {
                  setState(() {
                    petrollog = str;
                  });
                },
                decoration: new InputDecoration(
                    icon: Icon(Icons.info),
                    hintText: "Petrol Log",
                    border: InputBorder.none),
                style: new TextStyle(fontSize: 22.0, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text('Save'),
                  color: Colors.green,
                  onPressed: () {
                    _editTask();
                  },
                ),
                RaisedButton(
                  child: Text('Close'),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
