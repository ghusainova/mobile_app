import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocsBtnsBarWidget extends StatelessWidget {
  const DocsBtnsBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getNavBtn(context, 'Продолжить\nсканирование'),
          getNavBtn(context, 'Сохранить'),
        ],
      ),
    );
  }

  Widget getNavBtn(BuildContext context, String title) {
    return TextButton(
      onPressed: () => context.pop(),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
