import 'package:flutter/material.dart';
import 'package:gasolina_app/src/models/gas_model.dart';
import 'package:gasolina_app/src/providers/api_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

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
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(17),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Image(
            image: AssetImage("assets/gasolineras/${stations[index].marca}.png"),
          ),
        ),
        title: Text(stations[index].marca ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(stations[index].municipio ?? "", style: TextStyle(color: Colors.grey[600])),

        trailing: TextButton( 
          onPressed: () {}, 
          // styling the button
          style: ElevatedButton.styleFrom( 
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            // Button color
            backgroundColor: kOnPrimaryColor, 
          ),
          // icon of the button
          child: const Icon(Icons.star_border, color: kPrimaryColor),
        ),

        onTap: () {
          apiProvider.gasSelected = stations[index];
        }
      ),
    );
    // return ListTile(
    //   leading: CircleAvatar(
    //     child: Image(
    //       image: AssetImage("assets/gasolineras/${stations[index].marca}.png"),
    //     ),
    //   ),
    //   title: Text(stations[index].marca ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //   subtitle: Text(stations[index].municipio ?? "", style: TextStyle(color: Colors.grey[600])),

    //   trailing: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       const Text('4.80\$', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    //       const SizedBox(height: 3),
    //       Text('1.9 Km', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
    //     ],
    //   ),

    //   onTap: () {
    //     apiProvider.gasSelected = stations[index];
    //   }
    // );
  }
}