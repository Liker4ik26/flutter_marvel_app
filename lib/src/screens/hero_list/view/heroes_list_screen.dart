import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/src/core/app/styles/dimensions.dart';
import 'package:marvel/src/core/common/bloc/connectivity/connectivity_bloc.dart';
import 'package:marvel/src/core/extensions/context_extensions.dart';
import 'package:marvel/src/core/extensions/widget_modifier.dart';
import 'package:marvel/src/core/utils/random_color.dart';
import 'package:marvel/src/generated/assets.dart';
import 'package:marvel/src/screens/hero_list/bloc/heroes_list_screen_bloc.dart';
import 'package:marvel/src/screens/hero_list/view/widgets/heroes_list.dart';
import 'package:marvel/src/screens/hero_list/view/widgets/triangle_painter.dart';

class HeroesListScreen extends StatefulWidget {
  const HeroesListScreen({super.key});

  @override
  State<HeroesListScreen> createState() => _HeroesListScreenState();
}

class _HeroesListScreenState extends State<HeroesListScreen> {
  Color _currentColor = getRandomColor();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return RefreshIndicator(
      color: context.color.primary,
      backgroundColor: context.color.backgroundColor,
      onRefresh: () {
        final completer = Completer();

        context.read<HeroesListBloc>().add(
              LoadCharactersEvent(completer: completer),
            );

        return completer.future;
      },
      child: Scaffold(
        backgroundColor: context.color.backgroundColor,
        appBar: orientation == Orientation.portrait
            ? AppBar(
                toolbarHeight: 80,
                backgroundColor: context.color.backgroundColor,
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 50),
                  child: Text(
                    context.tr.mainScreenTitle,
                    style: context.text.interBlack28,
                  ).paddingOnly(bottom: 10),
                ),
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Image.asset(
                  Assets.imagesIcLogo,
                  height: 40,
                ),
              )
            : null,
        body: BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            if (state is ConnectivityInitialState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.medium,
                    ),
                  ),
                  backgroundColor: context.color.tertiary,
                  content: Text(context.tr.mainScreenInitializingConnection),
                ),
              );
            } else if (state is ConnectivitySuccessState) {
              if (state.isConnected) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.medium,
                      ),
                    ),
                    backgroundColor: context.color.onPrimary,
                    content: Text(context.tr.mainScreenInternetConnection),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.medium,
                      ),
                    ),
                    backgroundColor: context.color.error,
                    content: Text(context.tr.mainScreenConnectionLost),
                  ),
                );
              }
            }
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder(
                bloc: context.read<HeroesListBloc>()
                  ..add(const LoadCharactersEvent(completer: null)),
                builder: (context, state) {
                  if (state is HeroesListErrorState) {
                    return SliverFillRemaining(
                      child: Column(
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
                      ).paddingSymmetric(horizontal: 16),
                    );
                  }
                  if (state is HeroesListLoadedState) {
                    return SliverFillRemaining(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: TriangleWidget(
                              color: _currentColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SafeArea(
                              minimum: const EdgeInsets.symmetric(vertical: 30),
                              child: orientation == Orientation.portrait
                                  ? HeroesList(
                                      charactersList: state.characters,
                                      onChangedHero: (index) {
                                        setState(() {
                                          _currentColor =
                                              state.characters[index].color;
                                        });
                                      },
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                Assets.imagesIcLogo,
                                                height: 40,
                                              ).paddingOnly(bottom: 10),
                                              Text(
                                                context.tr.mainScreenTitle,
                                                style:
                                                    context.text.interBlack28,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SafeArea(
                                            minimum: const EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: SizedBox(
                                              child: HeroesList(
                                                charactersList:
                                                    state.characters,
                                                onChangedHero: (index) {
                                                  setState(() {
                                                    _currentColor = state
                                                        .characters[index]
                                                        .color;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.color.primary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
