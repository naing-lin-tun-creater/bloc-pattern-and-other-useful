import 'dart:convert';
import 'package:bloc_pattern_app/model/Response.dart';
import 'package:bloc_pattern_app/pages/post_pages/post_bloc_one.dart';
import 'package:bloc_pattern_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class PostPageOne extends StatefulWidget {
  @override
  _PostPageOneState createState() => _PostPageOneState();
}

class _PostPageOneState extends State<PostPageOne> {
  PostBlocOne postBlocOne;

  String data = "";

  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString('textFiles/post_page.txt');

    setState(() {
      data = responseText;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFileData();
    postBlocOne = PostBlocOne();
    postBlocOne.getData();
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
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  "post_page.dart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  data,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<Response>(
                  stream: postBlocOne.postStream(),
                  initialData: Response(myState: MyState.loading, data: null),
                  builder: (context, snapshot) {
                    if (snapshot.data.myState == MyState.loading) {
                       return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data.myState == MyState.data) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              children: [
                                Text("UserId" +
                                    snapshot.data.data[index]["userId"]
                                        .toString()),
                                Text("Id" +
                                    snapshot.data.data[index]["id"].toString()),
                                Text("Title" +
                                    snapshot.data.data[index]["title"]
                                        .toString()),
                                Text("Body" +
                                    snapshot.data.data[index]["body"]
                                        .toString())
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    }else if(snapshot.data.myState == MyState.error) {
                      return Center(
                        child: Text(snapshot.data.data),
                      );
                    }
                  }),
            ],
          ),
        ));
  }
}
