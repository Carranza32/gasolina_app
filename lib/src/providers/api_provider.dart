
import 'dart:io';
import 'dart:js_interop';

import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_type_model.dart';
import 'package:gasolina_app/src/models/place_search_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show json;

const _baseUrl = "https://randomuser.me/api/?results=100";

class ApiProvider with ChangeNotifier {
	List<GasModel> _gasList = [];
	List<GasModel> get gasstations => _gasList;

  GasModel _gasSelected = GasModel();
  GasModel get gasSelected => _gasSelected;

  GasTypeModel _gasTypeSelected = GasTypeModel.especial;
  GasTypeModel get gasTypeSelected => _gasTypeSelected;

  set gasTypeSelected(GasTypeModel gasType) {
    _gasTypeSelected = gasType;
    notifyListeners();
  }

  set gasSelected(GasModel gas) {
    _gasSelected = gas;
    notifyListeners();
  }

	List<PlaceSearchModel> _places = [];
	List<PlaceSearchModel> get places => _places;

  final SearchController _searchController = SearchController();
  SearchController get searchController => _searchController;

	ApiProvider(){

		getGasStations();
	}

	Future<void> getGasStations() async {
		// final response = await http.get(
		// 	Uri.parse(_baseUrl),
		// 	// headers: {
		// 	// 	HttpHeaders.authorizationHeader: user.llaveApi ?? ''
		// 	// }
		// );

		// if (response.statusCode == HttpStatus.ok) {
		// 	final data = randomUserModelFromJson( response.body );

		// 	_gasList = data.results!;
		// } else {
		// 	throw Exception('Failed to load data');
		// }

    final String data = await rootBundle.loadString('assets/gasolina_sv_api.json');
    final List<dynamic> jsonRecords = json.decode(data);

    _gasList = jsonRecords
        .map((jsonRecord) => GasModel.fromJson(jsonRecord))
        .toList();

		notifyListeners();
	}

  searchPlaces(String parameter) async {
		if (parameter.trim().isEmpty) {
			
			return;
		}
    
    try {
      final url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$parameter&language=es-419&key=AIzaSyBQRF_5onV316gx07sM9CoKo6onh9S0ngA";

      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode( response.body );
        var predictions = data['predictions'] as List;
        
        _places = predictions.map((jsonRecord) => PlaceSearchModel.fromJson(jsonRecord)).toList();
      }
    } catch (e) {
      return List.empty();
    }
	}
}