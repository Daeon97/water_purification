part of 'water_purification_stages_bloc.dart';

abstract class WaterPurificationStagesState extends Equatable {
  const WaterPurificationStagesState();

  @override
  List<Object?> get props => [];
}

class WaterPurificationStageInitialState extends WaterPurificationStagesState {
  const WaterPurificationStageInitialState();

  @override
  List<Object?> get props => [];
}

class UncleanWaterEnteringState extends WaterPurificationStagesState {
  const UncleanWaterEnteringState();

  @override
  List<Object?> get props => [];
}

class TreatingUncleanWaterState extends WaterPurificationStagesState {
  const TreatingUncleanWaterState();

  @override
  List<Object?> get props => [];
}

class CleanWaterLeavingState extends WaterPurificationStagesState {
  final num waterLevel;

  const CleanWaterLeavingState({
    required this.waterLevel,
  });

  @override
  List<Object?> get props => [
        waterLevel,
      ];
}
