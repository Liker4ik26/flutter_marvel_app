import 'package:marvel/src/core/repositories/heroes/data/character_repository.dart';
import 'package:marvel/src/core/repositories/heroes/data/remote/character_api_data_source.dart';
import 'package:marvel/src/core/repositories/heroes/data/remote/models/mappers/character_domain_mapper.dart';
import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  const CharacterRepositoryImpl({
    required CharacterApiDataSource dataSource,
  }) : _dataSource = dataSource;

  final CharacterApiDataSource _dataSource;

  @override
  Future<List<CharacterDomain>> getCharacters() async {
    final charactersResponse = await _dataSource.getHeroes();

    final characters = charactersResponse.map((e) => e.toDomain()).toList();

    return characters;
  }

  @override
  Future<CharacterDomain> getHeroById({
    required int heroId,
  }) async {
    final heroResponse = await _dataSource.getHeroById(heroId);

    final hero = heroResponse.toDomain();

    return hero;
  }
}
