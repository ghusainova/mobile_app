import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../styles/app_assets.dart';

class CachedImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final double? cacheCoefficient;
  final Map<String, String>? customHeaders;

  const CachedImageWidget(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.cacheCoefficient,
    this.customHeaders,
  });

  Widget get _placeholderWidget => Skeletonizer(
        enabled: true,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      );

  Widget get _errorWidget => SvgPicture.asset(
        AppAssets.imagePlaceholderIcon,
        fit: BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: (imageUrl ?? '').isEmpty
            ? _errorWidget
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                httpHeaders: customHeaders,
                fit: BoxFit.cover,
                fadeOutDuration: const Duration(milliseconds: 200),
                fadeInDuration: const Duration(milliseconds: 200),
                placeholder: (_, __) => _placeholderWidget,
                errorWidget: (_, __, ___) => _errorWidget,
                memCacheWidth: _getMemCacheSize(width),
                memCacheHeight: _getMemCacheSize(height),
                errorListener: _onError,
              ),
      ),
    );
  }

  int? _getMemCacheSize(double? value) {
    if (value == null || value.isInfinite || cacheCoefficient == null) {
      return null;
    }

    final optimizedValue = (cacheCoefficient ?? 1.1) * value;
    return optimizedValue.toInt();
  }

  void _onError(Object e) {
    if (kDebugMode) {
      log('Failed to load image: $imageUrl');
    }
  }
}
