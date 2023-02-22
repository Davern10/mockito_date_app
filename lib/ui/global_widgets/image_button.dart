import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';

class ButtonImage extends StatelessWidget {
  const ButtonImage({
    Key? key,
    required this.wp,
    required this.hp,
    required this.text,
    required this.image,
  }) : super(key: key);

  final double wp, hp;
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: darkColor1,
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: primColor.withOpacity(0.4),
        onTap: () {
          // TODO ROUTER WITH ARGMTS SEE USE ON DATEPAGE
          Navigator.pushNamed(context, Routes.personalPage,
              arguments: {"url": image});
        },
        child: Container(
          decoration: BoxDecoration(
            color: invColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: wp * 0.02,
              color: darkColor1,
            ),
          ),
          child: Column(
            children: [
              Ink.image(
                image: AssetImage(image),
                fit: BoxFit.cover,
                width: wp * 0.4,
                height: hp * 0.3,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
