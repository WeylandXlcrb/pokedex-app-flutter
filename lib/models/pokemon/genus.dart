import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'genus.g.dart';

abstract class Genus implements Built<Genus, GenusBuilder> {
  static Serializer<Genus> get serializer => _$genusSerializer;

  /// The localized genus for the referenced Pokémon species
  String get genus;

  /// The language this genus is in.
  NamedAPIResource get language;

  Genus._();

  factory Genus([void Function(GenusBuilder) updates]) = _$Genus;
}
