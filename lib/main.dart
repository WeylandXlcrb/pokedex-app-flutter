import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_app/repos/http_cached_pokemons_repo.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/router.dart';
import 'package:pokedex_app/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<PokemonsRepo>(
      create: (_) => HttpCachedPokemonsRepo(),
      child: MaterialApp.router(
        title: 'Flutter Pokedex',
        theme: appLightTheme(context),
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
      ),
    );
  }
}
