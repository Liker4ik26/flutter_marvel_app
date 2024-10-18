import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/src/core/extensions/context_extensions.dart';
import 'package:marvel/src/core/extensions/widget_extensions.dart';
import 'package:marvel/src/screens/hero/bloc/hero_bloc.dart';
import 'package:marvel/src/screens/hero/view/widgets/hero_details.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key, required this.id});

  @override
  State<HeroScreen> createState() => _HeroScreenState();

  final int id;
}

class _HeroScreenState extends State<HeroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          BlocBuilder<HeroBloc, HeroState>(
            bloc: context.read<HeroBloc>()
              ..add(
                LoadHeroEvent(heroId: widget.id),
              ),
            builder: (context, state) {
              if (state is HeroLoadedState) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      HeroDetails(
                        hero: state.hero,
                      ),
                    ],
                  ),
                );
              }
              if (state is HeroDioErrorState) {
                return SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error.toString(),
                        style: context.text.interBold22,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.read<HeroBloc>().add(
                              LoadHeroEvent(heroId: widget.id),
                            ),
                        child: Text(
                          context.tr.mainScreenReboot,
                          style: context.text.interBold22
                              .copyWith(color: context.color.tertiary),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                );
              }
              if (state is HeroErrorState) {
                return SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error.toString(),
                        style: context.text.interBold22,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.read<HeroBloc>().add(
                              LoadHeroEvent(heroId: widget.id),
                            ),
                        child: Text(
                          context.tr.mainScreenReboot,
                          style: context.text.interBold22
                              .copyWith(color: context.color.tertiary),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16),
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
    );
  }
}
