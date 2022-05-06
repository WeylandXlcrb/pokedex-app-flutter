import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'named_api_resource_list.g.dart';

abstract class NamedAPIResourceList
    implements Built<NamedAPIResourceList, NamedAPIResourceListBuilder> {
  static Serializer<NamedAPIResourceList> get serializer =>
      _$namedAPIResourceListSerializer;

  int get count;

  String? get next;

  String? get previous;

  BuiltList<NamedAPIResource> get list;

  NamedAPIResourceList._();

  factory NamedAPIResourceList(
          [void Function(NamedAPIResourceListBuilder) updates]) =
      _$NamedAPIResourceList;
}
