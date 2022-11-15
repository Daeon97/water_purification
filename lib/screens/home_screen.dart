import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
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
      stateMachineName,
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
  void dispose() {
    _stateMachineController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: RiveAnimation.asset(
            liquidDownloadRiveAsset,
            onInit: _onInit,
          ),
        ),
      );
}
