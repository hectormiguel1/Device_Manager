import 'dart:async';
import 'package:device_manager/Backend/device.dart';
import 'package:device_manager/Backend/process.dart';

class FoundDevicesBloc {
  Map<String, Device> _devices = Map();

  final _stateController = StreamController<List<Device>>();
  StreamSink<List<Device>> get _inState => _stateController.sink;
  Stream<List<Device>> get devices => _stateController.stream;

  final _eventController = StreamController<FoundDeviceEvent>();
  Sink<FoundDeviceEvent> get eventSink => _eventController.sink;

  FoundDevicesBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(FoundDeviceEvent event) {
    if (event is RefreshDevices) {
      _refreshDevices();
    }
  }

  void _refreshDevices() {
    _devices.clear();
    detectDevices().then((_newDevices) {
      if (_newDevices.isEmpty) {
        _devices.clear();
        _inState.add([]);
      } else {
        _newDevices.forEach((device) {
          _devices[device.serial] = device;
        });
      }
      _inState.add(_devices.values.toList());
    });
  }

  void close() {
    _stateController.close();
    _eventController.close();
  }
}

abstract class FoundDeviceEvent {}

class RefreshDevices extends FoundDeviceEvent {}

// class FoundDeviceModel extends ChangeNotifier {
//   List<DeviceModel> _devices = [];

//   UnmodifiableListView<DeviceModel> get devices =>
//       UnmodifiableListView(_devices);

//   void add(DeviceModel newDevice) {
//     if (!_devices.contains(newDevice)) {
//       _devices.add(newDevice);
//       notifyListeners();
//     }
//   }

//   void addAll(List<DeviceModel> newDevices) {
//     if (newDevices.isEmpty) {
//       removeAll();
//     }
//     newDevices.forEach((element) {
//       if (!_devices.contains(element)) {
//         _devices.add(element);
//         notifyListeners();
//       }
//     });
//   }

//   void remove(DeviceModel device) {
//     if (_devices.contains(device)) {
//       _devices.remove(device);
//       notifyListeners();
//     }
//   }

//   void removeAll() {
//     _devices.clear();
//     notifyListeners();
//   }

//   void fetchDevices() {
//     detectDevices();
//   }

//   void updateDevice(FoundDeviceModel newModel) {
//     _devices = newModel._devices;
//     notifyListeners();
//   }

//   String toString() {
//     return 'Found Device Model: \n' +
//         _devices.map((element) => element.toString()).toString();
//   }
// }
