import 'dart:io';
import 'package:device_manager/Backend/device.dart';
import 'package:device_manager/Backend/device_bloc.dart';
import 'package:device_manager/Backend/device_event.dart';
import 'package:device_manager/UI/device_card.dart';
import 'package:flutter/material.dart';
import 'Backend/init.dart';

void main() async {
  initPath();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _deviceBloc = DeviceBloc();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Device Manager"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: StreamBuilder<List<Device>>(
            stream: _deviceBloc.devices,
            initialData: [],
            builder:
                (BuildContext context, AsyncSnapshot<List<Device>> snapshot) {
              if (snapshot.data!.isEmpty) {
                return Text("Connect Device to get Started");
              } else {
                var buildWidget = Column(
                    key: GlobalObjectKey(snapshot.data!.length),
                    children: snapshot.data!
                        .map((device) => DeviceCard(device))
                        .toList());
                return buildWidget;
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _deviceBloc.deviceEventSink.add(UpdateDevicesEvent()),
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
