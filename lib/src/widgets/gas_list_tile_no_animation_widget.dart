import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:gasolina_app/src/providers/api_provider.dart';
import 'package:provider/provider.dart';

class GasListTileNoAnimationWidget extends StatelessWidget {
  final GasContent gas;
  final int index;

  const GasListTileNoAnimationWidget({super.key, required this.gas, required this.index});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
      decoration: BoxDecoration(
        color: (apiProvider.gasSelected.id == gas.id)? Theme.of(context).colorScheme.primaryContainer : const Color.fromARGB(255, 255, 255, 255),
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
            image: AssetImage("assets/gasolineras/${gas.marca}.png"),
          ),
        ),
        title: Text(gas.estacion ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gas.municipio ?? "", style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 15),

            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.directions, size: 14),
                  label: const Text('Direcciones', style: TextStyle(fontSize: 12)),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(gas.precio?.regularSc.toString() ?? 'Precio no disponible', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold) ),
            Text(gas.precio?.regularAuto.toString() ?? 'Precio no disponible', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold) ),
          ],
        ),

        onTap: () {
          apiProvider.gasSelected = gas;
        }
      ),
    );
  }
}