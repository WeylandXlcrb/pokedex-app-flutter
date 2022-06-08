import 'package:flutter/material.dart';

class StrokeFadeOutText extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle? style;

  const StrokeFadeOutText({
    Key? key,
    required this.text,
    this.style,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        colors: [
          Colors.white,
          Colors.white.withOpacity(0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0, 0.75],
      ).createShader(rect),
      child: Text(
        text,
        style: TextStyle(
          foreground: Paint()
            ..color = color
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
        ).merge(style),
      ),
    );
  }
}
