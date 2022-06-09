import 'package:flutter/material.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/widgets/stroke_fade_out_text.dart';

class StrokeDecorationText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;

  const StrokeDecorationText({
    Key? key,
    required this.text,
    this.style,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: FittedBox(
        fit: BoxFit.none,
        alignment: Alignment.center,
        child: StrokeFadeOutText(
          text: text.hyphenToPascalWord().toUpperCase(),
          style: style,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
