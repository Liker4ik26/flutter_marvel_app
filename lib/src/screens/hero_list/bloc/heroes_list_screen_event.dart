part of 'heroes_list_screen_bloc.dart';

@immutable
abstract class HeroListEvent extends Equatable {
  const HeroListEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCharactersEvent extends HeroListEvent {
  const LoadCharactersEvent({
    required this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}
