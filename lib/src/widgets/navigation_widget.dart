import 'package:gasolina_app/src/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return NavigationBar(
      selectedIndex: provider.currentTab,
      onDestinationSelected: (i) => provider.currentTab = i,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.notification_important_rounded),
          label: 'Search',
        ),
      ],
    );
  }
}