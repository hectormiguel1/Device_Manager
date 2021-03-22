import 'package:device_manager/Backend/device.dart';
import 'package:device_manager/UI/expanded_view.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final Device _device;

  DeviceCard(this._device);

  Widget drawSection(String section, Device device) {
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
              sectionToData(section, device),
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ));
  }

  String sectionToData(String section, Device device) {
    switch (section) {
      case 'Name':
        return device.name;
      case 'Model':
        return device.model;
      case 'Serial':
        return device.serial;
      case 'OS Version':
        return device.osVer;
      case 'Patch Level':
        return device.patchLevelString;
      case 'Type':
        return device.deviceType.toString();
      case 'Status':
        return device.status;
      case 'Authorized':
        return device.authorized.toString();
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
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ExpandedView(_device))),
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
                            .map((section) => drawSection(section, _device))
                            .toList())
                  ])))),
    );
  }
}
