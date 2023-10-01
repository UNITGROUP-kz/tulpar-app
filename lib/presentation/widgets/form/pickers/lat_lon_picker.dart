import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/widgets/buttons/elevated_button.dart';
import 'package:garage/presentation/widgets/buttons/outlined_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../routing/router.dart';
import '../../navigation/back_button.dart';

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


  _onTap() {
    context.router.push(const SplashRouter(
      children: [
        PickerRouter(
          children: [
            MapPickerRoute()
          ]
        )
      ]
    )).then((value) {
      if(value != null) {
        widget.controller._change(value as LatLng);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        return OutlinedButtonWidget(
          onPressed: _onTap,
          child: Text(
            value == null? 'Выберите точку на карте' : 'Изменить точку на карте',
          ),
        );
      }
    );
  }
}


@RoutePage<LatLng?>()
class MapPickerScreen extends StatefulWidget {

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  GoogleMapController? _controllerMap;
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(43.260850, 76.905760),
    zoom: 14
  );
  LatLng? value;

  _onTap(LatLng latLng) {
    setState(() {
      value = latLng;
    });
  }

  _goToTheLake() async {
    _controllerMap?.animateCamera(CameraUpdate.newCameraPosition(await _getCurrentPosition()));
  }

  Future<CameraPosition> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      value = LatLng(position.latitude, position.longitude);
      _cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
    });
    return _cameraPosition;
  }

  _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.denied;
  }

  _onMapCreated(GoogleMapController controller) async {
    _controllerMap = controller;
    await _goToTheLake();
  }

  _submit() {
    context.router.pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onTap: _onTap,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _cameraPosition,
            markers: value == null? {}: {
              Marker(
                markerId: MarkerId('Ваша текущая позиция'),
                position: value!,
              ),
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: FloatingActionButton(
                onPressed: _goToTheLake,
                child: const Icon(Icons.location_on),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: BackButtonWidget(),
            ),
          ),
          if(value != null ) Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                child: ElevatedButtonWidget(
                  onPressed: _submit,
                  child: Text('Выбрать'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}