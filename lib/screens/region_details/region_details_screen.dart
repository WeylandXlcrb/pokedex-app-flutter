import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/location/region.dart';
import 'package:pokedex_app/repos/locations_repo.dart';
import 'package:pokedex_app/screens/location_details/location_details_screen.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class RegionDetailsScreen extends StatelessWidget {
  static const routeName = 'region-details';
  final String regionName;

  const RegionDetailsScreen({
    Key? key,
    required this.regionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(regionName.hyphenToPascalWord()),
        backgroundColor: CategoryColors.locations,
      ),
      body: FutureBuilder<Region>(
        future: context.read<LocationsRepo>().getRegion(regionName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return _RegionBody(region: snapshot.data!);
          }

          return const Center(child: PokeballLoadingIndicator());
        },
      ),
    );
  }
}

class _RegionBody extends StatelessWidget {
  const _RegionBody({
    Key? key,
    required this.region,
  }) : super(key: key);

  final Region region;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (region.pokedexes.isNotEmpty) ...[
          const SliverPadding(
            padding: EdgeInsets.all(kPaddingDefault),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Pokedexes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
          // TODO: normal widget
                (context, index) => Text(region.pokedexes[index].name),
                childCount: region.pokedexes.length,
              ),
            ),
          ),
        ],
        const SliverPadding(
          padding: EdgeInsets.all(kPaddingDefault),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Locations',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final location = region.locations[index];

              return ListTile(
                title: Text(location.name.hyphenToPascalWord()),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                onTap: () => context.pushNamed(
                  LocationDetailsScreen.routeName,
                  params: {'name': location.name},
                ),
              );
            },
            childCount: region.locations.length,
          ),
        ),
      ],
    );
  }
}
