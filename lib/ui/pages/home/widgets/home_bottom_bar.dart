import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockito_dating_app/ui/pages/home/home_controller.dart';
import 'package:mockito_dating_app/ui/pages/home/widgets/home_indicator.dart';
import 'package:mockito_dating_app/ui/utils/app/app_utils.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:provider/provider.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Provider.of<HomeController>(context, listen: false);
    final int currentPage = context.select<HomeController, int>(
      (_) => _.currentPage,
    );
    final bottomBarIcons = context.select<HomeController, List<BottomBarItem>>(
      (_) => _.bottomBarIcons,
    );
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    //? BOTTOM BAR TAB
    return Container(
      color: invColor,
      height: hp * 0.08,
      child: SafeArea(
        top: false,
        child: TabBar(
          controller: homeCtrl.tabController,
          indicator: const HomeTabBarIndicator(),
          //? BOTTOM TAB ITEM
          tabs: List.generate(
            bottomBarIcons.length,
            (index) {
              final item = bottomBarIcons[index];
              return BottomBarTab(
                item: item,
                isActive: currentPage == index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class BottomBarTab extends StatelessWidget {
  const BottomBarTab({
    Key? key,
    required this.item,
    required this.isActive,
  }) : super(key: key);

  final BottomBarItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? darkColor1 : gColor2;
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: hp * 0.01),
      //? ICON BOTTON TAB
      child: AppUtils.isHtml
          ? Image.network(
              item.icon,
              color: color,
              fit: BoxFit.contain,
            )
          : SvgPicture.asset(
              item.icon,
              color: color,
              fit: BoxFit.contain,
            ),
    );
    //? NOTIFICATION BADGE BOTTON TAB
    return Tab(
      key: Key(item.label),
      icon: item.badgeCount > 0
          ? Badge(
              badgeContent: Text(
                '${item.badgeCount}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              animationType: BadgeAnimationType.scale,
              badgeColor: Colors.redAccent,
              elevation: 4,
              child: content,
            )
          : content,
    );
  }
}
