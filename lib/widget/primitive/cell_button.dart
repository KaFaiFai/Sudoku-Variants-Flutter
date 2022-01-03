import 'package:flutter/material.dart';
import '../../constants.dart';

class CellButton extends StatefulWidget {
  final String? text;
  final List<List<String>>? notes;
  final Color displayColor;
  final Color backgroundColor;
  final void Function() onPress;
  final double width;
  final double height;

  const CellButton({
    this.text,
    this.notes,
    this.width = 40,
    this.height = 40,
    Color? displayColor,
    Color? backgroundColor,
    required this.onPress,
    Key? key,
  })  : displayColor = displayColor ?? PRIMARY_COLOR,
        backgroundColor = backgroundColor ?? Colors.transparent,
        super(key: key);

  @override
  State<CellButton> createState() => _CellButtonState();
}

class _CellButtonState extends State<CellButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        child: widget.text != null
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.text!,
                  style: TextStyle(fontSize: 30, color: widget.displayColor),
                ),
              )
            : widget.notes != null
                ? _buildNotes(context, widget.notes!)
                : Container(),
        color: widget.backgroundColor,
        width: widget.width,
        height: widget.height,
      ),
    );
  }

  Widget _buildNotes(BuildContext context, List<List<String>> notes) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: List.generate(
          3,
          (i) => Expanded(
            child: Row(
              children: List.generate(
                3,
                (j) => Expanded(
                  child: Center(
                    child: Text(
                      notes[i][j],
                      style: TextStyle(fontSize: 8, color: TERTIARY_COLOR[50]),
                    ),
                  ),
                ),
              ),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
