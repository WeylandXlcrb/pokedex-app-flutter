import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'named_api_resource.g.dart';

abstract class NamedAPIResource
    implements Built<NamedAPIResource, NamedAPIResourceBuilder> {
  static Serializer<NamedAPIResource> get serializer =>
      _$namedAPIResourceSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(NamedAPIResourceBuilder b) => b
    ..name = 'unknown'
    ..url = '';

  String get name;

  String get url;

  NamedAPIResource._();

  factory NamedAPIResource([void Function(NamedAPIResourceBuilder) updates]) =
      _$NamedAPIResource;
}
