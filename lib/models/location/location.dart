import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/generation_game_index.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'location.g.dart';

abstract class Location implements Built<Location, LocationBuilder> {
  static Serializer<Location> get serializer => _$locationSerializer;

  /// The identifier for this resource.
  int get id;

  /// The name for this resource.
  String get name;

  /// The region this location can be found in.
  NamedAPIResource get region;

  /// The name of this resource listed in different languages.
  BuiltList<Name> get names;

  /// A list of game indices relevent to this location by generation.
  @BuiltValueField(wireName: 'game_indices')
  BuiltList<GenerationGameIndex> get gameIndices;

  /// Areas that can be found within this location.
  BuiltList<NamedAPIResource> get areas;

  Location._();

  factory Location([void Function(LocationBuilder) updates]) = _$Location;
}
