import 'dart:convert';
import 'package:bloc_pattern_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  List<Map<String,dynamic>> listdata = [];

  String data = "";

  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString('textFiles/post_page.txt');

    setState(() {
      data = responseText;
    });
  }


  getData() async{
    await http.get(POST_LINK).then((res){
      if(res.statusCode==200){
        List<dynamic> list = json.decode(res.body);

        // listdata=list.map((value){
        //   Map<String,dynamic> map = Map();
        //   map["userId"] = value["userId"];
        //   map["id"] = value["id"];
        //   map["title"] = value["title"];
        //   map["body"] = value["body"];
        //   return map;
        // });


        //
        list.forEach((value) {
          Map<String,dynamic> map = Map();
          map["userId"] = value["userId"];
          map["id"] = value["id"];
          map["title"] = value["title"];
          map["body"] = value["body"];

          setState(() {
            listdata.add(map);
          });

        });
      }else{
      print("error");
      }

    });
  }


  @override
  void initState() {
    super.initState();
    fetchFileData();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
      ),
      // ignore: missing_return
      body: SingleChildScrollView(
        child: Column(
         children: [
           SizedBox(height: 20,),
           Container(
             margin: EdgeInsets.only(left: 20.0),
             child: Text("post_page.dart",style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 20.0,
             ),),
           ),

           SizedBox(height: 20,),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 20.0),
             decoration: BoxDecoration(border: Border.all(color: Colors.black)),
             margin: EdgeInsets.only(left: 20.0),
             child: Text(data,style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 20.0,
             ),),
           ),

           SizedBox(height: 20,),
           ListView.builder(itemBuilder: (BuildContext context,int index){
             return Card(
               child: Column(
                 children: [
                   Text("UserId" + listdata[index]["userId"].toString()),
                   Text("Id" + listdata[index]["id"].toString()),
                   Text("Title" + listdata[index]["title"].toString()),
                   Text("Body" + listdata[index]["body"].toString())
                 ],
               ),
             );
           },itemCount: listdata.length,
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
           ),
         ],
        ),
      )
    );
  }
}
