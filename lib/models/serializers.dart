import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:pokedex_app/models/api_resource.dart';
import 'package:pokedex_app/models/description.dart';
import 'package:pokedex_app/models/effect.dart';
import 'package:pokedex_app/models/flavor_text.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/pokemon/ability.dart';
import 'package:pokedex_app/models/pokemon/ability_change_effect.dart';
import 'package:pokedex_app/models/pokemon/ability_flavor_text.dart';
import 'package:pokedex_app/models/pokemon/ability_pokemon.dart';
import 'package:pokedex_app/models/pokemon/genus.dart';
import 'package:pokedex_app/models/pokemon/pal_park_encounter_area.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_ability.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item_version.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move_version.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species_dex_entry.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species_variety.dart';
import 'package:pokedex_app/models/pokemon/sprite/front_and_shiny_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/front_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/other_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/pokemon_sprites.dart';
import 'package:pokedex_app/models/pokemon/pokemon_stat.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type_past.dart';
import 'package:pokedex_app/models/verbose_effect.dart';
import 'package:pokedex_app/models/version_game_index.dart';

part 'serializers.g.dart';

@SerializersFor([
  // COMMON
  APIResource,
  Description,
  Effect,
  FlavorText,
  NamedAPIResource,
  NamedAPIResourceList,
  Name,
  VerboseEffect,
  VersionGameIndex,
  // POKEMON
  Pokemon,
  PokemonAbility,
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
  // POKEMON SPECIES
  PokemonSpeciesDexEntry,
  PalParkEncounterArea,
  Genus,
  PokemonSpeciesVariety,
  PokemonSpecies,
  // ABILITY
  Ability,
  AbilityChangeEffect,
  AbilityFlavorText,
  AbilityPokemon,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
