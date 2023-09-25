import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLonController extends ValueNotifier<LatLng?> {
  LatLonController({LatLng? value}) : super(value);


  _change(LatLng value) {
    this.value = value;
    notifyListeners();
  }
}

class MapPicker extends StatefulWidget {
  const MapPicker({super.key, required this.controller});

  final LatLonController controller;

  @override
  State<MapPicker> createState() => MapPickerState();
}

class MapPickerState extends State<MapPicker> {
  final Completer<GoogleMapController> _controllerMap = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.156068, 71.434634),
    zoom: 14.4746,
  );


  _onTap(LatLng latLng) {
    widget.controller._change(latLng);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (context, value, child) {
              return GoogleMap(
                mapType: MapType.hybrid,
                onTap: _onTap,
                onMapCreated: (controller) {
                  _controllerMap.complete(controller);
                },
                initialCameraPosition: _kGooglePlex,
                markers: value == null? {}: {
                  Marker(
                    markerId: MarkerId('Ваша текущая позиция'),
                    position: value,
                  ),
                },
              );
            }
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: _goToTheLake,
                child: const Icon(Icons.location_on),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controllerMap.future;


    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        )));
      }
    }

  }
}