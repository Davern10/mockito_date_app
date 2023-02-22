import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/ui/global_widgets/rounded_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Scaffold(
      body: Container(
        color: invColor,
        width: wp,
        height: hp,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            //? BACKGROUND IMAGE TOP / TITLE
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: hp * 0.4,
                child: Stack(
                  children: [
                    //? BG TOP
                    Positioned(
                      bottom: -28,
                      child: CustomPaint(
                        size: Size(
                          wp,
                          (wp * 0.8).toDouble(),
                        ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomPainter1(),
                      ),
                    ),
                    //? IMAGE TOP
                    ClipPath(
                      clipper: TopClipperImage(),
                      child: SizedBox(
                        width: wp,
                        height: 260,
                        child: Image.asset(
                          'assets/images/nails_pink_candle.png',
                          fit: BoxFit.fitHeight,
                        ),
                        // Image.network(
                        //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6Aa4XcjQgH_cZ7yc0NN7gklI5tj3Yd6Sn9TihjdwC22T9XvHrK2Kaugwa_fpINKvyxVw&usqp=CAU",
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    // TODO BORDE SOBRE TEXTO NO CONTENEDOR
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: hp * 0.1),
                        child: Stack(
                          children: [
                            //? STROKE BORDER TEXT
                            Text(
                              '¡Welcome!',
                              style: MyFontStyles.titles.copyWith(
                                fontSize: hp * 0.13,
                                letterSpacing: 6,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = wp * 0.015
                                  ..color = tertColor,
                              ),
                            ),
                            //? TEXT TITLE
                            Text(
                              '¡Welcome!',
                              style: MyFontStyles.titles.copyWith(
                                fontSize: hp * 0.13,
                                letterSpacing: 6,
                                fontWeight: FontWeight.bold,
                                color: darkColor1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //? BACKGROUND IMAGE BOTTOM / BUTTON START
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: hp * 0.4,
                child: Stack(
                  children: [
                    //? BG BOTTOM
                    Positioned(
                      top: -38,
                      child: CustomPaint(
                        size: Size(
                          wp,
                          (wp * 0.8).toDouble(),
                        ),
                        painter: RPSCustomPainter2(),
                      ),
                    ),
                    //? IMAGE BOTTOM
                    ClipPath(
                      clipper: BottonClipperImage(),
                      child: SizedBox(
                        width: wp,
                        height: hp,
                        child: Image.asset(
                          'assets/images/eyelash_rose.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomRight,
                        ),
                        // Image.network(
                        //   "https://previews.123rf.com/images/dimid86/dimid861801/dimid86180100108/93840469-collage-de-varios-procedimientos-cosm%C3%A9ticos-para-una-mujer-joven-y-hermosa-en-un-sal%C3%B3n-de-belleza-co.jpg",
                        //   fit: BoxFit.cover,
                        //   alignment: Alignment.bottomRight,
                        // ),
                      ),
                    ),
                    //? BUTTON START
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: hp * 0.12),
                        child: RoundedButton(
                          borderColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: wp * 0.1,
                            vertical: hp * 0.02,
                          ),
                          flWidth: false,
                          label: 'Let`s Go',
                          fontSize: hp * 0.03,
                          fontWeight: FontWeight.bold,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.onboard);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //? WELCOME INFO
            Container(
              padding: EdgeInsets.symmetric(horizontal: wp * 0.1),
              height: hp * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Get Started, Ut placerat orci nulla pellentesque.'
                    'Aliquet nec ullamcorper sit amet risus.'
                    'Get Started, Ut placerat orci nulla pellentesque.'
                    'Aliquet nec ullamcorper sit amet risus.'
                    'Get Started, Ut placerat orci nulla pellentesque.'
                    'Aliquet nec ullamcorper sit amet risus.'
                    'Get Started, Ut placerat orci nulla pellentesque.'
                    'Aliquet nec ullamcorper sit amet risus.',
                    style: TextStyle(
                      backgroundColor: invColor,
                      fontSize: hp * 0.02,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 10,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopClipperImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Offset p0 = Offset(0, size.height * 0.82);
    final Offset p1 = Offset(size.width * 0.25, size.height * 0.62);
    final Offset p2 =
        Offset(size.width / 2 - size.width * 0.03, size.height * 0.8);
    final Offset p0_1 =
        Offset(size.width / 2 - size.width * 0.03, size.height * 0.8);
    final Offset p1_1 =
        Offset(size.width * 0.75, size.height + size.height * 0.15);
    final Offset p2_1 = Offset(size.width, size.height * 0.88);

    Path path = Path();

    path.lineTo(0, -size.height); //!AQUIIIIIIIIIII
    path.lineTo(p0.dx, p0.dy);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    path.lineTo(p0_1.dx, p0_1.dy);
    path.quadraticBezierTo(p1_1.dx, p1_1.dy, p2_1.dx, p2_1.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, -size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RPSCustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = secoColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();

    path0.lineTo(0, size.height * 0.77);
    path0.quadraticBezierTo(
      size.width * 0.22,
      size.height * 0.50,
      size.width * 0.55,
      size.height * 0.72,
    );
    path0.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.88,
      size.width,
      size.height * 0.7,
    );
    path0.lineTo(size.width, -size.height);
    path0.lineTo(0, -size.height);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BottonClipperImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Offset p0 = Offset(0, size.height * 0.3);
    final Offset p1 = Offset(size.width * 0.25, size.height * 0.15);
    final Offset p2 =
        Offset(size.width / 2 + size.width * 0.03, size.height * 0.33);
    final Offset p0_1 =
        Offset(size.width / 2 + size.width * 0.03, size.height * 0.33);
    final Offset p1_1 = Offset(size.width * 0.75, size.height * 0.55);
    final Offset p2_1 = Offset(size.width, size.height * 0.32);

    Path path = Path();

    path.moveTo(-size.height * 100, size.width);
    path.lineTo(p0.dx, p0.dy);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    path.lineTo(p0_1.dx, p0_1.dy);
    path.quadraticBezierTo(p1_1.dx, p1_1.dy, p2_1.dx, p2_1.dy);

    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..style = PaintingStyle.fill
      ..color = secoColor
      ..strokeWidth = 1;

    Path path0 = Path();

    path0.moveTo(0, size.height * 0.36);
    path0.quadraticBezierTo(
      size.width * 0.24,
      size.height * 0.2,
      size.width * 0.55,
      size.height * 0.37,
    );
    path0.quadraticBezierTo(
      size.width * 0.82,
      size.height * 0.53,
      size.width,
      size.height * 0.26,
    );
    path0.lineTo(size.width, size.height * 2);
    path0.lineTo(0, size.height * 2);
    path0.lineTo(0, size.height * 0.4);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// class TopClipperBG extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final Offset p0 = Offset(0, size.height * 0.88);
//     final Offset p1 = Offset(
//       size.width * 0.25,
//       (size.height + size.height * 0.117),
//     );
//     final Offset p2 = Offset(size.width / 2, size.height * 0.88);
//     final Offset p0_1 = Offset(size.width / 2, size.height * 0.88);
//     final Offset p1_1 = Offset(size.width * 0.75, size.height * 0.653);
//     final Offset p2_1 = Offset(size.width, size.height * 0.88);
//     Path path = Path();
//     path.lineTo(p0.dx, p0.dy);
//     path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
//     path.lineTo(p0_1.dx, p0_1.dy);
//     path.quadraticBezierTo(p1_1.dx, p1_1.dy, p2_1.dx, p2_1.dy);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);
//     return path;
//   }
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }
