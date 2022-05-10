import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pokemon_sprites.g.dart';

abstract class PokemonSprites
    implements Built<PokemonSprites, PokemonSpritesBuilder> {
  static Serializer<PokemonSprites> get serializer =>
      _$pokemonSpritesSerializer;

  // TODO: not full list of sprites. Complete to full. Some of sprites are
  //  version based which API doesn't provide as a list, but as a set of
  //  key-value pair, which can lead to some 'hard-code'

  /// The default depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_default')
  String get frontDefault;

  /// The shiny depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_shiny')
  String get frontShiny;

  /// The female depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_female')
  String? get frontFemale;

  /// The shiny female depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_shiny_female')
  String? get frontShinyFemale;

  /// The default depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_default')
  String get backDefault;

  /// The shiny depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_shiny')
  String get backShiny;

  /// The female depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_female')
  String? get backFemale;

  /// The shiny female depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_shiny_female')
  String? get backShinyFemale;

  PokemonSprites._();

  factory PokemonSprites([void Function(PokemonSpritesBuilder) updates]) =
      _$PokemonSprites;
}
