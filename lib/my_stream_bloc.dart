 import 'dart:async';

import 'package:flutter/material.dart';

class MyStreamBloc{

  StreamController<double> controller = StreamController();

  Stream<double> getStream(){
    return controller.stream;
  }

  doSum(double num1,double num2){
    double result = num1 + num2;
    controller.sink.add(result);
  }

  void dispose(){
    controller.close();
  }
}