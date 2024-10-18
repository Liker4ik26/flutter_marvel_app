import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:marvel/src/core/app/navigation/routes/routes.dart';
import 'package:marvel/src/core/app/styles/themes.dart';
import 'package:marvel/src/core/common/bloc/connectivity/connectivity_bloc.dart';
import 'package:marvel/src/core/repositories/heroes/data/character_repository.dart';
import 'package:marvel/src/core/repositories/heroes/data/character_repository_impl.dart';
import 'package:marvel/src/core/repositories/heroes/data/remote/character_api_data_source.dart';
import 'package:marvel/src/screens/hero_list/bloc/heroes_list_screen_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return RepositoryProvider<CharacterRepository>(
      create: (context) => CharacterRepositoryImpl(
        dataSource: GetIt.I.get<CharacterApiDataSource>(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HeroesListBloc(
              characterRepository: context.read<CharacterRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ConnectivityBloc(Connectivity()),
          ),
        ],
        child: KeyboardDismisser(
          gestures: const [
            GestureType.onTap,
            GestureType.onPanUpdateDownDirection,
          ],
          child: MaterialApp.router(
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRoutes.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  }
}
