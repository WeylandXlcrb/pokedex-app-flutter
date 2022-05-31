import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'evolution_detail.g.dart';

abstract class EvolutionDetail
    implements Built<EvolutionDetail, EvolutionDetailBuilder> {
  static Serializer<EvolutionDetail> get serializer =>
      _$evolutionDetailSerializer;

  /// The item required to cause evolution this into Pokémon species.
  NamedAPIResource? get item;

  /// The type of event that triggers evolution into this Pokémon species.
  NamedAPIResource get trigger;

  /// The id of the gender of the evolving Pokémon species must be in order to
  /// evolve into this Pokémon species.
  int? get gender;

  /// The item the evolving Pokémon species must be holding during the evolution
  /// trigger event to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'held_item')
  NamedAPIResource? get heldItem;

  /// The move that must be known by the evolving Pokémon species during
  /// the evolution trigger event in order to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'known_move')
  NamedAPIResource? get knownMove;

  /// The evolving Pokémon species must know a move with this type during
  /// the evolution trigger event in order to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'known_move_type')
  NamedAPIResource? get knownMoveType;

  /// The location the evolution must be triggered at.
  NamedAPIResource? get location;

  /// The minimum required level of the evolving Pokémon species to evolve
  /// into this Pokémon species.
  @BuiltValueField(wireName: 'min_level')
  int? get minLevel;

  /// The minimum required level of happiness the evolving Pokémon species
  /// to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'min_happiness')
  int? get minHappiness;

  /// The minimum required level of beauty the evolving Pokémon species
  /// to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'min_beauty')
  int? get minBeauty;

  /// The minimum required level of affection the evolving Pokémon species
  /// to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'min_affection')
  int? get minAffection;

  /// Whether or not it must be raining in the overworld to cause evolution
  /// this Pokémon species.
  @BuiltValueField(wireName: 'needs_overworld_rain')
  bool get needsOverworldRain;

  /// The Pokémon species that must be in the players party in order for
  /// the evolving Pokémon species to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'party_species')
  NamedAPIResource? get partySpecies;

  /// The player must have a Pokémon of this type in their party during
  /// the evolution trigger event in order for the evolving Pokémon species
  /// to evolve into this Pokémon species.
  @BuiltValueField(wireName: 'party_type')
  NamedAPIResource? get partyType;

  /// The required relation between the Pokémon's Attack and Defense stats.
  /// 1 means Attack > Defense. 0 means Attack = Defense. -1 means Attack < Defense.
  @BuiltValueField(wireName: 'relative_physical_stats')
  int? get relativePhysicalStats;

  /// The required time of day. Day or night.
  @BuiltValueField(wireName: 'time_of_day')
  String get timeOfDay;

  /// Pokémon species for which this one must be traded.
  @BuiltValueField(wireName: 'trade_species')
  NamedAPIResource? get tradeSpecies;

  /// Whether or not the 3DS needs to be turned upside-down as this
  /// Pokémon levels up.
  @BuiltValueField(wireName: 'turn_upside_down')
  bool get turnUpsideDown;

  EvolutionDetail._();

  factory EvolutionDetail([void Function(EvolutionDetailBuilder) updates]) =
      _$EvolutionDetail;
}
