part of 'params_bloc.dart';

abstract class ParamsEvent extends Equatable {
  const ParamsEvent();

  @override
  List<Object?> get props => [];
}

class ListenParamsEvent extends ParamsEvent {
  const ListenParamsEvent();

  @override
  List<Object?> get props => [];
}

class GotParamsEvent extends ParamsEvent {
  final Params params;

  const GotParamsEvent({
    required this.params,
  });

  @override
  List<Object?> get props => [
        params,
      ];
}

class StopListeningParamsEvent extends ParamsEvent {
  const StopListeningParamsEvent();

  @override
  List<Object?> get props => [];
}
