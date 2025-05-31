import 'package:flutter/material.dart';
import 'package:medical_sales/generated/l10n.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          thickness: 1,
          color: Theme.of(context).colorScheme.primaryContainer,
        )),
        Text(S.of(context).or, style: Theme.of(context).textTheme.bodyMedium),
        Expanded(
            child: Divider(
          thickness: 1,
          color: Theme.of(context).colorScheme.primaryContainer,
        )),
      ],
    );
  }
}
