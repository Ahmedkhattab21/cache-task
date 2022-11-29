import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late Future<int> _counter;


  void _incrementCounter() async{
    SharedPreferences _pr= await _prefs;
    int ccounter=(_pr.getInt('counter')??0)+1;
    print("kk${ccounter}");
    setState(() {
      _counter= _pr.setInt('counter', ccounter).then((_) => ccounter);
    });
  }

  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      print(prefs.getInt('counter') ??0);
      return prefs.getInt('counter') ??0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:FutureBuilder(
          future: _counter,
          builder: (BuildContext ctx,AsyncSnapshot asynn)=>
            asynn.connectionState == ConnectionState.waiting ?
            CircularProgressIndicator() :
                Text(
                  '${asynn.data}',
                  style: Theme.of(context).textTheme.headline4,
                )
              ),

        ),
floatingActionButton: FloatingActionButton(
  onPressed: (){
    _incrementCounter();
  },
  child: Icon(Icons.add),
),

    );
  }
}
//
