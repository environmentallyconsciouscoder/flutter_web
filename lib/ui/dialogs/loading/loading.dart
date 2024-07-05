import 'package:flutter/material.dart';
import 'package:sales_engine/ui/common/ui_helpers.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [CircularProgressIndicator(), verticalSpaceSmall, Text('Loading')],
        ),
      ),
    );
  }
}
