import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../repositories/database_ops_repository.dart';
import '../../models/params.dart';

part 'params_event.dart';

part 'params_state.dart';

class ParamsBloc extends Bloc<ParamsEvent, ParamsState> {
  StreamSubscription<DatabaseEvent>? _paramsStreamSubscription;

  ParamsBloc(
    DatabaseOpsRepository databaseOpsRepository,
  ) : super(
          const ParamsInitialState(),
        ) {
    on<ListenParamsEvent>(
      (event, emit) async {
        emit(
          const GettingParamsState(),
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
            add(
              GotParamsEvent(
                params: params,
              ),
            );
          },
        );
      },
    );
    on<GotParamsEvent>(
      (event, emit) {
        emit(
          GotParamsState(
            params: event.params,
          ),
        );
      },
    );
    on<StopListeningParamsEvent>(
      (event, emit) async {
        if (_paramsStreamSubscription != null) {
          await _paramsStreamSubscription!.cancel();
          _paramsStreamSubscription = null;
        }
      },
    );
  }
}
