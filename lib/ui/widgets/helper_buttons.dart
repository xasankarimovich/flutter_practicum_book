import 'package:flutter/material.dart';

class HelperButtons extends StatelessWidget {
  final VoidCallback? firstButtonClick;
  final VoidCallback? secondButtonClick;
  final String firstButtonLabel;
  final String secondButtonLabel;
  final IconData firstIcon;
  final IconData secondIcon;

  const HelperButtons({
    super.key,
    required this.firstButtonClick,
    required this.secondButtonClick,
    required this.firstButtonLabel,
    required this.secondButtonLabel,
    required this.firstIcon,
    required this.secondIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilledButton.icon(
          onPressed: firstButtonClick,
          label: Text(firstButtonLabel),
          icon: Icon(firstIcon),
        ),
        FilledButton.icon(
          onPressed: secondButtonClick,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          label: Text(secondButtonLabel),
          icon: Icon(secondIcon),
        ),
      ],
    );
  }
}
