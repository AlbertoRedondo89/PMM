import 'package:flutter/material.dart';
import 'package:practica_t3_hp/providers/movies_provider.dart';
import 'package:practica_t3_hp/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
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
      title: 'Pel·lícules',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'details': (BuildContext context) => DetailsScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
