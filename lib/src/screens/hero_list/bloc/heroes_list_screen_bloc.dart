import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/src/core/repositories/heroes/data/character_repository.dart';
import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';
import 'package:marvel/src/core/utils/custom_dio_error.dart';

part 'heroes_list_screen_event.dart';
part 'heroes_list_screen_state.dart';

class HeroesListBloc extends Bloc<HeroListEvent, HeroesListState> {
  HeroesListBloc({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository,
        super(const HeroesListInitialState()) {
    on<LoadCharactersEvent>(_loadCharacters);
  }

  Future<void> _loadCharacters(
    LoadCharactersEvent event,
    Emitter<HeroesListState> emit,
  ) async {
    try {
      if (state is! HeroesListLoadedState) {
        emit(const HeroesListLoadingState());
      }

      final characters = await _characterRepository.getCharacters();

      emit(HeroesListLoadedState(characters: characters));
    } on CustomDioError catch (e) {
      emit(HeroesListDioErrorState(error: e));
    } catch (e) {
      emit(
        HeroesListErrorState(error: e),
      );
    } finally {
      event.completer?.complete();
    }
  }

  final CharacterRepository _characterRepository;
}
