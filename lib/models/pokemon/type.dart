import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import 'package:pokedex_app/models/generation_game_index.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/type_parser.dart';
import 'package:pokedex_app/models/pokemon/type_pokemon.dart';
import 'package:pokedex_app/models/pokemon/type_relations.dart';
import 'package:pokedex_app/models/pokemon/type_relations_past.dart';

part 'type.g.dart';

// Since Type is flutter's core type, TypeP to disambiguate (P stands for Pokemon)
abstract class TypeP with TypeParser implements Built<TypeP, TypePBuilder> {
  static Serializer<TypeP> get serializer => _$typePSerializer;

  /// The identifier for this resource.
  int get id;

  /// The name for this resource.
  @override
  String get name;

  /// A detail of how effective this type is toward others and vice versa.
  @BuiltValueField(wireName: 'damage_relations')
  TypeRelations get damageRelations;

  /// A list of details of how effective this type was toward others and
  /// vice versa in previous generations
  @BuiltValueField(wireName: 'past_damage_relations')
  BuiltList<TypeRelationsPast> get pastDamageRelations;

  /// A list of game indices relevant to this item by generation.
  @BuiltValueField(wireName: 'game_indices')
  BuiltList<GenerationGameIndex> get gameIndices;

  /// The generation this type was introduced in.
  NamedAPIResource get generation;

  /// The class of damage inflicted by this type.
  @BuiltValueField(wireName: 'move_damage_class')
  NamedAPIResource? get moveDamageClass;

  /// The name of this resource listed in different languages.
  BuiltList<Name> get names;

  /// A list of details of Pokémon that have this type.
  @BuiltValueField(wireName: 'pokemon')
  BuiltList<TypePokemon> get pokemons;

  /// A list of moves that have this type.
  BuiltList<NamedAPIResource> get moves;

  TypeP._();

  factory TypeP([void Function(TypePBuilder) updates]) = _$TypeP;
}
