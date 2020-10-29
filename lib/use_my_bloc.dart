import 'package:bloc_pattern_app/my_stream_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MyBloc extends StatefulWidget {
  @override
  _MyBloc createState() => _MyBloc();
}

class _MyBloc extends State<MyBloc> {
  var controllerNumOne = TextEditingController();
  var controllerNumTwo = TextEditingController();
  double sum = 0;

  MyStreamBloc myStreamBloc;//null

  String data = "";
  String streamCode = "";
  fetchFileData() async {
    String responseText;
    String streamText;
    responseText = await rootBundle.loadString('textFiles/use_my_bloc.txt');
    streamText = await rootBundle.loadString('textFiles/my_stream_bloc.txt');

    setState(() {
      data = responseText;
      streamCode = streamText;
    });
  }


  @override
  void initState() {
    fetchFileData();
    super.initState();
    myStreamBloc = MyStreamBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myStreamBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),

      body: StreamBuilder(
        stream: myStreamBloc.getStream(),
        builder: (context,AsyncSnapshot<double> snapshot){
        return ListView(
          children: [
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0),
              child: TextField(
                controller: controllerNumOne,
                decoration: InputDecoration(
                    labelText: "Enter first number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
              ),
            ),

            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0),
              child: TextField(
                controller: controllerNumTwo,
                decoration: InputDecoration(
                    labelText: "Enter Second number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
              ),
            ),

            SizedBox(height: 20,),
            Container(
              margin:EdgeInsets.only(left: 20.0,right: 20.0),
              child: RaisedButton(
                child: Text("Add"),
                onPressed: (){
                  double num1 = double.parse(controllerNumOne.text);
                  double num2 = double.parse(controllerNumTwo.text);

                  // setState(() {
                  //   sum = num1 + num2;
                  // });

                  myStreamBloc.doSum(num1, num2);
                },
              ),
            ),

            SizedBox(height: 20,),

            Center(
              child: Text(snapshot.data==null?"Result":snapshot.data.toString(),style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(left: 20.0,top: 20.0),
              child: Text("use_my_bloc.dart",style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,

              ),),
            ),

            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Text(
                data,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),


            Container(
              margin: EdgeInsets.only(left: 20.0,top: 20.0),
              child: Text("my_stream_bloc.dart",style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,

              ),),
            ),

            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Text(
                streamCode,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            )



          ],
        );
      },),
    );
  }
}
