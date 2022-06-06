import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/repos/locations_repo.dart';
import 'package:pokedex_app/screens/location_details/location_details_screen.dart';
import 'package:pokedex_app/widgets/paginated_resource_list.dart';

class LocationsScreen extends StatelessWidget {
  static const routeName = 'locations';

  const LocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        backgroundColor: CategoryColors.locations,
      ),
      body: PaginatedResourceList(
        pageFetcher: context.read<LocationsRepo>().getLocationList,
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault * 1.5),
        separatorBuilder: (_, __) => const SizedBox.shrink(),
        itemBuilder: (_, __, resource) => ListTile(
          title: Text(resource.name.hyphenToPascalWord()),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
          ),
          onTap: () => context.goNamed(
            LocationDetailsScreen.routeName,
            params: {'name': resource.name},
          ),
        ),
      ),
    );
  }
}
