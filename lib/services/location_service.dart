import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location service disabled');
      }
    }

    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception('Permission denied');
      }
    }

    return await _location.getLocation();
  }
}
