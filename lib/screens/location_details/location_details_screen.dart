import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/location/location.dart';
import 'package:pokedex_app/repos/locations_repo.dart';
import 'package:pokedex_app/screens/area_details/area_details_screen.dart';
import 'package:pokedex_app/screens/region_details/region_details_screen.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class LocationDetailsScreen extends StatelessWidget {
  static const routeName = 'location-details';

  final String locationName;

  const LocationDetailsScreen({
    Key? key,
    required this.locationName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locationName.hyphenToPascalWord()),
        backgroundColor: CategoryColors.locations,
      ),
      body: FutureBuilder<Location>(
        future: context.read<LocationsRepo>().getLocation(locationName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final location = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: kPaddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPaddingDefault),
                    child: Text(
                      'Region',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  ListTile(
                    title: Text(location.region.name.hyphenToPascalWord()),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () => context.pushNamed(
                      RegionDetailsScreen.routeName,
                      params: {'name': location.region.name},
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPaddingDefault),
                    child: Text(
                      'Areas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  for (final area in location.areas)
                    ListTile(
                      title: Text(area.name.hyphenToPascalWord()),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                      onTap: () => context.pushNamed(
                        AreaDetailsScreen.routeName,
                        params: {'name': area.name},
                      ),
                    ),
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
