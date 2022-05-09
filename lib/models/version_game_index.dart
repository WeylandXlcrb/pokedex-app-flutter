import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'version_game_index.g.dart';

abstract class VersionGameIndex
    implements Built<VersionGameIndex, VersionGameIndexBuilder> {
  static Serializer<VersionGameIndex> get serializer =>
      _$versionGameIndexSerializer;

  /// The internal id of an API resource within game data.
  @BuiltValueField(wireName: 'game_index')
  int get gameIndex;

  /// The version relevent to this game index.
  NamedAPIResource get version;

  VersionGameIndex._();

  factory VersionGameIndex([void Function(VersionGameIndexBuilder) updates]) =
      _$VersionGameIndex;
}
