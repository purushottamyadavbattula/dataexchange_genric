import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/": (context) => AskDataFromAndroid(),
      },
    );
  }
}

class AskDataFromAndroid extends StatefulWidget {
  @override
  _AskDataFromAndroidState createState() => _AskDataFromAndroidState();
}

class _AskDataFromAndroidState extends State<AskDataFromAndroid> {
  String _dataFromFlutter = "Android can ping you";
  static const platform = const MethodChannel('AndySample/test');
  Future<void> _getDataFromAdnroid() async {
    print("calling for data");
    String data;
    try {
      final String result = await platform.invokeMethod(
          'test', {"data": "Call me flutter"}); //sending data from flutter here
      data = result;
    } on PlatformException catch (e) {
      data = "Android is not responding please check the code";
    }

    setState(() {
      _dataFromFlutter = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter data exchange example"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              Text(_dataFromFlutter),
              RaisedButton(
                onPressed: _getDataFromAdnroid,
                child: Text("Ask android"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
