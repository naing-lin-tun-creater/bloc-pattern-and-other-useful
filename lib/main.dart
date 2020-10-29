import 'package:bloc_pattern_app/home_buttom_for_lession.dart';
import 'package:bloc_pattern_app/my_stream_bloc.dart';
import 'package:bloc_pattern_app/pages/post_pages/post_page.dart';
import 'package:bloc_pattern_app/use_my_bloc.dart';
import 'package:bloc_pattern_app/use_setstate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    // home: UseSetState(),
    // home: MyBloc(),
    // home: PostPage(),
    home: HomeButton(),
  ));
}


