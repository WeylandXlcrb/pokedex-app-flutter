import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/pokemon/sprite/other_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/sprite_set.dart';

part 'pokemon_sprites.g.dart';

abstract class PokemonSprites
    with FrontSpriteSet, FrontShinySpriteSet, BackSpriteSet, BackShinySpriteSet
    implements Built<PokemonSprites, PokemonSpritesBuilder> {
  static Serializer<PokemonSprites> get serializer =>
      _$pokemonSpritesSerializer;

  OtherSprites get other;

  PokemonSprites._();

  factory PokemonSprites([void Function(PokemonSpritesBuilder) updates]) =
      _$PokemonSprites;
}
