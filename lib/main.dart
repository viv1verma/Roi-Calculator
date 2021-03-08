//import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simpple Interest",
    home: SIform(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,

    )
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIformState();
  }
}
class SIformState extends State<SIform> {
  var formKey = GlobalKey<FormState>();
  var currencies = ['Rupees', 'Dollar', 'Euros', 'Pound'];
  var currentItamSelected = 'Dollar';
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult ='';
  @override
  Widget build(BuildContext context) {

    //TextStyle textstyle =Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
            title: Text("Simple Interest"),),
        body: Form(
          key: formKey,
            child: ListView(children: <Widget>[
          getImageAsset(),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
                controller: principalController,
              validator: (String value){
                if(value.isEmpty){
                  return 'Please Enter Value';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter Principal e.g. 2000',
                  errorStyle: TextStyle(
                    color: Colors.yellow
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: roiController,
              validator: (String value){
                if(value.isEmpty){
                  return 'Please Enter Value';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Rate Of Interest',
                  hintText: 'In Percentage',
                  errorStyle: TextStyle(
                      color: Colors.yellow
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(7.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: termController,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please Enter Value';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'In Years',
                        errorStyle: TextStyle(
                            color: Colors.yellow
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Container(width: 25.5),
                Expanded(
                    child: DropdownButton<String>(
                  items: currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: currentItamSelected,
                  onChanged: (String newValueSelected) {
                    setState(() {
                        this.currentItamSelected = newValueSelected;
                    });
                  },
                )),
              ])),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: Row(children: <Widget>[
              Expanded(
                  child: RaisedButton(
                      child: Text('Calculate'),
                      color: Colors.deepPurple,
                      onPressed: () {
                        setState(() {
                          if(formKey.currentState.validate()) {
                            this.displayResult = calculate();
                          }
                        });
                      })
              ),
              Container(width: 15.0),
              Expanded(
                child: RaisedButton(child: Text('Reset'),
                    onPressed: () {
                  setState(() {
                    reset();
                  });

                    }),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.0, left: 40),
            child: Text(this.displayResult),
          )
        ])));
  }
  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/paisa.jpg');
    Image image = Image(image: assetImage, width: 250.0, height: 250.0);
    return Container(
        child: image,
        margin: EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0));
  }
  String calculate(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmount = principal + (principal*roi*term)/100;

    String result = 'After $term years your Investment will be $totalAmount $currentItamSelected';
    return result;
  }
  void reset(){
    principalController.text='';
    roiController.text='';
    termController.text='';
    displayResult='';
    currentItamSelected=currencies[0];
  }
}
