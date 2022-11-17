import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart';

part 'params.g.dart';

@JsonSerializable()
class Params extends Equatable {
  @JsonKey(name: waterLevelField)
  final num waterLevel;

  @JsonKey(name: topValveField)
  final bool topValve;

  @JsonKey(name: bottomValveField)
  final bool bottomValve;

  @JsonKey(name: timerField)
  final num timer;

  const Params({
    required this.waterLevel,
    required this.topValve,
    required this.bottomValve,
    required this.timer,
  });

  @override
  List<Object?> get props => [
        waterLevel,
        topValve,
        bottomValve,
        timer,
      ];

  factory Params.fromJson(Map<Object?, Object?> json) => _$ParamsFromJson(json);

  Map<Object?, Object?> toJson() => _$ParamsToJson(this);
}
