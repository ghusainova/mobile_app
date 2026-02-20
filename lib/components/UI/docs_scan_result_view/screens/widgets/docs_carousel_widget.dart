import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../styles/app_colors.dart';

class DocsCarouselWidget extends StatefulWidget {
  final List<File> docFiles;
  final CarouselController carouselController;

  const DocsCarouselWidget({
    required this.docFiles,
    required this.carouselController,
    super.key,
  });

  @override
  State<DocsCarouselWidget> createState() => _DocsCarouselWidgetState();
}

class _DocsCarouselWidgetState extends State<DocsCarouselWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          color: AppColors.lightGray,
          height: MediaQuery.of(context).size.height / 1.5,
          margin: const EdgeInsets.only(top: kToolbarHeight),
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: CarouselSlider(
            carouselController: widget.carouselController,
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 0.92,
              initialPage: currentIndex,
              enableInfiniteScroll: false,
              onPageChanged: (index, _) => setState(() => currentIndex = index),
            ),
            items: widget.docFiles
                .map((e) => Image.file(e, fit: BoxFit.cover))
                .toList(),
          ),
        ),
        Positioned(
          left: 0,
          child: _NavArrowWidget(
            onTap: () => widget.carouselController.previousPage(),
          ),
        ),
        Positioned(
          right: 0,
          child: _NavArrowWidget(
            reverse: true,
            onTap: () => widget.carouselController.nextPage(),
          ),
        ),
      ],
    );
  }
}

class _NavArrowWidget extends StatelessWidget {
  final bool reverse;
  final VoidCallback onTap;

  const _NavArrowWidget({
    required this.onTap,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blackBg.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          reverse
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
