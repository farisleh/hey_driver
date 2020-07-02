import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditService extends StatefulWidget {
  EditService(
      {this.car,
      this.service,
      this.servicedate,
      this.servicelog,
      this.cost,
      this.index});

  final String car;
  final String service;
  final String cost;
  final String servicelog;
  final String servicedate;
  final index;
  @override
  _EditServiceState createState() => new _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  TextEditingController controllerCar;
  TextEditingController controllerService;
  TextEditingController controllerCost;
  TextEditingController controllerServicelog;

  DateTime _serviceDate = new DateTime.now();
  String _dateText = '';

  String car = '';
  String service = '';
  String cost = '';
  String servicelog = '';

  void _editTask() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "car": car,
        "service": service,
        "cost": cost,
        "servicedate": _dateText,
        "servicelog": servicelog,
      });
    });

    Navigator.pop(context);
  }

  Future<Null> _selectServiceDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _serviceDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _serviceDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _dateText =
        "${_serviceDate.day}/${_serviceDate.month}/${_serviceDate.year}";

    car = widget.car;
    service = widget.service;
    cost = widget.cost;
    servicelog = widget.servicelog;

    controllerCar = new TextEditingController(text: widget.car);
    controllerService = new TextEditingController(text: widget.service);
    controllerCost = new TextEditingController(text: widget.cost);
    controllerServicelog = new TextEditingController(text: widget.servicelog);
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
                  "Service Details",
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
              controller: controllerService,
              onChanged: (String str) {
                setState(() {
                  service = str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.build),
                  hintText: "Service",
                  border: InputBorder.none),
              style: new TextStyle(fontSize: 22.0, color: Colors.black)),
        ),
        new Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
              controller: controllerCost,
              onChanged: (String str) {
                setState(() {
                  cost = str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.attach_money),
                  labelText: 'Cost',
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
                "Service Date",
                style: new TextStyle(fontSize: 22.0, color: Colors.black),
              )),
              new FlatButton(
                  onPressed: () => _selectServiceDate(context),
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
              controller: controllerServicelog,
              onChanged: (String str) {
                setState(() {
                  servicelog = str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.info),
                  hintText: "Service Log",
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
    )));
  }
}
