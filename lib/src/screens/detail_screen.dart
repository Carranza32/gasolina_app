import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:gasolina_app/src/providers/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final GasModel gas;

  DetailsScreen({required this.gas});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
		final DateFormat formatter = DateFormat('dd-MM-yyyy');

    final controller = Provider.of<MapProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            elevation: 4,
						pinned: true,
            floating: false,
            title: Text(gas.marca ?? ""),
            flexibleSpace: FlexibleSpaceBar(
              background: _mapHeader(controller),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _heroHeader(),

							_dateHeader(formatter),

							_priceList(),

							_comoLlegar(context),
            ]),
          ),
        ],
      )
    );
  }

  Widget _mapHeader(controller){
    Set<Marker> markers = {};
    LatLng position = LatLng(gas.location!.y, gas.location!.x);
    CameraPosition initialPosition = CameraPosition(target: position, zoom: 14);

    markers.add(Marker(
      markerId: MarkerId(gas.id ?? ""),
      position: position,
    ));

		return GoogleMap(
      onMapCreated: controller.onMapCreated,
      initialCameraPosition: initialPosition,
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
    );
	}

	Widget _heroHeader(){
		return Hero(
			tag: gas.id ?? "",
			child: Container(
				padding: const EdgeInsets.all(15),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.start,
					mainAxisSize: MainAxisSize.min,
					children: [
						SizedBox(
							height: 80,
							width: 80,
							child: ClipRRect(
								borderRadius: BorderRadius.circular(10),
								child: Image(
                  image: AssetImage("assets/gasolineras/${gas.marca}.png"),
                ),
							),
						),
						const SizedBox(width: 15),
						Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisSize: MainAxisSize.min,
							children: [
								Flexible(
									child: Text(gas.estacion ?? "", style: const TextStyle(
										color: Color(0xff1e2338),
										fontSize: 23,
										fontWeight: FontWeight.bold
									)),
								),
								const SizedBox(height: 10),
								Row(
									children: [
										const Icon(Icons.place_outlined, size: 14),
										const SizedBox(width: 10),
										Text(gas.departamento ?? "", style: const TextStyle(
											fontSize: 13,
											color: Color(0xff1e2338)
										)),
									],
								)
							],
						)
					],
				),
			),
		);
	}

	Widget _actions(context, size){
		return SizedBox(
			width: size.width * 1,
			child: Row(
				children: [
					ElevatedButton.icon(
						style: ButtonStyle(
							backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
							shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
						),
						icon: Icon(Icons.near_me_outlined, color: Theme.of(context).primaryColor ),
						label: const Text("Mostrar dirección", style: TextStyle(color: Color(0xff1e2338))),
						onPressed: () {
							MapsLauncher.launchCoordinates(gas.location!.y, gas.location!.x);
						},
					)
				],
			),
		);
	}

	Widget _comoLlegar(context) {
		return Container(
			margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
			child: ElevatedButton(
				style: ButtonStyle(
					backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
					shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
				),
				onPressed: () {
					MapsLauncher.launchCoordinates(gas.location!.y, gas.location!.x);
				},
				child: const Padding(
					padding: EdgeInsets.symmetric(vertical: 10),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Icon(Icons.near_me_outlined, color: Colors.white,),
							SizedBox(width: 15),
							Text("Cómo llegar", style: TextStyle(color: Colors.white),)
						],
					),
				),
			),
		);
	}

	Widget _dateHeader(formatter){
		return Padding(
			padding: const EdgeInsets.only(left: 12),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						padding: const EdgeInsets.all(12),
						child: const Text("Última actualización:", style: TextStyle(
							fontWeight: FontWeight.w500,
						)),
					),
					ActionChip(
						labelPadding: const EdgeInsets.symmetric(horizontal: 16),
						label: Text(timeago.format(gas.precio!.fecha, locale: 'es'), style: const TextStyle(
							color: Colors.white,
						)),
						backgroundColor: const Color(0xff1e2338),
						elevation: 2,
						onPressed: () {},
					)
				],
			),
		);
	}

	Widget _priceList(){
		List<Widget> lista = [];
		
		gas.precio!.toJson().forEach((key, value) => {
			if (value != null && key != 'fecha') {
				lista.add(ListTile(
					title: Text(key),
					trailing: Text('\$ $value'),
				))
			}
		});

		return Column(
			children: lista,
		);
	}
}