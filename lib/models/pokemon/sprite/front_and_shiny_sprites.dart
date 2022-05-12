import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/pokemon/sprite/sprite_set.dart';

part 'front_and_shiny_sprites.g.dart';

abstract class FrontAndShinySprites
    with FrontSpriteSet, FrontShinySpriteSet
    implements Built<FrontAndShinySprites, FrontAndShinySpritesBuilder> {
  static Serializer<FrontAndShinySprites> get serializer =>
      _$frontAndShinySpritesSerializer;

  FrontAndShinySprites._();

  factory FrontAndShinySprites(
          [void Function(FrontAndShinySpritesBuilder) updates]) =
      _$FrontAndShinySprites;
}
