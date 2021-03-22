import 'dart:async';
import 'package:device_manager/Backend/device.dart';

class DeviceBloc {
  Device _device;

  final _deviceStateController = StreamController<Device>();
  StreamSink<Device> get _inDevice => _deviceStateController.sink;
  Stream<Device> get device =>
      _deviceStateController.stream.asBroadcastStream();

  final _deviceEventController = StreamController<DeviceEvent>();
  Sink<DeviceEvent> get deviceEventSink => _deviceEventController.sink;

  DeviceBloc(this._device) {
    _deviceEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(DeviceEvent event) {
    if (event is UpdateDevice) {
      _device = event._newDevice;
      _inDevice.add(_device);
    }
  }

  void close() {
    _deviceEventController.close();
    _deviceStateController.close();
  }
}

abstract class DeviceEvent {}

class UpdateDevice extends DeviceEvent {
  Device _newDevice;

  UpdateDevice(this._newDevice);

  Device get device => _newDevice;
}
