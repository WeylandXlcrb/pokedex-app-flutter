import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/api_resource.dart';
import 'package:pokedex_app/models/machine_version_detail.dart';
import 'package:pokedex_app/models/move/move_meta_data.dart';
import 'package:pokedex_app/models/move/move_stat_change.dart';
import 'package:pokedex_app/models/move/past_move_stat_values.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/verbose_effect.dart';
import 'package:pokedex_app/models/move/contest_combo_sets.dart';
import 'package:pokedex_app/models/pokemon/ability_effect_change.dart';
import 'package:pokedex_app/models/version_group_flavor_text.dart';

part 'move.g.dart';

abstract class Move implements Built<Move, MoveBuilder> {
  static Serializer<Move> get serializer => _$moveSerializer;

  /// The identifier for this resource.
  int get id;

  /// The name for this resource.
  String get name;

  /// The percent value of how likely this move is to be successful.
  int get accuracy;

  /// The percent value of how likely it is this moves effect will happen.
  @BuiltValueField(wireName: 'effect_chance')
  int? get effectChance;

  /// Power points. The number of times this move can be used.
  int get pp;

  /// A value between -8 and 8. Sets the order in which moves are executed during battle.
  int get priority;

  /// The base power of this move with a value of 0 if it does not have a base power.
  int? get power;

  /// A detail of normal and super contest combos that require this move.
  @BuiltValueField(wireName: 'contest_combos')
  ContestComboSets get contestCombos;

  /// The type of appeal this move gives a Pokémon when used in a contest.
  @BuiltValueField(wireName: 'contest_type')
  NamedAPIResource get contestType;

  /// The effect the move has when used in a contest.
  @BuiltValueField(wireName: 'contest_effect')
  APIResource get contestEffect;

  /// The type of damage the move inflicts on the target, e.g. physical.
  @BuiltValueField(wireName: 'damage_class')
  NamedAPIResource get damageClass;

  /// The effect of this move listed in different languages.
  @BuiltValueField(wireName: 'effect_entries')
  BuiltList<VerboseEffect> get effectEntries;

  /// The list of previous effects this move has had across version groups of the games.
  @BuiltValueField(wireName: 'effect_changes')
  BuiltList<AbilityEffectChange> get effectChanges;

  /// List of Pokemon that can learn the move
  @BuiltValueField(wireName: 'learned_by_pokemon')
  BuiltList<NamedAPIResource> get learnedByPokemon;

  /// The flavor text of this move listed in different languages.
  @BuiltValueField(wireName: 'flavor_text_entries')
  BuiltList<VersionGroupFlavorText> get flavorTextEntries;

  /// The generation in which this move was introduced.
  NamedAPIResource get generation;

  /// A list of the machines that teach this move.
  BuiltList<MachineVersionDetail> get machines;

  /// Metadata about this move
  MoveMetaData get meta;

  /// The name of this resource listed in different languages.
  BuiltList<Name> get names;

  /// A list of move resource value changes across version groups of the game.
  @BuiltValueField(wireName: 'past_values')
  BuiltList<PastMoveStatValues> get pastValues;

  /// A list of stats this moves effects and how much it effects them.
  @BuiltValueField(wireName: 'stat_changes')
  BuiltList<MoveStatChange> get statChanges;

  /// The effect the move has when used in a super contest.
  @BuiltValueField(wireName: 'super_contest_effect')
  APIResource get superContestEffect;

  /// The type of target that will receive the effects of the attack.
  NamedAPIResource get target;

  /// The elemental type of this move.
  NamedAPIResource get type;

  VerboseEffect get effectEntryDefault => effectEntries.firstWhere(
        (e) => e.language.name == kLanguageCodeDefault,
        orElse: () => effectEntries.first,
      );

  VersionGroupFlavorText get flavorTextDefault => flavorTextEntries.firstWhere(
        (p0) => p0.language.name == kLanguageCodeDefault,
        orElse: () => flavorTextEntries.first,
      );

  Move._();

  factory Move([void Function(MoveBuilder) updates]) = _$Move;
}
