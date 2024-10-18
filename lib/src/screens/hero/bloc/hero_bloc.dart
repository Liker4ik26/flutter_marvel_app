import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/src/core/repositories/heroes/data/character_repository.dart';
import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';
import 'package:marvel/src/core/utils/custom_dio_error.dart';

part 'hero_event.dart';
part 'hero_state.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  HeroBloc({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository,
        super(const HeroInitialState()) {
    on<LoadHeroEvent>(_loadHero);
  }

  Future<void> _loadHero(
    LoadHeroEvent event,
    Emitter<HeroState> emit,
  ) async {
    try {
      if (state is! HeroLoadedState) {
        emit(const HeroLoadingState());
      }
      final hero = await _characterRepository.getHeroById(heroId: event.heroId);

      emit(HeroLoadedState(hero: hero));
    } on CustomDioError catch (e) {
      emit(HeroDioErrorState(error: e));
    } catch (e) {
      emit(
        HeroErrorState(error: e),
      );
    }
  }

  final CharacterRepository _characterRepository;
}
