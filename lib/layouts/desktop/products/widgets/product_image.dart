import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final placeholderColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: imageUrl.trim().isEmpty
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: placeholderColor,
            )
          : CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              fadeInDuration: const Duration(milliseconds: 300),
              fadeOutDuration: const Duration(milliseconds: 100),
              memCacheWidth: 500,
              memCacheHeight: 500,
              maxWidthDiskCache: 500,
              maxHeightDiskCache: 500,
              placeholder: (context, _) => Container(
                color: placeholderColor,
                child: const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (context, url, error) {
                return ColoredBox(
                  color: placeholderColor,
                  child: const Icon(Icons.broken_image_outlined, size: 40),
                );
              },
            ),
    );
  }
}
