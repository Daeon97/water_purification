import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/bluetooth_repository.dart';

part 'bluetooth_event.dart';

part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  BluetoothBloc(
    BluetoothRepository bluetoothRepository,
  ) : super(
          const BluetoothInitialState(),
        ) {
    on<BluetoothEvent>(
      (event, emit) {
        //.
      },
    );
  }
}
