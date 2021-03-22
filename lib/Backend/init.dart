import 'dart:io';

import 'package:device_manager/models/devices_model.dart';

String currentPlatform = Platform.operatingSystem;
String commandPathPrefix = "";
bool applicationRunning = true;
bool isDeviceAttached = false;
final foundDeviceBloc = new FoundDevicesBloc();

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

String getCurrentPlatform() => currentPlatform;
String getCommandPath() => commandPathPrefix;
