import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final double height;
  final double width;
  final BoxBorder? border;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? highlightColor;
  final Widget? child;
  final void Function()? onTap;

  const SimpleButton({
    this.height = 35,
    this.width = 200,
    this.border,
    double? borderRadius,
    this.backgroundColor,
    this.highlightColor,
    this.child,
    this.onTap,
    Key? key,
  })  : borderRadius = borderRadius ?? height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: backgroundColor,
      ),
      child: InkWell(
        child: Center(child: child),
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        highlightColor: highlightColor,
        splashFactory: NoSplash.splashFactory,
      ),
    );
  }
}
