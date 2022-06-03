import 'package:built_value/built_value.dart';

abstract class FrontSpriteSet {
  /// The default depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_default')
  String? get frontDefault;

  /// The female depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_female')
  String? get frontFemale;
}

abstract class FrontShinySpriteSet {
  /// The shiny depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_shiny')
  String? get frontShiny;

  /// The shiny female depiction of this Pokémon from the front in battle.
  @BuiltValueField(wireName: 'front_shiny_female')
  String? get frontShinyFemale;
}

abstract class BackSpriteSet {
  /// The default depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_default')
  String? get backDefault;

  /// The female depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_female')
  String? get backFemale;
}

abstract class BackShinySpriteSet {
  /// The shiny depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_shiny')
  String? get backShiny;

  /// The shiny female depiction of this Pokémon from the back in battle.
  @BuiltValueField(wireName: 'back_shiny_female')
  String? get backShinyFemale;
}
