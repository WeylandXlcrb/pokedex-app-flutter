import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/move/move.dart';
import 'package:pokedex_app/repos/moves_repo.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class MoveDetailsScreen extends StatelessWidget {
  static const routeName = 'move-details';

  final String moveName;

  const MoveDetailsScreen({
    Key? key,
    required this.moveName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(moveName.hyphenToPascalWord()),
        backgroundColor: CategoryColors.moves,
        elevation: 0,
      ),
      body: FutureBuilder<Move>(
        future: context.read<MovesRepo>().getMove(moveName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final move = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Type'),
                  Text(move.type.name),
                  const Text('Accuracy'),
                  Text(move.accuracy.toString()),
                  const Text('Effect chance'),
                  Text('${move.effectChance}%'),
                  const Text('Power Points'),
                  Text('${move.pp}'),
                  const Text('Priority'),
                  Text('${move.priority}'),
                  const Text('Power'),
                  Text('${move.power}'),
                  const Text('Damage Class'),
                  Text(move.damageClass.name),
                  const Text('Effect Entry'),
                  Text(move.effectEntryDefault.effect),
                  // TODO: use learned by pokemon list
                  const Text('Flavor Text'),
                  Text(move.flavorTextDefault.text),
                  const Text('Generation'),
                  Text(move.generation.name),
                  // TODO: use machine list
                  // TODO: use meta data
                  const Text('Stat Changes'),
                  for (final sc in move.statChanges)
                    Text('${sc.stat.name} - ${sc.change}'),
                  const Text('Target'),
                  Text(move.target.name),
                ],
              ),
            );
          }

          return const Center(child: PokeballLoadingIndicator());
        },
      ),
    );
  }
}
