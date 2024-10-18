import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:marvel/src/core/repositories/heroes/data/remote/models/character_response.dart';
import 'package:marvel/src/core/utils/custom_dio_error.dart';

enum _Endpoints {
  characters('/v1/public/characters');

  const _Endpoints(this.endpoint);

  final String endpoint;
}

class CharacterApiDataSource {
  CharacterApiDataSource({
    required Dio dio,
    required String publicApiKey,
    required String privateApiKey,
    required DefaultCacheManager cacheManager,
  })  : _dio = dio,
        _publicApiKey = publicApiKey,
        _privateApiKey = privateApiKey,
        _cacheManager = cacheManager;

  final Dio _dio;
  final String _publicApiKey;
  final String _privateApiKey;
  final DefaultCacheManager _cacheManager;

  Future<List<CharacterResponse>> getHeroes() async {
    const timeStamp = 1;
    final hash = md5
        .convert(utf8.encode('$timeStamp$_privateApiKey$_publicApiKey'))
        .toString();

    final url = '${_Endpoints.characters.endpoint}?timeStamp=$timeStamp&apikey='
        '$_publicApiKey&hash=$hash';

    final cachedFile = await _cacheManager.getFileFromCache(url);

    if (cachedFile != null) {
      final cachedData = await cachedFile.file.readAsString();

      final jsonData = json.decode(cachedData);
      final charactersData = List<Map<String, dynamic>>.
      from(jsonData['data']['results']);

      final characters = charactersData
          .map(CharacterResponse.fromJson)
          .toList();

      return characters;
    }
    try {
      final response = await _dio.get(
        _Endpoints.characters.endpoint,
        queryParameters: {
          'ts': timeStamp,
          'apikey': _publicApiKey,
          'hash': hash,
        },
      );
      await _cacheManager.putFile(
        url,
        utf8.encode(
          json.encode(response.data),
        ),
      );
      final charactersData = List<Map<String, dynamic>>.
      from(response.data['data']['results']);

      final characters = charactersData
          .map(CharacterResponse.fromJson)
          .toList();

      return characters;
    } on DioException catch (e) {
      final error = CustomDioError.handleError(e);
      return Future.error(CustomDioError.formatErrorMessage(error));
    } catch (e) {
      final Exception unknownError = UnknownErrorException();
      return Future.error(CustomDioError.formatErrorMessage(unknownError));
    }
  }

  Future<CharacterResponse> getHeroById(int characterId) async {
    const timeStamp = 1;
    final hash = md5
        .convert(utf8.encode('$timeStamp$_privateApiKey$_publicApiKey'))
        .toString();

    final url = '${_Endpoints.characters.endpoint}?timeStamp='
        '$timeStamp&id=$characterId&apikey=$_publicApiKey&hash=$hash';

    final cachedFile = await _cacheManager.getFileFromCache(url);

    if (cachedFile != null) {
      final cachedData = await cachedFile.file.readAsString();

      final jsonData = json.decode(cachedData);

      final charactersData = (jsonData['data']['results'] as List)
          .cast<Map<String, dynamic>>();

      final characters = charactersData
          .map(CharacterResponse.fromJson)
          .toList();

      if (characters.isNotEmpty) {
        return characters.first;
      } else {
        return Future.error('No hero found in cached data');
      }
    }
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _Endpoints.characters.endpoint,
        queryParameters: {
          'ts': timeStamp,
          'id': characterId,
          'apikey': _publicApiKey,
          'hash': hash,
        },
      );

      final data = List<Map<String, dynamic>>.
      from(response.data?['data']['results']);

      if (data.isEmpty) {
        return Future.error('No hero found with that ID');
      }

      final hero = CharacterResponse.fromJson(data.first);

      await _cacheManager.putFile(
        url,
        utf8.encode(
          json.encode(response.data),
        ),
      );

      return hero;
    } on DioException catch (e) {
      final error = CustomDioError.handleError(e);
      return Future.error(CustomDioError.formatErrorMessage(error));
    } catch (e) {
      final Exception unknownError = UnknownErrorException();
      return Future.error(CustomDioError.formatErrorMessage(unknownError));
    }
  }
}
