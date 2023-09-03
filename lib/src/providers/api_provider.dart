
import 'dart:io';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_type_model.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const _apiKey = "AIzaSyAz_yMOu8UrZEBiwwqQnB0oM3h1xtQyH3Y";
const _baseUrl = "https://gasolina-sv-api-7a96453f3504.herokuapp.com/api/v1/gasolineras";

class ApiProvider with ChangeNotifier {
  GasModel _gasModel = GasModel();
  GasModel get gasModel => _gasModel;

  LatLng _initialPosition = const LatLng(lat: 13.965225, lng: -89.561480);
  LatLng get position => _initialPosition;

	List<GasContent> _gasList = [];
	List<GasContent> get gasstations => _gasList;

  GasContent _gasSelected = GasContent();
  GasContent get gasSelected => _gasSelected;

  GasTypeModel _gasTypeSelected = GasTypeModel.especial;
  GasTypeModel get gasTypeSelected => _gasTypeSelected;

  final SearchController _searchController = SearchController();
  SearchController get searchController => _searchController;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final PagingController<int, GasContent> _pagingController = PagingController(firstPageKey: 0);
  PagingController<int, GasContent> get pagingController => _pagingController;

  int _page = 0;
  int get page => _page;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set page(int page) {
    _page = page;
    notifyListeners();
  }

  set gasTypeSelected(GasTypeModel gasType) {
    _gasTypeSelected = gasType;
    notifyListeners();
  }

  set initialPosition(LatLng position) {
    _initialPosition = position;
    notifyListeners();
  }

  set gasSelected(GasContent gas) {
    _gasSelected = gas;
    notifyListeners();
  }

	ApiProvider(){
    _pagingController.addPageRequestListener((pageKey) {
      getGasStations(_initialPosition, pageKey: pageKey);
    });
	}

	Future<void> getGasStations(LatLng position, {pageKey = 0}) async {
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOiIyMDUwLTA4LTMxVDEwOjQ2OjQ3WiJ9.azjOWqEmeDTG7vsnYHeteONaRCOLKEKFUF21EF0XMmI";

		try {
		  final response = await http.get(
        Uri.parse("$_baseUrl/location/${position.lat}/${position.lng}?distance=10&page=$pageKey&size=20"),
        headers: {
          'Authorization': 'Bearer $token',
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        }
      );

      if (response.statusCode == HttpStatus.ok) {
        GasModel gasModel = GasModel.fromJson(json.decode(response.body));
        _gasModel = gasModel;

        final isLastPage = _gasModel.last ?? false;

        if (isLastPage) {
          _pagingController.appendLastPage(_gasModel.content ?? []);
        } else {
          final nextPageKey = pageKey + _gasModel.content?.length;

          _pagingController.appendPage(_gasModel.content ?? [], nextPageKey);
        }
      }
		} catch (error) {
			_pagingController.error = error;
		}
		notifyListeners();
	}

  Future<List<AutocompletePrediction>> searchPlaces(String parameter) async {
    final places = FlutterGooglePlacesSdk(_apiKey);

    final predictions = await places.findAutocompletePredictions(parameter, countries: ['sv']);

    return predictions.predictions;
	}

  Future<LatLng> getLatLngFromPlaceId(String placeId) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey';
    
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      
      final double lat = location['lat'];
      final double lng = location['lng'];

      return LatLng(lat: lat, lng: lng);
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  Future<String> getPlaceNameFromLatLng(LatLng position) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.lat},${position.lng}&key=$_apiKey';
    
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final address = data['results'][0]['formatted_address'];
      
      return address;
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
		LocationPermission permission;

		// Test if location services are enabled.
		// ignore: unused_local_variable
		serviceEnabled = await Geolocator.isLocationServiceEnabled();
		if (!serviceEnabled) {
		  // Location services are not enabled don't continue
		  // accessing the position and request users of the 
		  // App to enable the location services.
		  return Future.error('Location services are disabled.');
		}

		permission = await Geolocator.checkPermission();

		if (permission == LocationPermission.denied) {
			permission = await Geolocator.requestPermission();
			if (permission == LocationPermission.denied) {
				// Permissions are denied, next time you could try
				// requesting permissions again (this is also where
				// Android's shouldShowRequestPermissionRationale 
				// returned true. According to Android guidelines
				// your App should show an explanatory UI now.
				return Future.error('Location permissions are denied');
			}
		}
		
		if (permission == LocationPermission.deniedForever) {
		// Permissions are denied forever, handle appropriately. 
			return Future.error('Location permissions are permanently denied, we cannot request permissions.');
		}

		Position position;

		try {
      position = await Geolocator.getCurrentPosition();
		} catch (e) {
			if (kIsWeb) {
			  position = await Geolocator.getCurrentPosition();
			} else {
        position = (await Geolocator.getLastKnownPosition())!;
			}
		}

    notifyListeners();

		return position;
  }
}