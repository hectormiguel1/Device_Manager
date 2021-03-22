import 'package:device_manager/UI/device_card.dart';
import 'package:device_manager/models/device_model.dart';
import 'package:device_manager/models/devices_model.dart';
import 'package:flutter/material.dart';
import 'Backend/device.dart';
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
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
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
        child: StreamBuilder<List<Device>>(
            stream: foundDeviceBloc.devices,
            initialData: [],
            builder: (context, devices) {
              if (!devices.hasData || devices.data!.isEmpty) {
                return Text('Connect Device to get Started!');
              } else {
                return Column(
                  children: [
                    ...devices.data!
                        .map((device) => DeviceCard(device))
                        .toList()
                  ],
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => foundDeviceBloc.eventSink.add(RefreshDevices()),
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
