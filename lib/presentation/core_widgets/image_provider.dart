import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto/presentation/core_widgets/loader/dot_loader.dart';

class KImageProvider extends StatelessWidget {
  final String imageUrl;
  final Color? backgroundColor;
  final Duration? fadeInDuration;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const KImageProvider(
    this.imageUrl, {
    Key? key,
    this.backgroundColor,
    this.fadeInDuration = const Duration(milliseconds: 200),
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = CachedNetworkImage(
      cacheKey: imageUrl,
      imageUrl: imageUrl,
      fadeInDuration: fadeInDuration!,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
      ),
      placeholder: (context, url) {
        return SizedBox.expand(
          child: Container(
            color: backgroundColor,
            alignment: Alignment.center,
            child: const DotLoader(),
          ),
        );
      },
      errorWidget: (context, error, stackTrace) {
        return SizedBox.expand(
          child: Container(
            color: backgroundColor,
            child: Center(
              child: Icon(
                Icons.image_not_supported,
                size: (height ?? 6) / 6,
              ),
            ),
          ),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: widget,
      );
    } else {
      return widget;
    }
  }
}
