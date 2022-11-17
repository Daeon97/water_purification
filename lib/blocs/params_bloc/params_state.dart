part of 'params_bloc.dart';

abstract class ParamsState extends Equatable {
  const ParamsState();

  @override
  List<Object?> get props => [];
}

class ParamsInitialState extends ParamsState {
  const ParamsInitialState();

  @override
  List<Object?> get props => [];
}

class GettingParamsState extends ParamsState {
  const GettingParamsState();

  @override
  List<Object?> get props => [];
}

class GotParamsState extends ParamsState {
  final Params params;

  const GotParamsState({
    required this.params,
  });

  @override
  List<Object?> get props => [
        params,
      ];
}
