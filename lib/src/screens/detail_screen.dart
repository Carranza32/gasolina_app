
import 'package:auto_size_text/auto_size_text.dart';
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
  final GasContent gas;

  const DetailsScreen({super.key, required this.gas});

  @override
  Widget build(BuildContext context) {
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
            title: Text(gas.estacion ?? ""),
            flexibleSpace: FlexibleSpaceBar(
              background: _mapHeader(controller),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heroHeader(context),

                    _dateHeader(formatter),

                    const SizedBox(height: 30),

                    const Align(
                      alignment: Alignment.center,
                      child: Text("Servicio completo", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )),
                    ),

                    const SizedBox(height: 5),

                    _priceList(context, "Regular", "Especial", "Diésel", "\$${gas.precio?.regularSc}", "\$${gas.precio?.especialSc}", "\$${gas.precio?.dieselSc}"),

                    const SizedBox(height: 30),

                    const Align(
                      alignment: Alignment.center,
                      child: Text("Auto servicio", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )),
                    ),

                    const SizedBox(height: 5),

                    _priceList(context, "Regular", "Especial", "Diésel", "\$${gas.precio?.regularAuto}", "\$${gas.precio?.especialAuto}", "\$${gas.precio?.dieselAuto}"),

                    _comoLlegar(context),
                  ],
                ),
              )
            ]),
          ),
        ],
      )
    );
  }

  Widget _mapHeader(controller){
    Set<Marker> markers = {};
    LatLng position = LatLng(gas.location!.y ?? 0, gas.location!.x ?? 0);
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

	Widget _heroHeader(context){
		return Hero(
			tag: gas.id ?? "",
			child: Container(
        width: double.infinity,
				padding: const EdgeInsets.all(15),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.start,
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
									child: AutoSizeText(gas.estacion ?? "", overflow: TextOverflow.ellipsis, style: const TextStyle(
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
                    AutoSizeText(gas.direccion ?? "", style: const TextStyle(
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
							MapsLauncher.launchCoordinates(gas.location!.y ?? 0, gas.location!.x ?? 0);
						},
					)
				],
			),
		);
	}

	Widget _comoLlegar(context) {
		return Container(
			margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
			child: FilledButton(
				// style: ButtonStyle(
				// 	// backgroundColor: MaterialStateProperty.all<Color>( const Color(0xffe5eadc) ),
				// 	shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
				// ),
				onPressed: () {
					MapsLauncher.launchCoordinates(gas.location!.y ?? 0, gas.location!.x ?? 0);
				},
				child: Padding(
					padding: const EdgeInsets.symmetric(vertical: 10),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Icon(Icons.near_me_outlined, color: Theme.of(context).colorScheme.onPrimary),
							const SizedBox(width: 15),
							Text("Cómo llegar", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))
						],
					),
				),
			),
		);
	}

	Widget _dateHeader(formatter){
    DateTime date = gas.precio?.fecha ?? DateTime.now();
    
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

          FilledButton.tonal(
            onPressed: () {},
            child: Text(timeago.format(date, locale: 'es').toUpperCase()),
          )
				],
			),
		);
	}

	Widget _priceList(context, label1, label2, label3, price1, price2, price3){
		return Column(
			children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all( Radius.circular(10) ),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 1,
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label1, style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                    const SizedBox(height: 5),
                    Text(price1 ?? "Precio no disponible", style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label2, style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                    const SizedBox(height: 5),
                    Text(price2 ?? "Precio no disponible", style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label3, style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                    const SizedBox(height: 5),
                    Text(price3 ?? "Precio no disponible", style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              ),
            ],
          ),
        )
      ]
		);
	}
}