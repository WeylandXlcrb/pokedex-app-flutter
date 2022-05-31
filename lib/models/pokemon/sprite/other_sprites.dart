import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/pokemon/sprite/front_and_shiny_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/front_sprites.dart';

part 'other_sprites.g.dart';

abstract class OtherSprites
    implements Built<OtherSprites, OtherSpritesBuilder> {
  static Serializer<OtherSprites> get serializer => _$otherSpritesSerializer;

  FrontAndShinySprites get home;

  @BuiltValueField(wireName: 'official-artwork')
  FrontSprites get officialArtwork;

  OtherSprites._();

  factory OtherSprites([void Function(OtherSpritesBuilder) updates]) =
      _$OtherSprites;
}
