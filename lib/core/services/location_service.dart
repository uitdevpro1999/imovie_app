import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract interface class LocationService {
  Future<String> getCurrentAddress();
}

class DeviceLocationService implements LocationService {
  const DeviceLocationService();

  @override
  Future<String> getCurrentAddress() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw StateError('Location service is disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw StateError('Location permission is denied.');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
      ),
    );
    final places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isEmpty) {
      return '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}';
    }

    return _formatPlacemark(places.first);
  }

  String _formatPlacemark(Placemark place) {
    final parts =
        [
              place.street,
              place.subAdministrativeArea,
              place.administrativeArea,
              place.country,
            ]
            .whereType<String>()
            .map((part) => part.trim())
            .where((part) => part.isNotEmpty)
            .toList(growable: false);

    return parts.join(', ');
  }
}
