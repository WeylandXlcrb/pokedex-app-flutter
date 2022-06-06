import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'region.g.dart';

abstract class Region implements Built<Region, RegionBuilder> {
  static Serializer<Region> get serializer => _$regionSerializer;

  /// The identifier for this resource.
  int get id;

  /// The name for this resource.
  String get name;

  /// A list of locations that can be found in this region.
  BuiltList<NamedAPIResource> get locations;

  /// The name of this resource listed in different languages.
  BuiltList<Name> get names;

  /// The generation this region was introduced in.
  @BuiltValueField(wireName: 'main_generation')
  NamedAPIResource get mainGeneration;

  /// A list of pokédexes that catalogue Pokémon in this region.
  BuiltList<NamedAPIResource> get pokedexes;

  /// A list of version groups where this region can be visited.
  @BuiltValueField(wireName: 'version_group')
  BuiltList<NamedAPIResource> get versionGroups;

  Region._();

  factory Region([void Function(RegionBuilder) updates]) = _$Region;
}
