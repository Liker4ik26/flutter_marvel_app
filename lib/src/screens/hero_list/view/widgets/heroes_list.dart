import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marvel/src/core/app/navigation/routes/routes.dart';
import 'package:marvel/src/core/extensions/context_extensions.dart';
import 'package:marvel/src/core/extensions/widget_extensions.dart';
import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';
import 'package:marvel/src/screens/hero_list/bloc/heroes_list_screen_bloc.dart';
import 'package:marvel/src/screens/hero_list/view/widgets/hero_card.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HeroesList extends StatelessWidget {
  const HeroesList({
    super.key,
    required this.charactersList,
    required this.onChangedHero,
  });

  final List<CharacterDomain> charactersList;
  final ValueChanged<int> onChangedHero;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return BlocBuilder(
      bloc: context.read<HeroesListBloc>()
        ..add(const LoadCharactersEvent(completer: null)),
      builder: (context, state) {
        if (state is HeroesListDioErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.error.toString()),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.read<HeroesListBloc>().add(
                      const LoadCharactersEvent(completer: null),
                    ),
                child: Text(context.tr.mainScreenReboot),
              ),
            ],
          ).paddingSymmetric(horizontal: 16);
        }
        if (state is HeroesListLoadedState) {
          return orientation == Orientation.portrait
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ScrollSnapList(
                    itemBuilder: (context, index) => HeroCard(
                      character: charactersList[index],
                      onTap: () => context.pushNamed(
                        AppRoutes.heroRoute,
                        pathParameters: {
                          'heroId': state.characters[index].id.toString(),
                        },
                      ),
                    ),
                    itemCount: charactersList.length,
                    itemSize: MediaQuery.of(context).size.width,
                    onItemFocus: onChangedHero,
                    dynamicItemSize: true,
                    duration: 100,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ScrollSnapList(
                    itemBuilder: (context, index) => HeroCard(
                      character: charactersList[index],
                      onTap: () => context.pushNamed(
                        AppRoutes.heroRoute,
                        pathParameters: {
                          'heroId': state.characters[index].id.toString(),
                        },
                      ),
                    ),
                    shrinkWrap: true,
                    itemCount: charactersList.length,
                    itemSize: MediaQuery.of(context).size.width / 2,
                    onItemFocus: onChangedHero,
                    dynamicItemSize: true,
                    scrollDirection: Axis.horizontal,
                    duration: 100,
                  ),
                );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
