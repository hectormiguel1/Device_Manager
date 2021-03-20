import 'package:device_manager/Backend/device.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatefulWidget {
  final Device? _device;
  DeviceCard(this._device);

  _DeviceCardState createState() => _DeviceCardState(_device!);
}

class _DeviceCardState extends State<DeviceCard> {
  final Device _device;

  _DeviceCardState(this._device);

  Widget drawSection(
    String section,
  ) {
    return SizedBox(
        height: 20,
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              section + ":",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              sectionToData(section),
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ));
  }

  String sectionToData(String section) {
    switch (section) {
      case 'Name':
        return _device.name;
      case 'Model':
        return _device.model;
      case 'Serial':
        return _device.serial;
      case 'OS Version':
        return _device.osVer;
      case 'Patch Level':
        return _device.patchLevelString;
      case 'Type':
        return _device.deviceType.toString();
      case 'Status':
        return _device.status;
      case 'Authorized':
        return _device.authorized.toString();
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.all(20),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: const EdgeInsets.all(20),
            elevation: 20,
            child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  print("Tapped");
                },
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Stack(children: [
                        Icon(Icons.smartphone, size: 150),
                        Positioned.fill(
                            child: Align(
                                alignment: Alignment.center,
                                child: _device.authorized
                                    ? Icon(Icons.check_circle,
                                        color: Colors.green, size: 50)
                                    : Icon(Icons.cancel,
                                        color: Colors.red, size: 50)))
                      ]),
                      Column(
                          children: Device.sections
                              .map((section) => drawSection(section))
                              .toList())
                    ])))));
  }
}
