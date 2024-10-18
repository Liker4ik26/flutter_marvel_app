import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:marvel/src/core/app/styles/dimensions.dart';
import 'package:marvel/src/core/common/widgets/card_image.dart';
import 'package:marvel/src/core/extensions/context_extensions.dart';
import 'package:marvel/src/core/extensions/widget_extensions.dart';
import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';

class HeroDetails extends StatelessWidget {
  const HeroDetails({super.key, required this.hero});

  final CharacterDomain hero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Material(
        borderRadius: BorderRadius.circular(AppDimensions.medium),
        child: Stack(
          children: [
            CardImage(
              borderRadius: BorderRadius.circular(AppDimensions.medium),
              imageUrl: '${hero.thumbnail.path}.${hero.thumbnail.extension}',
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.color.secondary.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(AppDimensions.medium),
                    boxShadow: [
                      BoxShadow(
                        color: context.color.secondary.withOpacity(0.6),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hero.name!,
                        style: context.text.interBlack32,
                      ).paddingOnly(bottom: 10),
                      if (hero.description != null &&
                          hero.description!.isNotEmpty)
                        Text(
                          hero.description!,
                          style:
                              context.text.interBlack28.copyWith(fontSize: 16),
                        ).paddingOnly(bottom: 20),
                    ],
                  ).paddingAll(10),
                ),
              ),
            ).paddingAll(10),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: context.color.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
