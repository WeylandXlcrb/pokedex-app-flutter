import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_app/screens/home/home_screen.dart';
import 'package:pokedex_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokedex',
      theme: appLightTheme(context),
      home: const HomeScreen(),
    );
  }
}
