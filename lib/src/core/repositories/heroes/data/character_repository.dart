import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';

abstract interface class CharacterRepository {
  const CharacterRepository._();

  Future<List<CharacterDomain>> getCharacters();

  Future<CharacterDomain> getHeroById({required int heroId});
}
