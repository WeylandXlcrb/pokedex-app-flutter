import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/type_relations.dart';

part 'type_relations_past.g.dart';

abstract class TypeRelationsPast
    implements Built<TypeRelationsPast, TypeRelationsPastBuilder> {
  static Serializer<TypeRelationsPast> get serializer =>
      _$typeRelationsPastSerializer;

  /// The last generation in which the referenced type had the listed damage relations
  NamedAPIResource get generation;

  /// The damage relations the referenced type had up to and including the listed generation
  @BuiltValueField(wireName: 'damage_relations')
  TypeRelations get damageRelations;

  TypeRelationsPast._();

  factory TypeRelationsPast([void Function(TypeRelationsPastBuilder) updates]) =
      _$TypeRelationsPast;
}
