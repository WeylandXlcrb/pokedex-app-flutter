import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_resource.g.dart';

abstract class APIResource implements Built<APIResource, APIResourceBuilder> {
  static Serializer<APIResource> get serializer => _$aPIResourceSerializer;

  String get url;

  APIResource._();

  factory APIResource([void Function(APIResourceBuilder) updates]) =
      _$APIResource;
}
