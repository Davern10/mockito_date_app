import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    Key? key,
    this.end,
    this.begin,
    this.opacity,
    required this.size,
    required this.colors,
  })  : assert(size > 0),
        assert(colors.length >= 2),
        super(key: key);

  final double size;
  final double? opacity;
  final List<Color> colors;
  final FractionalOffset? end, begin;

  @override
  Widget build(BuildContext context) {
    final begin = this.begin ?? FractionalOffset.centerRight;
    final end = this.end ?? FractionalOffset.centerLeft;
    const opacity = 0.6;
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            // stops: [0.2, 0.6, 0.9],
            colors: colors,
            begin: begin,
            end: end,
          ),
        ),
      ),
    );
  }
}
