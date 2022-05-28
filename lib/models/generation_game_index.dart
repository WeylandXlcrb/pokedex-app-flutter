import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'generation_game_index.g.dart';

abstract class GenerationGameIndex
    implements Built<GenerationGameIndex, GenerationGameIndexBuilder> {
  static Serializer<GenerationGameIndex> get serializer =>
      _$generationGameIndexSerializer;

  /// The internal id of an API resource within game data.
  @BuiltValueField(wireName: 'game_index')
  int get index;

  /// The generation relevant to this game index.
  NamedAPIResource get generation;

  GenerationGameIndex._();

  factory GenerationGameIndex(
          [void Function(GenerationGameIndexBuilder) updates]) =
      _$GenerationGameIndex;
}
