import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/place_search_model.dart';
import 'package:provider/provider.dart';

import '../providers/api_provider.dart';

class SearchPlacesWidget extends StatelessWidget {
  const SearchPlacesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return SearchAnchor.bar(
      barElevation: MaterialStateProperty.all(0),
      isFullScreen: true,
      viewHintText: 'Search for a gas station',
      searchController: apiProvider.searchController,
      barBackgroundColor: MaterialStateProperty.all(const Color(0xffe5eadc)),
      viewBackgroundColor: const Color(0xffe5eadc),
      viewTrailing: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
          },
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
          },
        ),
      ],
      suggestionsBuilder: (context, controller) {
        apiProvider.searchPlaces(controller.text);

        final List<PlaceSearchModel> list = apiProvider.places;
        
        return List<Widget>.generate(
          list.length,
          (int index) {
            return ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(list[index].description),
            );
          },
        );
      },
    );
  }
}