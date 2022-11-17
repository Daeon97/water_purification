// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Params _$ParamsFromJson(Map<Object?, Object?> json) => Params(
      waterLevel: json['water_level'] as num,
      topValve: json['top_valve'] as bool,
      bottomValve: json['bottom_valve'] as bool,
      timer: json['timer'] as num,
    );

Map<String, dynamic> _$ParamsToJson(Params instance) => <String, dynamic>{
      'water_level': instance.waterLevel,
      'top_valve': instance.topValve,
      'bottom_valve': instance.bottomValve,
      'timer': instance.timer,
    };
