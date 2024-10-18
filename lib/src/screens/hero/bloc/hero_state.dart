part of 'hero_bloc.dart';

sealed class HeroState extends Equatable {
  const HeroState();

  @override
  List<Object?> get props => [];
}

final class HeroInitialState extends HeroState {
  const HeroInitialState();
}

final class HeroLoadingState extends HeroState {
  const HeroLoadingState();
}

final class HeroLoadedState extends HeroState {
  const HeroLoadedState({required this.hero});

  final CharacterDomain hero;
}

final class HeroDioErrorState extends HeroState {
  const HeroDioErrorState({
    required this.error,
  });

  final CustomDioError error;

  @override
  List<Object?> get props => [error];
}

final class HeroErrorState extends HeroState {
  const HeroErrorState({required this.error});

  final Object? error;
}
