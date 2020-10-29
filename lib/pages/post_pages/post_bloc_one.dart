
import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern_app/model/Response.dart';
import 'package:bloc_pattern_app/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class PostBlocOne {

  List<Map<String,dynamic>> listdata = [];

  StreamController<Response> postController = StreamController();

  Stream<Response> postStream() => postController.stream;


  getData() async{
    Response response = Response(myState: MyState.loading,data: null);
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
          listdata.add(map);
        });
        
        //postController.sink.add(listdata);
        response.myState = MyState.data;
        response.data =listdata;
        postController.sink.add(response);
      }else{
        response.myState = MyState.error;
        response.data ="Data Fetching Error";
        postController.sink.add(response);
      }

    }).catchError((e){
      response.myState = MyState.error;
      response.data ="Data Fetching Error";
      postController.sink.add(response);
    });
  }

  void dispose(){
    postController.close();
  }

}