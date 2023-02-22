import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({
    Key? key,
    required this.hp,
    required this.wp,
  }) : super(key: key);

  final double hp;
  final double wp;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          color: invColor,
          height: hp,
          width: wp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: wp * 0.08),
                child: const Text('Esperando Resultados...'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
