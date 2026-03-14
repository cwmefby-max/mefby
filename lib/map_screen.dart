
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;
  Location location = Location();
  LocationData? currentLocation;
  static const String _markerImageSourceId = 'marker-source';
  static const String _markerLayerId = 'marker-layer';

  @override
  void initState() {
    super.initState();
    _getLocationAndSetupMap();
  }

  Future<void> _getLocationAndSetupMap() async {
    final locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });
    _centerMapOnLocation();
  }

  void _onMapCreated(MapboxMap controller) {
    mapboxMap = controller;
    _centerMapOnLocation();
  }

  void _centerMapOnLocation() {
    if (currentLocation != null && mapboxMap != null) {
      final point = Point(
        coordinates: Position(
          currentLocation!.longitude!,
          currentLocation!.latitude!,
        ),
      );
      mapboxMap!.flyTo(
        CameraOptions(
          center: point,
          zoom: 15,
          pitch: 60,
        ),
        MapAnimationOptions(duration: 2000),
      );
      _addMarkerAtLocation(point);
    }
  }

  Future<void> _addMarkerAtLocation(Point location) async {
    final pointJson = {
      'type': 'Feature',
      'geometry': location.toJson(),
      'properties': {},
    };

    final sourceExists = await mapboxMap!.style.styleSourceExists(_markerImageSourceId);
    if (!sourceExists) {
      final geoJsonSource = GeoJsonSource(id: _markerImageSourceId, data: json.encode(pointJson));
      await mapboxMap!.style.addSource(geoJsonSource);
    } else {
      final source = await mapboxMap!.style.getSource(_markerImageSourceId) as GeoJsonSource;
      source.updateGeoJSON(json.encode(pointJson));
    }

    final layerExists = await mapboxMap!.style.styleLayerExists(_markerLayerId);
    if (!layerExists) {
      final circleLayer = CircleLayer(
        id: _markerLayerId,
        sourceId: _markerImageSourceId,
        circleColor: Colors.red.toARGB32(),
        circleRadius: 8.0,
        circleStrokeWidth: 2.0,
        circleStrokeColor: Colors.white.toARGB32(),
      );
      await mapboxMap!.style.addLayer(circleLayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            key: const ValueKey("mapWidget"),
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            top: 40,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Go to Welcome'),
            ),
          ),
        ],
      ),
    );
  }
}
