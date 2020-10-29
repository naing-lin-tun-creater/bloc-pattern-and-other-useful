import 'package:bloc_pattern_app/pages/post_pages/post_page.dart';
import 'package:bloc_pattern_app/pages/post_pages/post_page_one.dart';
import 'package:bloc_pattern_app/use_my_bloc.dart';
import 'package:bloc_pattern_app/use_setstate.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Go Each Lesson "),
      ),
      
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            child: RaisedButton(
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UseSetState()));
              },
              child: Text("Use setState"),
            ),
          ),

          Container(
            margin: EdgeInsets.all(12.0),
            child: RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBloc()));
              },
              child: Text("My bloc"),
            ),
          ),

          Container(
            margin: EdgeInsets.all(12.0),
            child: RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostPage()));
              },
              child: Text("Post Page (use setState)"),
            ),
          ),

          Container(
            margin: EdgeInsets.all(12.0),
            child: RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostPageOne()));
              },
              child: Text("Post Page (use Bloc Pattern)"),
            ),
          )
        ],
      ),
    );
  }
}
