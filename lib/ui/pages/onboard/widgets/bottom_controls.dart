import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/global_widgets/rounded_button.dart';
import 'package:mockito_dating_app/ui/pages/onboard/onboard_controller.dart';

class BottonOnboardControls extends StatelessWidget {
  const BottonOnboardControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardCtrl = OnboardController();
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: wp * 0.1,
      ).copyWith(bottom: hp * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //? SLIDER PAGE INDICATOR
          const _Dots(),
          //? BUTTON SLIDER
          Consumer<OnboardController>(
            builder: (_, controller, __) {
              final double page = controller.currentPage;
              bool isEnd = page % 1 == 0 && page == 2.0;
              //? NEXT-START
              return RoundedButton(
                padding: EdgeInsets.symmetric(
                  horizontal: hp * 0.04,
                ).copyWith(
                  top: hp * 0.01,
                  bottom: hp * 0.01,
                ),
                flWidth: false,
                label: isEnd ? "Get Started" : "Next",
                onPressed: () async {
                  await onboardCtrl.setReady();
                  onboardCtrl.onNext(context, controller);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardController>();
    final responsive = Responsive.of(context);
    final hp = responsive.hp(100);
    final wp = responsive.wp(100);
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          Text(
            '${controller.currentPage.toInt() + 1}',
            style: MyFontStyles.subtitleColor.copyWith(fontSize: wp * 0.05),
          ),
          DotsIndicator(
            dotsCount: controller.items.length,
            position: controller.currentPage,
            decorator: DotsDecorator(
              size: Size.square(hp * 0.02),
              activeSize: Size(hp * 0.033, hp * 0.02),
              color: Colors.grey.withOpacity(0.8),
              activeColor: primColor,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(wp * 0.01),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
