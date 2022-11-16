import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'repositories/database_ops_repository.dart';
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
              primaryColor: Colors.white,
              primaryColorLight: Colors.white70,
              primaryColorDark: Colors.white38,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  color: Colors.white54,
                  fontSize: 56,
                ),
                bodyMedium: TextStyle(
                  color: baseColor,
                  fontSize: 24,
                ),
                bodySmall: TextStyle(
                  color: baseColor,
                  fontSize: 16,
                ),
              ),
              progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: Colors.white54,
                circularTrackColor: Colors.transparent,
              ),
            ),
            onGenerateRoute: _routes,
          ),
        ),
      );

  List<RepositoryProvider> get _repositoryProviders => [
        RepositoryProvider<DatabaseOpsRepository>(
          create: (_) => DatabaseOpsRepository(),
        ),
      ];

  List<BlocProvider> get _blocProviders => [
        BlocProvider<DatabaseOpsBloc>(
          create: (databaseOpsContext) => DatabaseOpsBloc(
            databaseOpsContext.read<DatabaseOpsRepository>(),
          ),
        ),
      ];

  Route _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
}
