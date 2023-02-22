import 'package:flutter/material.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/ui/global_widgets/circle_bg.dart';
import 'package:mockito_dating_app/ui/global_widgets/drawer_button.dart';
import 'package:mockito_dating_app/ui/pages/home/home_controller.dart';
import 'package:mockito_dating_app/ui/pages/home/tabs/gallery_tab.dart';
import 'package:mockito_dating_app/ui/pages/home/tabs/list_dates_tab.dart';
import 'package:mockito_dating_app/ui/pages/home/tabs/profile_tab.dart';
import 'package:mockito_dating_app/ui/pages/home/tabs/selection_tab.dart';
import 'package:mockito_dating_app/ui/pages/home/widgets/home_bottom_bar.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return ChangeNotifierProvider<HomeController>(
      //? CHANGE NOTIFIER PROVIDER CONTROLLERS AND FUNCTIONS
      create: (_) {
        final homeCtrl = HomeController();
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            homeCtrl.afterFirstLayout();
          },
        );
        Get.i.put<HomeController>(homeCtrl);
        homeCtrl.onDispose = () => Get.i.remove<HomeController>();
        return homeCtrl;
      },
      builder: (_, __) {
        final controller = Provider.of<HomeController>(_, listen: false);
        return Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: const HomeBottomBar(),
          //? APPBAR
          appBar: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            backgroundColor: invColor,
            // actions: [
            //   Switch(
            //     value: MyAppTheme.instance.theme,
            //     onChanged: (bool change) {
            //       MyAppTheme.instance.change(change);
            //       setState(() {});
            //     },
            //   ),
            // ],
          ),

          //? DRAWER
          drawer: Drawer(
            elevation: 0,
            width: wp * 0.44,
            semanticLabel: 'Drawer',
            backgroundColor: tertColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? MENU LATERAL BUTTONS
                  DrawerButton(
                    wp: wp,
                    hp: hp * 0.05,
                    icon: Icons.verified,
                    label: 'verified',
                  ),
                  DrawerButton(
                    wp: wp,
                    hp: hp * 0.05,
                    icon: Icons.settings,
                    label: 'settings',
                  ),
                  DrawerButton(
                    wp: wp,
                    hp: hp * 0.05,
                    icon: Icons.favorite,
                    label: 'favorite',
                  ),
                  DrawerButton(
                    wp: wp,
                    hp: hp * 0.05,
                    icon: Icons.email,
                    label: 'email',
                  ),
                ],
              ),
            ),
          ),
          //? BODY
          body: SizedBox(
            width: wp,
            height: hp,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                //? BG TOP CURVE
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: hp * 0.22,
                    child: CustomPaint(
                      size: Size(
                        wp,
                        (wp * 0.8).toDouble(),
                      ),
                      painter: RPSCustomPainter1(),
                    ),
                  ),
                ),
                //? CENTER CIRCLE BG
                SafeArea(
                  child: Align(
                    alignment: Alignment.center,
                    child: Circle(
                      size: hp * 0.4,
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      colors: [
                        obscColor2.withOpacity(0.6),
                        darkColor1.withOpacity(0.7),
                        primColor.withOpacity(0.8),
                        secoColor,
                        tertColor,
                      ],
                    ),
                  ),
                ),
                //? BODY TABS
                Align(
                  alignment: Alignment.center,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: const [
                      SeleccionTab(),
                      ListDatesTab(),
                      GalleryTab(),
                      ProfileTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RPSCustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = darkColor1
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, -size.height);
    path0.lineTo(0, size.height * 0.3);
    path0.quadraticBezierTo(
      size.width * 0.50,
      size.height,
      size.width,
      size.height * 0.3,
    );
    path0.lineTo(size.width, -size.height);
    path0.close();
    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
