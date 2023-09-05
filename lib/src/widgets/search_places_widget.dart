import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import '../providers/api_provider.dart';

class SearchPlacesWidget extends StatelessWidget {
  const SearchPlacesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    // final mapProvider = Provider.of<MapProvider>(context);

    return SearchAnchor.bar(
      barElevation: MaterialStateProperty.all(3),
      viewElevation: 4,
      isFullScreen: false,
      viewHintText: 'Busca una direccion',
      barHintText: 'Busca una direccion',
      searchController: apiProvider.searchController,
      viewTrailing: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            apiProvider.searchPlaces(apiProvider.searchController.text);
          },
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            apiProvider.searchController.clear();
          },
        ),
      ],
      suggestionsBuilder: (context, controller) async {
        if (controller.text.isEmpty) {
          return List.empty();
        }

        final List<AutocompletePrediction> list = await apiProvider.searchPlaces(controller.text);
        
        return List<Widget>.generate(
          list.length,
          (int index) {
            return ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(list[index].fullText),
              onTap: () async {
                controller.text = list[index].fullText;

                final latLng = await apiProvider.getLatLngFromPlaceId(list[index].placeId);

                apiProvider.getGasStations(latLng);

                controller.closeView(controller.text);
              },
            );
          },
        );
      },
    );
  }
}