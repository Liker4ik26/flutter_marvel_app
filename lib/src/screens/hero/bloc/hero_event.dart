part of 'hero_bloc.dart';

@immutable
abstract class HeroEvent {
  const HeroEvent();
}

final class LoadHeroEvent extends HeroEvent {
  const LoadHeroEvent({
    required this.heroId,
  });

  final int heroId;
}
