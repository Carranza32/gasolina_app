import 'package:flutter/material.dart';
import 'package:gasolina_app/responsive.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:gasolina_app/src/models/gas_type_model.dart';
import 'package:gasolina_app/src/providers/api_provider.dart';
import 'package:gasolina_app/src/screens/detail_screen.dart';
import 'package:gasolina_app/src/widgets/gas_list_tile_no_animation_widget.dart';
import 'package:gasolina_app/src/widgets/gas_list_tile_widget.dart';
import 'package:gasolina_app/src/widgets/search_places_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
        title: const Text('Gasolina sv'),
      ),
      body: Responsive(
        mobile: _listContent(stations, apiProvider),
        tablet: _listContent(stations, apiProvider),
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

  Widget _listContent(List<GasContent> stations, ApiProvider apiProvider){
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child:  SearchPlacesWidget(),
        ),

        const SizedBox(height: 20),

        _buildFilterGas(apiProvider),

        const SizedBox(height: 20),

        (apiProvider.isLoading == false) ? Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16,),
            itemCount: stations.length,
            itemBuilder: (context, index) {
              return GasListTile(gas: stations[index]);
            },
          ),
        ) : const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget _buildFilterGas(ApiProvider apiProvider){
    return SegmentedButton<GasTypeModel>(
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

        _buildFilterGas(apiProvider),

        const SizedBox(height: 20),

        (apiProvider.isLoading == false) ? Expanded(
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
