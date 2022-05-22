import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'description.g.dart';

abstract class Description implements Built<Description, DescriptionBuilder> {
  static Serializer<Description> get serializer => _$descriptionSerializer;

  /// The localized description for an API resource in a specific language.
  String get description;

  /// The language this name is in.
  NamedAPIResource get language;

  Description._();

  factory Description([void Function(DescriptionBuilder) updates]) =
      _$Description;
}
