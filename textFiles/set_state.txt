import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class UseSetState extends StatefulWidget {
  @override
  _UseSetStateState createState() => _UseSetStateState();
}

class _UseSetStateState extends State<UseSetState> {
  var controllerNumOne = TextEditingController();
  var controllerNumTwo = TextEditingController();
  double sum = 0;
  String data = "";

  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString('textFiles/set_state.txt');

    setState(() {
      data = responseText;
    });
  }

  @override
  void initState() {
    fetchFileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              controller: controllerNumOne,
              decoration: InputDecoration(
                  labelText: "Enter first number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              controller: controllerNumTwo,
              decoration: InputDecoration(
                  labelText: "Enter Second number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: RaisedButton(
              child: Text("Add"),
              onPressed: () {
                double num1 = double.parse(controllerNumOne.text);
                double num2 = double.parse(controllerNumTwo.text);

                setState(() {
                  sum = num1 + num2;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              sum.toString(),
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Text(
              data,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
