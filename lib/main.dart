import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel/firebase_options.dart';
import 'package:marvel/src/core/app/app.dart';
import 'package:marvel/src/core/firebase/firebase_api.dart';
import 'package:marvel/src/core/repositories/heroes/data/remote/character_api_data_source.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifications();

  GetIt.I
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: dotenv.env['MARVEL_URL']!,
        ),
      ),
    )
    ..registerLazySingleton(
      () => CharacterApiDataSource(
        dio: GetIt.I.get<Dio>(),
        publicApiKey: dotenv.env['MARVEL_PUBLIC_KEY']!,
        privateApiKey: dotenv.env['MARVEL_PRIVATE_KEY']!,
        cacheManager: DefaultCacheManager(),
      ),
    )
    ..registerLazySingleton<String>(
      () => dotenv.env['MARVEL_PUBLIC_KEY']!,
      instanceName: 'apiKey',
    );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const App());
}
