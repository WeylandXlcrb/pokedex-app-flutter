import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_app/screens/move_details/move_details_screen.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/repos/moves_repo.dart';
import 'package:pokedex_app/widgets/paginated_resource_list.dart';

class MovesScreen extends StatelessWidget {
  static const routeName = 'moves';

  const MovesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moves'),
        backgroundColor: CategoryColors.moves,
      ),
      body: PaginatedResourceList(
        pageFetcher: context.read<MovesRepo>().getMoveList,
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault * 1.5),
        itemBuilder: (_, __, resource) => ListTile(
          title: Text(resource.name.hyphenToPascalWord()),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
          ),
          onTap: () => context.goNamed(
            MoveDetailsScreen.routeName,
            params: {'name': resource.name},
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}
