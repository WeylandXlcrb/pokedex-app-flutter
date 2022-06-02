import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/api_resource.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'machine_version_detail.g.dart';

abstract class MachineVersionDetail
    implements Built<MachineVersionDetail, MachineVersionDetailBuilder> {
  static Serializer<MachineVersionDetail> get serializer =>
      _$machineVersionDetailSerializer;

  /// The machine that teaches a move from an item.
  APIResource get machine;

  /// The version group of this specific machine.
  @BuiltValueField(wireName: 'version_group')
  NamedAPIResource get versionGroup;

  MachineVersionDetail._();

  factory MachineVersionDetail(
          [void Function(MachineVersionDetailBuilder) updates]) =
      _$MachineVersionDetail;
}
