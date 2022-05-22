import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'name.g.dart';

abstract class Name implements Built<Name, NameBuilder> {
  static Serializer<Name> get serializer => _$nameSerializer;

  /// The localized name for an API resource in a specific language.
  String get name;

  /// The language this name is in.
  NamedAPIResource get language;

  Name._();

  factory Name([void Function(NameBuilder) updates]) = _$Name;
}
