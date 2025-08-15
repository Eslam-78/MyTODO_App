import 'dart:math';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';

class LocationService {
  final Location _location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  BuildContext? _context;
  Function(String)? _onSuggestion;

  // ✅ أضفنا هذه الخريطة لتتبع حالة الدخول لكل موقع
  final Map<String, bool> _geofenceStates = {}; // تتبع حالة كل geofence

  LocationService({BuildContext? context, Function(String)? onSuggestion}) {
    _context = context;
    _onSuggestion = onSuggestion;
  }

  Future<void> initGeofencing() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        _checkGeofence(currentLocation.latitude!, currentLocation.longitude!);
      }
    });
  }

  // ✅ عدلنا منطق التحقق من geofence بالكامل
  void _checkGeofence(double currentLat, double currentLng) {
    final now = DateTime.now();
    final hour = now.hour;

    final List<Map<String, dynamic>> geofences = [
      {
        'identifier': 'home',
        'latitude': 15.411090,
        'longitude': 44.167584,
        'radius': 500,
        'condition': hour >= 19,
        'message': S.of(_context!).geoHomeMessage,
      },
      {
        'identifier': 'work',
        'latitude': 15.412345,
        'longitude': 44.165000,
        'radius': 400,
        'condition': hour >= 8 && hour <= 14,
        'message': S.of(_context!).geoWorkMessage,
      },
      {
        'identifier': 'gym',
        'latitude': 15.4154323,
        'longitude': 44.168000,
        'radius': 300,
        'condition': hour >= 17 && hour <= 20,
        'message': S.of(_context!).geoGymMessage,
      },
    ];

    for (final geofence in geofences) {
      final String id = geofence['identifier']; // ✅ تعيين معرف الموقع
      final distance = _calculateDistance(currentLat, currentLng, geofence['latitude'], geofence['longitude']);

      // ✅ تحقق إذا المستخدم الآن داخل النطاق
      final bool isInside = distance <= geofence['radius'] && geofence['condition'];
      // ✅ احصل على الحالة السابقة (هل كان داخل النطاق مسبقاً؟)
      final bool wasInside = _geofenceStates[id] ?? false;

      // ✅ إذا دخل الآن ولم يكن سابقًا، أرسل إشعارًا مرة واحدة
      if (isInside && !wasInside) {
        _geofenceStates[id] = true; // تحديث الحالة إلى "داخل"

        if (_onSuggestion != null) {
          _onSuggestion!(geofence['message']);
        }
      }

      // ✅ إذا خرج من النطاق، نعيد تعيين الحالة
      if (!isInside && wasInside) {
        _geofenceStates[id] = false; // تحديث الحالة إلى "خارج"
      }
    }
  }

  // حساب المسافة باستخدام صيغة Haversine
  double _calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371000;
    final phi1 = lat1 * pi / 180;
    final phi2 = lat2 * pi / 180;
    final deltaPhi = (lat2 - lat1) * pi / 180;
    final deltaLambda = (lon2 - lon1) * pi / 180;

    final a =
        sin(deltaPhi / 2) * sin(deltaPhi / 2) + cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }
}
