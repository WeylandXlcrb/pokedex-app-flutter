import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'pokemon_move_version.g.dart';

abstract class PokemonMoveVersion
    implements Built<PokemonMoveVersion, PokemonMoveVersionBuilder> {
  static Serializer<PokemonMoveVersion> get serializer =>
      _$pokemonMoveVersionSerializer;

  /// The method by which the move is learned.
  @BuiltValueField(wireName: 'move_learn_method')
  NamedAPIResource get moveLearnMethod;

  /// The version group in which the move is learned.
  @BuiltValueField(wireName: 'version_group')
  NamedAPIResource get versionGroup;

  /// The minimum level to learn the move.
  @BuiltValueField(wireName: 'level_learned_at')
  int get levelLearnedAt;

  PokemonMoveVersion._();

  factory PokemonMoveVersion(
          [void Function(PokemonMoveVersionBuilder) updates]) =
      _$PokemonMoveVersion;
}
