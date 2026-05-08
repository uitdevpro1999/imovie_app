import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract interface class LocationService {
  Future<String> getCurrentAddress();

  Future<LocationAddress> getCurrentLocationAddress();
}

class LocationAddress {
  const LocationAddress({required this.shortLabel, required this.fullLabel});

  final String shortLabel;
  final String fullLabel;

  static String shortestLabel(String value) {
    final parts = value
        .split(',')
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
    if (parts.length <= 2) {
      return value.trim();
    }

    return parts.take(2).join(', ');
  }
}

class DeviceLocationService implements LocationService {
  const DeviceLocationService();

  @override
  Future<String> getCurrentAddress() async {
    final address = await getCurrentLocationAddress();
    return address.shortLabel;
  }

  @override
  Future<LocationAddress> getCurrentLocationAddress() async {
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
      final coordinates =
          '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}';
      return LocationAddress(shortLabel: coordinates, fullLabel: coordinates);
    }

    return _formatPlacemark(places.first);
  }

  LocationAddress _formatPlacemark(Placemark place) {
    final fullParts =
        [
              place.street,
              place.subLocality,
              place.locality,
              place.subAdministrativeArea,
              place.administrativeArea,
              place.country,
            ]
            .whereType<String>()
            .map((part) => part.trim())
            .where((part) => part.isNotEmpty)
            .toSet()
            .toList(growable: false);

    final shortParts =
        [
              place.subAdministrativeArea,
              place.locality,
              place.administrativeArea,
              place.country,
            ]
            .whereType<String>()
            .map((part) => part.trim())
            .where((part) => part.isNotEmpty)
            .toSet()
            .toList(growable: false);

    final fullLabel = fullParts.join(', ');
    final shortLabel = shortParts.isEmpty
        ? LocationAddress.shortestLabel(fullLabel)
        : shortParts.take(2).join(', ');
    return LocationAddress(shortLabel: shortLabel, fullLabel: fullLabel);
  }
}
