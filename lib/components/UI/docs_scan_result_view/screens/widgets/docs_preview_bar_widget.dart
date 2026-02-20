import 'dart:io';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../styles/app_colors.dart';

class DocsPreviewBarWidget extends StatelessWidget {
  final List<File> docFiles;
  final void Function(int index) onDelete;

  const DocsPreviewBarWidget({
    required this.docFiles,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: docFiles.length,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        itemBuilder: (context, index) => _ImageItem(
          file: docFiles[index],
          onDelete: () => onDelete(index),
        ),
      ),
    );
  }
}

class _ImageItem extends StatelessWidget {
  final File file;
  final VoidCallback onDelete;

  const _ImageItem({
    required this.file,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: const Icon(Icons.close, color: Colors.white, size: 12),
      badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.inactiveText),
      onTap: onDelete,
      child: Image.file(
        file,
        width: MediaQuery.of(context).size.width / 5.5,
        height: MediaQuery.of(context).size.height / 13,
        fit: BoxFit.cover,
      ),
    );
  }
}
