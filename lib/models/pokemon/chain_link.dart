import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/evolution_detail.dart';

part 'chain_link.g.dart';

abstract class ChainLink implements Built<ChainLink, ChainLinkBuilder> {
  static Serializer<ChainLink> get serializer => _$chainLinkSerializer;

  /// Whether or not this link is for a baby Pokémon. This would only ever be
  /// true on the base link.
  @BuiltValueField(wireName: 'is_baby')
  bool get isBaby;

  /// The Pokémon species at this point in the evolution chain.
  NamedAPIResource get species;

  /// All details regarding the specific details of the referenced Pokémon
  /// species evolution.
  @BuiltValueField(wireName: 'evolution_details')
  BuiltList<EvolutionDetail> get evolutionDetails;

  /// A List of chain objects.
  @BuiltValueField(wireName: 'evolves_to')
  BuiltList<ChainLink> get evolvesTo;

  ChainLink._();

  factory ChainLink([void Function(ChainLinkBuilder) updates]) = _$ChainLink;
}
