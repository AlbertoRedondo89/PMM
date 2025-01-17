import 'package:app_persistencia/pages/CalcApp.dart';
import 'package:app_persistencia/preferences/preferences.dart';
import 'package:app_persistencia/provider/CalcProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const AppState()); 
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalcProvider(darkMode: Preferences.darkMode),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const CalcApp(),
      },
      theme: Provider.of<CalcProvider>(context).current
    );
  }
}
