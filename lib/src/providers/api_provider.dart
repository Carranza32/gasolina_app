
import 'dart:io';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_type_model.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

const _apiKey = "AIzaSyAz_yMOu8UrZEBiwwqQnB0oM3h1xtQyH3Y";

class ApiProvider with ChangeNotifier {
  GasModel _gasModel = GasModel();
  GasModel get gasModel => _gasModel;

	List<GasContent> _gasList = [];
	List<GasContent> get gasstations => _gasList;

  GasContent _gasSelected = GasContent();
  GasContent get gasSelected => _gasSelected;

  GasTypeModel _gasTypeSelected = GasTypeModel.especial;
  GasTypeModel get gasTypeSelected => _gasTypeSelected;

  set gasTypeSelected(GasTypeModel gasType) {
    _gasTypeSelected = gasType;
    notifyListeners();
  }

  set gasSelected(GasContent gas) {
    _gasSelected = gas;
    notifyListeners();
  }

  final SearchController _searchController = SearchController();
  SearchController get searchController => _searchController;

	ApiProvider(){
    print("ApiProvider");
		getGasStations(const LatLng(lat: 13.965225, lng: -89.561480));
	}

	Future<void> getGasStations(LatLng position) async {
		final response = await http.get(
			Uri.parse("http://localhost:8181/api/v1/gasolineras/location/${position.lat}/${position.lng}?distance=10&page=1&size=10"),
			headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      }
		);

		if (response.statusCode == HttpStatus.ok) {
      GasModel gasModel = GasModel.fromJson(json.decode(response.body));

      _gasModel = gasModel;
      _gasList = gasModel.content ?? [];
		} else {
			throw Exception('Failed to load data');
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
}