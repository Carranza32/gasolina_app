import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:gasolina_app/src/providers/api_provider.dart';
import 'package:provider/provider.dart';

import '../screens/index.dart';

class GasListTile extends StatelessWidget {
  final List<GasModel> stations;
  final int index;

  const GasListTile({super.key, required this.stations, required this.index});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 500),
      closedElevation: 0,
      closedColor: Colors.transparent,
      openBuilder: (context, action) {
        apiProvider.gasSelected = stations[index];
        
        return DetailsScreen(gas: stations[index]);
      },
      closedBuilder: (context, action) {
        return ListTile(
          leading: CircleAvatar(
            child: Image(
              image: AssetImage("assets/gasolineras/${stations[index].marca}.png"),
            ),
          ),
          title: Text(stations[index].marca ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(stations[index].municipio ?? "", style: TextStyle(color: Colors.grey[600])),

          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('4.80\$', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text('1.9 Km', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        );
      },
    );
  }
}