import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'type_relations.g.dart';

abstract class TypeRelations
    implements Built<TypeRelations, TypeRelationsBuilder> {
  static Serializer<TypeRelations> get serializer => _$typeRelationsSerializer;

  /// A list of types this type has no effect on.
  @BuiltValueField(wireName: 'no_damage_to')
  BuiltList<NamedAPIResource> get noDamageTo;

  /// A list of types this type is not very effect against.
  @BuiltValueField(wireName: 'half_damage_to')
  BuiltList<NamedAPIResource> get halfDamageTo;

  /// A list of types this type is very effect against.
  @BuiltValueField(wireName: 'double_damage_to')
  BuiltList<NamedAPIResource> get doubleDamageTo;

  /// A list of types that have no effect on this type.
  @BuiltValueField(wireName: 'no_damage_from')
  BuiltList<NamedAPIResource> get noDamageFrom;

  /// A list of types that are not very effective against this type.
  @BuiltValueField(wireName: 'half_damage_from')
  BuiltList<NamedAPIResource> get halfDamageFrom;

  /// A list of types that are very effective against this type.
  @BuiltValueField(wireName: 'double_damage_from')
  BuiltList<NamedAPIResource> get doubleDamageFrom;

  TypeRelations._();

  factory TypeRelations([void Function(TypeRelationsBuilder) updates]) =
      _$TypeRelations;
}
