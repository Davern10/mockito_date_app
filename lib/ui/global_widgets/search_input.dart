import 'package:flutter/material.dart';

class MySearch extends StatelessWidget {
  const MySearch({Key? key, required this.hp, required this.wp}) : super(key: key);

  final double hp, wp;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hp * 0.08,
      padding: EdgeInsets.symmetric(
        horizontal: wp * 0.06,
      ).copyWith(
        top: hp * 0.02,
      ),
      child: TextField(
        cursorRadius: const Radius.circular(20),
        autocorrect: true,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: wp * 0.06,
          ),
          border: const OutlineInputBorder(),
          label: Text(
            'Search',
            style: TextStyle(
              fontSize: wp * 0.05,
            ),
          ),
          contentPadding: EdgeInsets.all(wp * 0.01),
        ),
        onTap: () {},
      ),
    );
  }
}
