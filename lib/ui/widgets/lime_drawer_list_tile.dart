import 'package:flutter/material.dart';

import 'package:sales_engine/ui/common/app_colors.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final VoidCallback tap;

  const DrawerListTile({Key? key, required this.title, required this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      title: Text(
        title,
        style: const TextStyle(color: kcPrimaryUltraLightColor),
      ),
    );
  }
}
