part of 'water_purification_stages_bloc.dart';

abstract class WaterPurificationStagesEvent extends Equatable {
  const WaterPurificationStagesEvent();

  @override
  List<Object?> get props => [];
}

class ListenWaterPurificationStagesEvent extends WaterPurificationStagesEvent {
  const ListenWaterPurificationStagesEvent();

  @override
  List<Object?> get props => [];
}

class UncleanWaterEnteringEvent extends WaterPurificationStagesEvent {
  const UncleanWaterEnteringEvent();

  @override
  List<Object?> get props => [];
}

class TreatingUncleanWaterEvent extends WaterPurificationStagesEvent {
  const TreatingUncleanWaterEvent();

  @override
  List<Object?> get props => [];
}

class CleanWaterLeavingEvent extends WaterPurificationStagesEvent {
  final num waterLevel;

  const CleanWaterLeavingEvent({
    required this.waterLevel,
  });

  @override
  List<Object?> get props => [
        waterLevel,
      ];
}

class StopListeningWaterPurificationStagesEvent
    extends WaterPurificationStagesEvent {
  const StopListeningWaterPurificationStagesEvent();

  @override
  List<Object?> get props => [];
}
