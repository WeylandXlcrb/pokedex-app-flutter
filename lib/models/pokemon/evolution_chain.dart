import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/chain_link.dart';

part 'evolution_chain.g.dart';

abstract class EvolutionChain
    implements Built<EvolutionChain, EvolutionChainBuilder> {
  static Serializer<EvolutionChain> get serializer =>
      _$evolutionChainSerializer;

  /// The identifier for this resource.
  int get id;

  /// The item that a Pokémon would be holding when mating that would trigger
  /// the egg hatching a baby Pokémon rather than a basic Pokémon.
  @BuiltValueField(wireName: 'baby_trigger_item')
  NamedAPIResource? get babyTriggerItem;

  /// The base chain link object. Each link contains evolution details for a
  /// Pokémon in the chain. Each link references the next Pokémon in
  /// the natural evolution order.
  ChainLink get chain;

  EvolutionChain._();

  factory EvolutionChain([void Function(EvolutionChainBuilder) updates]) =
      _$EvolutionChain;
}
