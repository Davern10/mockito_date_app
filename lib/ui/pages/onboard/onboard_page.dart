import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/global_widgets/circle_bg.dart';
import 'package:mockito_dating_app/ui/pages/onboard/widgets/slider.dart';
import 'package:mockito_dating_app/ui/pages/onboard/onboard_controller.dart';
import 'package:mockito_dating_app/ui/pages/onboard/widgets/bottom_controls.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final cSize = responsive.hp(25);
    final hp = responsive.hp(100);
    final wp = responsive.wp(100);
    return ChangeNotifierProvider<OnboardController>(
      create: (_) {
        final controller = OnboardController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFirstlayout();
        });
        return controller;
      }, //TODO AQUI 1ERA FALLA
      builder: (context, __) => Scaffold(
        body: SizedBox(
          height: hp,
          width: wp,
          child: Stack(
            children: <Widget>[
              //? BACKGROUND CIRCLES
              CircleBG(
                top: hp * 0.371,
                left: 0 - cSize * 0.15,
                cSize: cSize,
                color: primColor,
              ),
              CircleBG(
                top: 0,
                left: 0 - cSize * 0.6,
                cSize: cSize,
                color: primColor,
              ),
              CircleBG(
                bottom: 0,
                left: 0 - cSize * 0.6,
                cSize: cSize,
                color: primColor,
              ),
              CircleBG(
                top: hp * 0.19,
                left: 0 - cSize * 0.3,
                cSize: cSize,
                color: obscColor2,
              ),
              CircleBG(
                bottom: hp * 0.19,
                left: 0 - cSize * 0.3,
                cSize: cSize,
                color: obscColor2,
              ),
              //? SLIDER MODEL
              const OnboardSlider(),
              //? BOTTOM BUTTON
              const MyButtons(
                alignment: Alignment.bottomCenter,
                myWidget: BottonOnboardControls(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButtons extends StatelessWidget {
  const MyButtons({
    Key? key,
    this.myWidget,
    this.alignment,
  }) : super(key: key);

  final Alignment? alignment;
  final Widget? myWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: myWidget,
    );
  }
}

class CircleBG extends StatelessWidget {
  final double? top, bottom, left, cSize;
  final Color color;

  const CircleBG({
    Key? key,
    this.top,
    this.bottom,
    this.left = 0.0,
    required this.cSize,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      top: top,
      child: Circle(
        size: cSize as double,
        colors: [
          color,
          color.withOpacity(0.66),
          color.withOpacity(0.22),
        ],
      ),
    );
  }
}
