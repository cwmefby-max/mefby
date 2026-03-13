import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:location/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController? mapController;
  Location location = Location();
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });
    if (currentLocation != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          15,
        ),
      );
      mapController!.addSymbol(
        SymbolOptions(
          geometry: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          iconImage: 'marker-15',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapboxMap(
            accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN']!,
            styleString: MapboxStyles.DARK,
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 2,
            ),
            onStyleLoadedCallback: () {
                if (mapController != null) {
                  mapController!.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: mapController!.cameraPosition!.target,
                        zoom: mapController!.cameraPosition!.zoom,
                        tilt: 60,
                      ),
                    ),
                  );
                }
            },
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
