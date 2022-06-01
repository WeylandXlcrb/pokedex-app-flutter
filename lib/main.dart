import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pokedex_app/router.dart';
import 'package:pokedex_app/theme.dart';
import 'package:pokedex_app/repos/http_cached_moves_repo.dart';
import 'package:pokedex_app/repos/http_cached_pokemons_repo.dart';
import 'package:pokedex_app/repos/moves_repo.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/services/moves_cache.dart';
import 'package:pokedex_app/services/pokemons_cache.dart';

void main() async {
  Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await PokemonsCache().init();
  await MovesCache().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PokemonsRepo>(create: (_) => HttpCachedPokemonsRepo()),
        Provider<MovesRepo>(create: (_) => HttpCachedMoveRepo()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Pokedex',
        theme: appLightTheme(context),
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
      ),
    );
  }
}
