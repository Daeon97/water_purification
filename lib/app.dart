import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'repositories/bluetooth_repository.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: _repositoryProviders,
        child: MultiBlocProvider(
          providers: _blocProviders,
          child: MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: baseColor,
            ),
            onGenerateRoute: _routes,
          ),
        ),
      );

  List<RepositoryProvider> get _repositoryProviders => [
        RepositoryProvider<BluetoothRepository>(
          create: (_) => const BluetoothRepository(),
        ),
      ];

  List<BlocProvider> get _blocProviders => [
        BlocProvider<BluetoothBloc>(
          create: (bluetoothContext) => BluetoothBloc(
            bluetoothContext.read<BluetoothRepository>(),
          ),
        ),
      ];

  Route _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
}
