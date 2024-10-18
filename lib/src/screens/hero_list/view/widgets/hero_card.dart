import 'package:flutter/material.dart';
import 'package:marvel/src/core/app/styles/dimensions.dart';
import 'package:marvel/src/core/common/widgets/card_image.dart';
import 'package:marvel/src/core/extensions/context_extensions.dart';
import 'package:marvel/src/core/extensions/widget_modifier.dart';
import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    this.onTap,
    required this.character,
  });

  final VoidCallback? onTap;
  final CharacterDomain character;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width / 2,
      child: Material(
        borderRadius: BorderRadius.circular(AppDimensions.medium),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.medium),
          child: Stack(
            children: [
              CardImage(
                borderRadius: BorderRadius.circular(AppDimensions.medium),
                imageUrl: '${character.thumbnail.path}.'
                    '${character.thumbnail.extension}',
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.medium),
                    boxShadow: [
                      BoxShadow(
                        color: context.color.secondary.withOpacity(0.6),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Text(
                    character.name!,
                    style: context.text.interBlack32,
                  ).paddingAll(20),
                ),
              ).paddingAll(10),
            ],
          ),
        ),
      ).paddingOnly(
        right: orientation == Orientation.portrait ? 10 : 40,
        left: orientation == Orientation.portrait ? 10 : 10,
      ),
    );
  }
}
