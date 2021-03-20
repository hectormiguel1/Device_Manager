import 'dart:io';
import 'dart:async';
import 'device.dart';

String currentPlatform = Platform.operatingSystem;
String commandPathPrefix = "";
bool applicationRunning = true;
bool isDeviceAttached = false;

void initPath() async {
  switch (currentPlatform) {
    case 'linux':
      {
        commandPathPrefix += "./linux_tools/";
        break;
      }
    case 'macos':
      {
        commandPathPrefix += "./macos_tools/";
        break;
      }
    case 'windows':
      {
        commandPathPrefix += ".\\windows_tools\\";
        break;
      }
  }
}

Future<List<Device>> detectDevices() async {
  List<Device> _detectedDevices = [];
  //Check Android Devices
  var process = await Process.run('adb', ['devices', '-l']);
  var devStrings = process.stdout.toString().split("\n")
    ..removeAt(0)
    ..removeWhere((element) => element == "");
  List<List<String>> parsedStrings = [];
  devStrings.forEach((element) {
    var result = element.split(" ")..removeWhere((element) => element == "");
    parsedStrings.add(result);
  });

  parsedStrings.forEach((element) {
    var identifier = element[0];
    var status = element[1];
    if (status != "unauthorized") {
      var name = element[3].split(':')[1];
      var model = element[4].split(':')[1];
      _detectedDevices.removeWhere((element) => element.serial == identifier);
      _detectedDevices.add(Device(
        authorized: true,
        name: name,
        status: status,
        serial: identifier,
        model: model,
        deviceType: DeviceType.Android,
      ));
    } else {
      _detectedDevices
          .add(Device(authorized: false, serial: identifier, status: status));
    }
  });
  return _detectedDevices;
  //Check Apple_Device
}

Future<void> getDevProps(Device targetDevice) async {
  await Process.run('adb', [
    '-s',
    targetDevice.serial,
    'shell',
    'getprop',
    'ro.build.version.release'
  ]).then((result) {
    var osString = result.stdout.toString();
    var osStringSplit = osString.split('\n');
    targetDevice.setOSString(osStringSplit[0]);
  });
  await Process.run('adb', [
    '-s',
    targetDevice.serial,
    'shell',
    'getprop',
    'ro.build.version.security_patch'
  ]).then((result) {
    var stdotString = result.stdout.toString();
    var stdOutStringSplit = stdotString.split('\n');
    targetDevice.setPatchLevelString(stdOutStringSplit[0]);
  });
}

String getCurrentPlatform() => currentPlatform;
String getCommandPath() => commandPathPrefix;
