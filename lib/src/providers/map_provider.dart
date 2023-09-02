import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  late GoogleMapController mapController;
  CameraPosition initialPosition = const CameraPosition(target: LatLng(13.7013016, -89.226707), zoom: 14);
  Set<Marker> markers = {};
  late Position position;

  void onMapCreated(GoogleMapController controller){
		// ignore: no_leading_underscores_for_local_identifiers
		Completer<GoogleMapController> _mapCompleter = Completer();
		_mapCompleter.complete(controller);
		mapController = controller;

    notifyListeners();
  }

  void moveCamera(LatLng position){
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: 14)));
  }

  
}