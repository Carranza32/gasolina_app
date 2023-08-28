import 'package:flutter/material.dart';
import 'package:gasolina_app/responsive.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:gasolina_app/src/models/gas_type_model.dart';
import 'package:gasolina_app/src/providers/api_provider.dart';
import 'package:gasolina_app/src/screens/detail_screen.dart';
import 'package:gasolina_app/src/widgets/gas_list_tile_no_animation_widget.dart';
import 'package:gasolina_app/src/widgets/gas_list_tile_widget.dart';
import 'package:gasolina_app/src/widgets/search_places_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    final apiProvider = Provider.of<ApiProvider>(context);
    final List<GasContent> stations = apiProvider.gasstations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gasolina App'),
      ),
      body: Responsive(
        mobile: _listContentNoAnimation(stations, apiProvider),
        tablet: _listContentNoAnimation(stations, apiProvider),
        desktop: Row(
          children: [
            Expanded(
              // flex: _size.width > 1340 ? 3 : 5,
              flex: 6,
              child: _listContentNoAnimation(stations, apiProvider),
            ),
            Expanded(
              // flex: _size.width > 1340 ? 8 : 10,
              flex: 9,
              child: (apiProvider.gasSelected.id != null) ? DetailsScreen(gas: apiProvider.gasSelected) : _buildEmptyDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyDetails(){
    return const Center(
      child: Text("Selecciona una gasolinera"),
    );
  }

  Widget _listContent(List<GasContent> stations){
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child:  SearchPlacesWidget(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: stations.length,
            itemBuilder: (context, index) {
              return GasListTile(stations: stations, index: index);
            },
          ),
        ),
      ],
    );
  }

  Widget _listContentNoAnimation(List<GasContent> stations, apiProvider){
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child:  SearchPlacesWidget(),
        ),

        const SizedBox(height: 20),

        SegmentedButton<GasTypeModel>(
          segments: const <ButtonSegment<GasTypeModel>> [
            ButtonSegment<GasTypeModel>(
              value: GasTypeModel.especial,
              label: Text('Especial'),
            ),
            ButtonSegment<GasTypeModel>(
              value: GasTypeModel.regular,
              label: Text('Regular'),
            ),
            ButtonSegment<GasTypeModel>(
              value: GasTypeModel.diesel,
              label: Text('Diesel'),
            ),
            ButtonSegment<GasTypeModel>(
              value: GasTypeModel.iondiesel,
              label: Text('Ion Diesel'),
            ),
          ],
          selected: <GasTypeModel>{ apiProvider.gasTypeSelected },
          onSelectionChanged: (Set<GasTypeModel> newSelection) {
            apiProvider.gasTypeSelected = newSelection.first;
          },
        ),

        const SizedBox(height: 20),

        (stations.length > 0) ? Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16,),
            itemCount: stations.length,
            itemBuilder: (context, index) {
              return GasListTileNoAnimationWidget(gas: stations[index], index: index);
            },
          ),
        ) : const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
