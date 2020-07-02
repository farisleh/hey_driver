import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditMileage extends StatefulWidget {
  EditMileage(
      {this.mileage, this.mileagedate, this.mileagelog, this.car, this.index});

  final String car;
  final String mileage;
  final String mileagelog;
  final String mileagedate;
  final index;
  @override
  _EditMileageState createState() => new _EditMileageState();
}

class _EditMileageState extends State<EditMileage> {
  TextEditingController controllerCar;
  TextEditingController controllerMileage;
  TextEditingController controllerMileagelog;

  DateTime _mileageDate = new DateTime.now();
  String _dateText = '';

  String car = '';
  String mileage = '';
  String mileagelog = '';

  void _editTask() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "car": car,
        "mileage": mileage,
        "mileagedate": _dateText,
        "mileagelog": mileagelog,
      });
    });

    Navigator.pop(context);
  }

  Future<Null> _selectMileageDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _mileageDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _mileageDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _dateText =
        "${_mileageDate.day}/${_mileageDate.month}/${_mileageDate.year}";

    car = widget.car;
    mileage = widget.mileage;
    mileagelog = widget.mileagelog;

    controllerCar = new TextEditingController(text: widget.car);
    controllerMileage = new TextEditingController(text: widget.mileage);
    controllerMileagelog = new TextEditingController(text: widget.mileagelog);
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
                    "Mileage Details",
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
                controller: controllerMileage,
                onChanged: (String str) {
                  setState(() {
                    mileage = str;
                  });
                },
                decoration: new InputDecoration(
                    icon: Icon(Icons.shutter_speed),
                    hintText: "Mileage",
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
                  "Mileage Date",
                  style: new TextStyle(fontSize: 22.0, color: Colors.black),
                )),
                new FlatButton(
                    onPressed: () => _selectMileageDate(context),
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
                controller: controllerMileagelog,
                onChanged: (String str) {
                  setState(() {
                    mileagelog = str;
                  });
                },
                decoration: new InputDecoration(
                    icon: Icon(Icons.info),
                    hintText: "Mileage Log",
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
