import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';

class OnErrorCharge extends StatelessWidget {
  const OnErrorCharge({
    Key? key,
    required this.hp,
    required this.wp,
    required this.snapshot,
  }) : super(key: key);

  final double hp, wp;
  final Object? snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: invColor,
      height: hp,
      width: wp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot}'),
          ),
        ],
      ),
    );
  }
}
