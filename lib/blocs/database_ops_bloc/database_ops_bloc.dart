import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_purification/repositories/database_ops_repository.dart';

part 'database_ops_event.dart';

part 'database_ops_state.dart';

class DatabaseOpsBloc extends Bloc<DatabaseOpsEvent, DatabaseOpsState> {
  DatabaseOpsBloc(
    DatabaseOpsRepository databaseOpsRepository,
  ) : super(
          const DatabaseOpsInitialState(),
        ) {
    on<DatabaseOpsEvent>(
      (event, emit) {
        //.
      },
    );
  }
}
