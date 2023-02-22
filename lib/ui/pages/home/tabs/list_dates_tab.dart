import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/global_widgets/list_firebase_view.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';

class ListDatesTab extends StatefulWidget {
  const ListDatesTab({Key? key}) : super(key: key);

  @override
  State<ListDatesTab> createState() => _ListDatesTabState();
}

class _ListDatesTabState extends State<ListDatesTab> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Center(
      child: Container(
        color: invColor,
        height: hp,
        width: wp,
        child: const DateListFBPage(),
      ),
    );
  }
}
