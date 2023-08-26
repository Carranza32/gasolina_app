
import 'dart:io';
import 'dart:js_interop';

import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_type_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show json;

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

  Future<List<AutocompletePrediction>> searchPlaces(String parameter) async {
    final places = FlutterGooglePlacesSdk('AIzaSyAz_yMOu8UrZEBiwwqQnB0oM3h1xtQyH3Y');

    final predictions = await places.findAutocompletePredictions(parameter, countries: ['sv']);

    return predictions.predictions;
	}
}