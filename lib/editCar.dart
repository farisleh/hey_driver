import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class EditCar extends StatefulWidget {
  EditCar(
      {this.plate,
      this.brand,
      this.model,
      this.roadtax,
      this.manufacture,
      this.transmission,
      this.cc,
      this.type,
      this.fuel,
      this.seat,
      this.index});

  String plate;
  String brand;
  String model;
  String roadtax;
  String manufacture;
  String transmission;
  String cc;
  String type;
  String fuel;
  String seat;
  final index;
  @override
  _EditCarState createState() => new _EditCarState();
}

class _EditCarState extends State<EditCar> {
  TextEditingController controllerPlate;
  TextEditingController controllerBrand;
  TextEditingController controllerModel;
  TextEditingController controllerRoadTax;
  TextEditingController controllerManufacture;
  TextEditingController controllerTransmission;
  TextEditingController controllerCC;
  TextEditingController controllerType;
  TextEditingController controllerFuel;
  TextEditingController controllerSeat;

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

  void _editTask() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
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

    plate = widget.plate;
    brand = widget.brand;
    model = widget.model;
    roadtax = widget.roadtax;
    manufacture = widget.manufacture;
    transmission = widget.transmission;
    cc = widget.cc;
    type = widget.type;
    fuel = widget.fuel;
    seat = widget.seat;

    controllerPlate = new TextEditingController(text: widget.plate);
    controllerBrand = new TextEditingController(text: widget.brand);
    controllerModel = new TextEditingController(text: widget.model);
    controllerRoadTax = new TextEditingController(text: widget.roadtax);
    controllerManufacture = new TextEditingController(text: widget.manufacture);
    controllerTransmission =
        new TextEditingController(text: widget.transmission);
    controllerCC = new TextEditingController(text: widget.cc);
    controllerType = new TextEditingController(text: widget.type);
    controllerFuel = new TextEditingController(text: widget.fuel);
    controllerSeat = new TextEditingController(text: widget.seat);
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
                    "Car Information",
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
          ListTile(
            title: Text(
              'License Plate Number',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: TextField(
              controller: controllerPlate,
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
              controller: controllerBrand,
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
              controller: controllerModel,
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
              controller: controllerRoadTax,
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
              controller: controllerManufacture,
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
              controller: controllerTransmission,
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
              controller: controllerCC,
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
              controller: controllerType,
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
              controller: controllerFuel,
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
              controller: controllerSeat,
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
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
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
