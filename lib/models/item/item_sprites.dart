import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'item_sprites.g.dart';

abstract class ItemSprites implements Built<ItemSprites, ItemSpritesBuilder> {
  static Serializer<ItemSprites> get serializer => _$itemSpritesSerializer;

  /// The default depiction of this item.
  @BuiltValueField(wireName: 'default')
  String get defSprite;

  ItemSprites._();

  factory ItemSprites([void Function(ItemSpritesBuilder) updates]) =
      _$ItemSprites;
}
