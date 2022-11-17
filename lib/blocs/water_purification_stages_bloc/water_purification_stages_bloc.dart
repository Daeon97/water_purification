import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../repositories/database_ops_repository.dart';
import '../../models/params.dart';

part 'water_purification_stages_event.dart';

part 'water_purification_stages_state.dart';

class WaterPurificationStagesBloc
    extends Bloc<WaterPurificationStagesEvent, WaterPurificationStagesState> {
  StreamSubscription<DatabaseEvent>? _paramsStreamSubscription;

  WaterPurificationStagesBloc(
    DatabaseOpsRepository databaseOpsRepository,
  ) : super(
          const WaterPurificationStageInitialState(),
        ) {
    on<ListenWaterPurificationStagesEvent>(
      (event, emit) async {
        emit(
          const WaterPurificationStageInitialState(),
        );
        if (_paramsStreamSubscription != null) {
          await _paramsStreamSubscription!.cancel();
          _paramsStreamSubscription = null;
        }
        _paramsStreamSubscription = databaseOpsRepository.params.listen(
          (databaseEvent) {
            final params = Params.fromJson(
              databaseEvent.snapshot.value as Map<Object?, Object?>,
            );
            if (params.topValve && !params.bottomValve) {
              add(
                const UncleanWaterEnteringEvent(),
              );
            } else if (!params.topValve && !params.bottomValve) {
              add(
                const TreatingUncleanWaterEvent(),
              );
            } else if (!params.topValve && params.bottomValve) {
              add(
                CleanWaterLeavingEvent(
                  waterLevel: params.waterLevel,
                ),
              );
            }
          },
        );
      },
    );
    on<UncleanWaterEnteringEvent>(
      (event, emit) {
        emit(
          const UncleanWaterEnteringState(),
        );
      },
    );
    on<TreatingUncleanWaterEvent>(
      (event, emit) {
        emit(
          const TreatingUncleanWaterState(),
        );
      },
    );
    on<CleanWaterLeavingEvent>(
      (event, emit) {
        emit(
          CleanWaterLeavingState(
            waterLevel: event.waterLevel,
          ),
        );
      },
    );
    on<StopListeningWaterPurificationStagesEvent>(
      (event, emit) async {
        if (_paramsStreamSubscription != null) {
          await _paramsStreamSubscription!.cancel();
          _paramsStreamSubscription = null;
        }
      },
    );
  }
}
