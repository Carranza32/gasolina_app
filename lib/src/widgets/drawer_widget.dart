import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

	@override
	Widget build(BuildContext context) {
		return NavigationDrawer(
			children: [
				Padding(
					padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
					child: Text(
					'Header',
					style: Theme.of(context).textTheme.titleSmall,
					),
				),
				const NavigationDrawerDestination(
					label: Text('Home'),
					icon: Icon(Icons.home_rounded),
				),
			],
		);
	}
}