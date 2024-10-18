part of 'heroes_list_screen_bloc.dart';

@immutable
abstract class HeroesListState extends Equatable {
  const HeroesListState();

  @override
  List<Object?> get props => [];
}

final class HeroesListInitialState extends HeroesListState {
  const HeroesListInitialState();
}

final class HeroesListLoadingState extends HeroesListState {
  const HeroesListLoadingState();
}

final class HeroesListLoadedState extends HeroesListState {
  const HeroesListLoadedState({required this.characters});

  final List<CharacterDomain> characters;

  @override
  List<Object?> get props => super.props..addAll(characters);
}

final class HeroesListDioErrorState extends HeroesListState {
  const HeroesListDioErrorState({
    required this.error,
  });

  final CustomDioError error;

  @override
  List<Object?> get props => [error];
}

final class HeroesListErrorState extends HeroesListState {
  const HeroesListErrorState({
    required this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
