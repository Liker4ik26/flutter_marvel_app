import 'package:flutter/cupertino.dart';
import 'package:marvel/src/core/app/styles/dimensions.dart';
import 'package:marvel/src/core/extensions/context_extensions.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({super.key, this.bgColor});

  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.medium),
      child: Container(
        color: bgColor ?? context.color.primary,
      ),
    );
  }
}
