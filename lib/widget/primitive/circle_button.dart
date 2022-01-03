import 'package:flutter/material.dart';
import '../../constants.dart';

class CircleButton extends StatelessWidget {
  final void Function() onPress;
  final String text;

  const CircleButton({
    required this.onPress,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      child: Text(text, style: const TextStyle(fontSize: 20)),
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        primary: CONTRAST_COLOR[900],
      ),
    );
  }
}
