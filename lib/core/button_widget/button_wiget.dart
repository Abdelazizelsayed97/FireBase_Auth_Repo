import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.color,
      required this.child,
      this.width,
      this.onPress});

  final Color color;
  final Widget child;
  final double? width;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(color),
          fixedSize: WidgetStatePropertyAll<Size>(
            Size.fromWidth(width ?? double.maxFinite),
          ),
        ),
        onPressed: onPress,
        statesController: WidgetStatesController(),
        child: child);
  }
}
