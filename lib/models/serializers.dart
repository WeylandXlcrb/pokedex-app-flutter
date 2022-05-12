import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_ability.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item_version.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move_version.dart';
import 'package:pokedex_app/models/pokemon/sprite/front_and_shiny_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/front_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/other_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/pokemon_sprites.dart';
import 'package:pokedex_app/models/pokemon/pokemon_stat.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type_past.dart';
import 'package:pokedex_app/models/version_game_index.dart';

part 'serializers.g.dart';

@SerializersFor([
  NamedAPIResource,
  NamedAPIResourceList,
  Pokemon,
  PokemonAbility,
  VersionGameIndex,
  PokemonHeldItemVersion,
  PokemonHeldItem,
  PokemonMoveVersion,
  PokemonMove,
  PokemonType,
  PokemonTypePast,
  PokemonSprites,
  PokemonStat,
  FrontSprites,
  FrontAndShinySprites,
  OtherSprites,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
