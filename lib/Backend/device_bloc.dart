import 'dart:async';
import 'package:device_manager/Backend/init.dart';

import 'device_event.dart';
import 'device.dart';

class DeviceBloc {
  List<Device> _devices = [];

  final _deviceStateController = StreamController<List<Device>>();
  StreamSink<List<Device>> get _inDevices => _deviceStateController.sink;

  Stream<List<Device>> get devices => _deviceStateController.stream;

  final _deviceEventController = StreamController<DeviceEvent>();
  Sink<DeviceEvent> get deviceEventSink => _deviceEventController.sink;

  DeviceBloc() {
    _deviceEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(DeviceEvent event) {
    if (event is AddDeviceEvent || event is UpdateDevicesEvent) {
      detectDevices().then((devices) {
        _devices = devices;
        if (devices.isEmpty) {
          _inDevices.add([]);
        } else {
          _devices.forEach((element) {
            getDevProps(element).then((onValue) {
              _inDevices.add(_devices);
            });
          });
        }
      });
    }
  }

  void dispose() {
    _deviceEventController.close();
    _deviceStateController.close();
  }
}
