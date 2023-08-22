import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:gasolina_app/src/providers/api_provider.dart';
import 'package:provider/provider.dart';

class GasListTileNoAnimationWidget extends StatelessWidget {
  final List<GasModel> stations;
  final int index;

  const GasListTileNoAnimationWidget({super.key, required this.stations, required this.index});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
      decoration: BoxDecoration(
        color: (apiProvider.gasSelected.id == stations[index].id)? Theme.of(context).colorScheme.primaryContainer : const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Image(
            image: AssetImage("assets/gasolineras/${stations[index].marca}.png"),
          ),
        ),
        title: Text(stations[index].estacion ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stations[index].municipio ?? "", style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 15),

            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.directions, size: 14),
                  label: const Text('Direcciones', style: TextStyle(fontSize: 12)),
                  onPressed: () {},
                ),

                const SizedBox(width: 15),

                OutlinedButton.icon(
                  icon: const Icon(Icons.share, size: 14),
                  label: const Text('Compartir', style: TextStyle(fontSize: 12)),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(stations[index].precio!.especialSc.toString() ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold) ),
            Text(stations[index].precio!.especialAuto.toString() ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold) ),
          ],
        ),

        onTap: () {
          apiProvider.gasSelected = stations[index];
        }
      ),
    );
  }
}