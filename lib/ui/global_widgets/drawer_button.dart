import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
    required this.wp,
    required this.hp,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final double wp, hp;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            icon,
            color: gColor3,
            size: wp * 0.05,
          ),
          SizedBox(width: wp * 0.1),
          Text(
            label,
            style: TextStyle(
              color: gColor3,
              fontSize: wp * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
