import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/pokemon/sprite/sprite_set.dart';

part 'front_sprites.g.dart';

abstract class FrontSprites
    with FrontSpriteSet
    implements Built<FrontSprites, FrontSpritesBuilder> {
  static Serializer<FrontSprites> get serializer => _$frontSpritesSerializer;

  FrontSprites._();

  factory FrontSprites([void Function(FrontSpritesBuilder) updates]) =
      _$FrontSprites;
}
