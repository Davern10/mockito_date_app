import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/models/onboard_item.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/ui/utils/app/app_utils.dart';
import 'package:mockito_dating_app/ui/pages/onboard/onboard_controller.dart';

class OnboardSlider extends StatelessWidget {
  const OnboardSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardController>(context, listen: false);
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return PageView(
      controller: controller.pageController,
      children: List.generate(
        controller.items.length,
        (index) {
          final OnboardItem item = controller.items[index];
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: wp * 0.08,
            ).copyWith(
              top: hp * 0.13,
              bottom: hp * 0.13,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                border: Border.all(
                  width: wp * 0.01,
                  color: primColor.withOpacity(0.3),
                ),
                boxShadow: [
                  //? BG TRASPARENT RECTANGLE
                  BoxShadow(
                    color: tertColor.withOpacity(0.3),
                    spreadRadius: wp * 0.02,
                    blurRadius: wp * 0.04,
                    offset: Offset(
                      wp * 0.02,
                      wp * 0.02,
                    ), // changes position of shadow
                  ),
                ],
              ),
              //? ONBOARD SLIDER CONTENT
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: wp * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //? CONTENT IMAGE
                    Flexible(
                      flex: 4,
                      child: AppUtils.isHtml
                          ? Image.network(
                              item.image,
                              width: wp * 0.8,
                            )
                          : SvgPicture.asset(
                              item.image,
                              width: wp * 0.6,
                            ),
                    ),
                    //? CONTENT TITLE
                    Flexible(
                      flex: 2,
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style:
                            MyFontStyles.titles.copyWith(fontSize: hp * 0.06),
                      ),
                    ),
                    //? CONTENT DESCRIPTION
                    Flexible(
                      flex: 2,
                      child: Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: MyFontStyles.normal,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
