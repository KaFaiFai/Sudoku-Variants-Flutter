import 'package:flutter/material.dart';

class FractionalWidget extends StatelessWidget {
  final double proportion;
  final Color color;
  final Widget? child;

  const FractionalWidget({
    double proportion = 1,
    required this.color,
    this.child,
    Key? key,
  })  : proportion = proportion < 0
            ? 0
            : proportion < 1
                ? proportion
                : 1,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [proportion, proportion, 1],
          colors: [
            color,
            Colors.transparent,
            Colors.transparent,
          ],
        ).createShader(rect);
      },
      child: child,
    );
  }
}
