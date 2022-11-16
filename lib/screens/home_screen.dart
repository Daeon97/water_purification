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

class _HomeScreenState extends State<HomeScreen> {
  late StateMachineController _stateMachineController;
  late SMIInput<bool> _waterEnteringUvChamber;
  late SMIInput<double> _waterInUvChamberLevel;

  void _onInit(Artboard artboard) {
    final stateMachineController = StateMachineController.fromArtboard(
      artboard,
      liquidDownloadStateMachineName,
    ) as StateMachineController
      ..isActive = true;

    artboard.addController(
      stateMachineController,
    );

    _waterEnteringUvChamber = stateMachineController
        .findInput<bool>(downloadingAnimation) as SMIInput<bool>;
    _waterEnteringUvChamber.change(true);

    _waterInUvChamberLevel = stateMachineController
        .findInput<double>(progressAnimation) as SMIInput<double>;
    _waterInUvChamberLevel.change(40.0);

    _stateMachineController = stateMachineController;
  }

  @override
  void initState() {
    // BlocProvider.of<BluetoothBloc>(context).add(
    //   const ScanForBluetoothDevicesEvent(),
    // );
    super.initState();
  }

  @override
  void dispose() {
    _stateMachineController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<DatabaseOpsBloc, DatabaseOpsState>(
        listener: (databaseOpsContext, databaseOpsState) {
          //.
        },
        child: BlocBuilder<DatabaseOpsBloc, DatabaseOpsState>(
          builder: (bluetoothContext, bluetoothState) => Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 32,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 16,
                  //   ),
                  //   child: Container(
                  //     height: 64,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(
                  //         32,
                  //       ),
                  //       color: Colors.white38,
                  //     ),
                  //   ),
                  // ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 400,
                        child: RiveAnimation.asset(
                          liquidDownloadRiveAsset,
                          onInit: _onInit,
                        ),
                      ),
                      Text(
                        '40%',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 250,
                        width: 250,
                        child: CircularProgressIndicator(
                          value: 0.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              32,
                            ),
                            color: Colors.black38,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: RiveAnimation.asset(
                                    oxygenCompressorValveRiveAsset,
                                    animations: [
                                      animationOne,
                                    ],
                                  ),
                                ),
                                Text(
                                  'Top Valve',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Open',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              32,
                            ),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                const SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: RiveAnimation.asset(
                                    timerRiveAsset,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  '00:31',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              32,
                            ),
                            color: Colors.white12,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: RiveAnimation.asset(
                                    oxygenCompressorValveRiveAsset,
                                    animations: [
                                      animationTwo,
                                    ],
                                  ),
                                ),
                                Text(
                                  'Off',
                                  style: TextStyle(
                                    color: Colors.white12,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
