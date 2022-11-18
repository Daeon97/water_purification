import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../blocs/blocs.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late StateMachineController _stateMachineController;

  late SMIInput<bool> _waterEnteringUvChamberSMIInput;
  late SMIInput<double> _waterInUvChamberLevelSMIInput;

  void _onInit(Artboard artboard) {
    final stateMachineController = StateMachineController.fromArtboard(
      artboard,
      liquidDownloadStateMachineName,
    ) as StateMachineController;

    artboard.addController(
      stateMachineController,
    );

    _waterEnteringUvChamberSMIInput = stateMachineController
        .findInput<bool>(downloadingSMIInput) as SMIInput<bool>;

    _waterInUvChamberLevelSMIInput = stateMachineController
        .findInput<double>(progressSMIInput) as SMIInput<double>;

    _stateMachineController = stateMachineController;
  }

  @override
  void initState() {
    BlocProvider.of<ParamsBloc>(context).add(
      const ListenParamsEvent(),
    );
    BlocProvider.of<WaterPurificationStagesBloc>(context).add(
      const ListenWaterPurificationStagesEvent(),
    );

    super.initState();
  }

  @override
  void deactivate() {
    BlocProvider.of<ParamsBloc>(context).add(
      const StopListeningParamsEvent(),
    );
    BlocProvider.of<WaterPurificationStagesBloc>(context).add(
      const StopListeningWaterPurificationStagesEvent(),
    );
    super.deactivate();
  }

  @override
  void dispose() {
    _stateMachineController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ParamsBloc, ParamsState>(
        listener: (_, paramsState) {
          if (paramsState is GotParamsState) {
            _waterInUvChamberLevelSMIInput.change(
              paramsState.params.waterLevel.toDouble(),
            );
          }
        },
        child: BlocListener<WaterPurificationStagesBloc,
            WaterPurificationStagesState>(
          listener: (_, waterPurificationStagesState) {
            if (waterPurificationStagesState is UncleanWaterEnteringState) {
              _waterEnteringUvChamberSMIInput.change(true);
            } else if (waterPurificationStagesState
                is TreatingUncleanWaterState) {
              _waterEnteringUvChamberSMIInput.change(false);
            } else if (waterPurificationStagesState is CleanWaterLeavingState) {
              if (waterPurificationStagesState.waterLevel.toDouble() == 100.0) {
                _waterInUvChamberLevelSMIInput.change(99.5);
                _waterEnteringUvChamberSMIInput.change(true);
              }
            }
          },
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 400,
                          width: 400,
                          child: BlocBuilder<ParamsBloc, ParamsState>(
                            builder: (_, paramsState) => RiveAnimation.asset(
                              liquidDownloadRiveAsset,
                              onInit: _onInit,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            BlocBuilder<ParamsBloc, ParamsState>(
                              builder: (_, paramsState) =>
                                  paramsState is GotParamsState &&
                                          paramsState.params.waterLevel != 100.0
                                      ? BlocBuilder<WaterPurificationStagesBloc,
                                          WaterPurificationStagesState>(
                                          builder:
                                              (_, waterPurificationStagesState) =>
                                                  Text(
                                            '${paramsState.params.waterLevel.toStringAsFixed(
                                              0,
                                            )}%',
                                            style: waterPurificationStagesState
                                                    is TreatingUncleanWaterState
                                                ? const TextStyle(
                                                    color: Colors.transparent,
                                                    fontSize: 56,
                                                  )
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                          ),
                                        )
                                      : const Text(
                                          '0%',
                                          style: TextStyle(
                                            color: Colors.transparent,
                                            fontSize: 56,
                                          ),
                                        ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<WaterPurificationStagesBloc,
                                WaterPurificationStagesState>(
                              builder: (_, waterPurificationStagesState) =>
                                  waterPurificationStagesState
                                          is TreatingUncleanWaterState
                                      ? Container(
                                          padding: const EdgeInsets.all(
                                            4,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              32,
                                            ),
                                            color: Colors.white38,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              SizedBox(
                                                height: 16,
                                                width: 16,
                                                child: RiveAnimation.asset(
                                                  timerRiveAsset,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '00:10',
                                                style: TextStyle(
                                                  color: timerTextColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(
                                          width: 0.0,
                                          height: 0.0,
                                        ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              32,
                            ),
                            onTap: () {},
                            child: BlocBuilder<ParamsBloc, ParamsState>(
                              builder: (_, paramsState) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    32,
                                  ),
                                  color: paramsState is GotParamsState
                                      ? paramsState.params.topValve
                                          ? Colors.white30
                                          : Colors.black26
                                      : Colors.black26,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    16,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            paramsState is GotParamsState
                                                ? paramsState.params.topValve
                                                    ? FontAwesomeIcons
                                                        .faucetDrip
                                                    : FontAwesomeIcons
                                                        .dropletSlash
                                                : FontAwesomeIcons.faucet,
                                            color: paramsState is GotParamsState
                                                ? paramsState.params.topValve
                                                    ? Colors.white70
                                                    : Colors.white54
                                                : Colors.white54,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            'Top Valve',
                                            style: TextStyle(
                                              color: paramsState
                                                      is GotParamsState
                                                  ? paramsState.params.topValve
                                                      ? Colors.white70
                                                      : Colors.white54
                                                  : Colors.white54,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: paramsState
                                                      is GotParamsState
                                                  ? paramsState.params.topValve
                                                      ? Colors.green
                                                      : Colors.white24
                                                  : Colors.white24,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            paramsState is GotParamsState
                                                ? paramsState.params.topValve
                                                    ? 'Open'
                                                    : 'Closed'
                                                : 'Open',
                                            style: TextStyle(
                                              color: paramsState
                                                      is GotParamsState
                                                  ? paramsState.params.topValve
                                                      ? Colors.white
                                                      : Colors.white70
                                                  : Colors.transparent,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              32,
                            ),
                            onTap: () {},
                            child: BlocBuilder<ParamsBloc, ParamsState>(
                              builder: (_, paramsState) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    32,
                                  ),
                                  color: paramsState is GotParamsState
                                      ? paramsState.params.bottomValve
                                          ? Colors.white30
                                          : Colors.black26
                                      : Colors.black26,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    16,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            paramsState is GotParamsState
                                                ? paramsState.params.bottomValve
                                                    ? FontAwesomeIcons
                                                        .faucetDrip
                                                    : FontAwesomeIcons
                                                        .dropletSlash
                                                : FontAwesomeIcons.faucet,
                                            color: paramsState is GotParamsState
                                                ? paramsState.params.bottomValve
                                                    ? Colors.white70
                                                    : Colors.white54
                                                : Colors.white54,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            'Bottom Valve',
                                            style: TextStyle(
                                              color:
                                                  paramsState is GotParamsState
                                                      ? paramsState.params
                                                              .bottomValve
                                                          ? Colors.white70
                                                          : Colors.white54
                                                      : Colors.white54,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  paramsState is GotParamsState
                                                      ? paramsState.params
                                                              .bottomValve
                                                          ? Colors.green
                                                          : Colors.white24
                                                      : Colors.white24,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            paramsState is GotParamsState
                                                ? paramsState.params.bottomValve
                                                    ? 'Open'
                                                    : 'Closed'
                                                : 'Open',
                                            style: TextStyle(
                                              color:
                                                  paramsState is GotParamsState
                                                      ? paramsState.params
                                                              .bottomValve
                                                          ? Colors.white
                                                          : Colors.white70
                                                      : Colors.transparent,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
