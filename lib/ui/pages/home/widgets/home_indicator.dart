import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';

class HomeTabBarIndicator extends Decoration {
  const HomeTabBarIndicator({
    this.color = darkColor1,
    this.size = 3.33,
  }) : assert(size > 0);

  final Color color;
  final double size;

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) {
    return _CustomPainter(color, size);
  }
}

//? BOTTOM TAB INDICATOR
class _CustomPainter extends BoxPainter {
  _CustomPainter(this.color, this.size);

  final Color color;
  final double size;

  //? INDICATOR ICON TAB
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final Paint paint = Paint();
    paint.color = color;
    final width = configuration.size?.width;
    final height = configuration.size?.height;
    final Offset pos = Offset(offset.dx + width! / 2, offset.dy + height! - 3);
    canvas.drawCircle(pos, size, paint);
  }
}
