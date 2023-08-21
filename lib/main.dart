import 'package:gasolina_app/src/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:gasolina_app/src/providers/app_provider.dart';
import 'package:gasolina_app/src/providers/auth_provider.dart';
import 'package:gasolina_app/src/providers/map_provider.dart';
import 'package:gasolina_app/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xffd9e7cb),
          scaffoldBackgroundColor: const Color(0xfff0f3e8),
          // elevatedButtonTheme: authButtonTheme(),
          // inputDecorationTheme: authFormFieldTheme(),
          // appBarTheme: appBarTheme(),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          '/': (_) => const HomeScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}