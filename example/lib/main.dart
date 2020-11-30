import 'package:flutter/material.dart';
import 'package:idkit_stepper/idkit_stepper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("步进器测试"),
      ),
      body: Container(
        child: Column(children: [
          Row(
            children: [
              IDKitStepper(
                width: 200,
                height: 50,
                step: 1,
                isFloat: false,
                text: "10",
                maxValue: 20,
                minValue: -10,
                border: Border.all(
                  color: Colors.black38,
                  width: 1,
                ),
                plusChild: Container(
                  child: Icon(
                    Icons.add,
                    size: 50,
                  ),
                ),
                reduceChild: Container(
                  child: Icon(
                    Icons.remove,
                    size: 50,
                  ),
                ),
                dividerChild1: Container(
                  width: 1,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          IDKitStepper.routineBuild(
            width: 200,
            height: 50,
            style: TextStyle(
              color: Colors.red,
            ),
            plusStyle: TextStyle(
              color: Colors.pink,
              fontSize: 20,
            ),
            borderRadius: 6,
            type: ContourType.rightSides,
          ),
        ]),
      ),
    );
  }
}
