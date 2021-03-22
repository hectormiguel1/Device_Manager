enum DeviceType { Android, Apple_Phone, Unknown }

class Device {
  String model;
  String name;
  String osVer;
  String patchLevelString;
  DeviceType deviceType;
  bool authorized;
  String serial;
  String status;

  static List<String> sections = [
    'Name',
    'Model',
    'Serial',
    'OS Version',
    'Patch Level',
    'Type',
    'Status',
    'Authorized'
  ];

  Device(
      {this.model = "",
      this.name = "",
      this.osVer = 'unknown',
      this.serial = "",
      this.status = "",
      this.patchLevelString = "",
      this.deviceType = DeviceType.Unknown,
      this.authorized = false});

  String getModel() => model;
  String getSerial() => serial;
  String getName() => name;
  String getOsVer() => osVer;
  DeviceType getDeviceType() => deviceType;

  @override
  bool operator ==(Object other) {
    if (other is Device) {
      if (this.serial == other.serial) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  String toString() {
    return '\nDevice: \nName: $name\nModel: $model\nSerial: $serial\nType: $deviceType\nOS Version String: $osVer\nPatch Level String: $patchLevelString\nStatus: $status\nAuthorized: $authorized\n';
  }
}
