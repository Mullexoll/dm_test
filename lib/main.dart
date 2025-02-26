import 'package:dayme_test/config/theme.config.dart';
import 'package:dayme_test/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:dayme_test/presentation/screens/home_screen/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(DaymeApp());
  });
}

class DaymeApp extends StatelessWidget {
  const DaymeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc()
            ..add(
              AppInitialEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => GameBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Dayme',
        theme: ThemeConfig.lightTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
