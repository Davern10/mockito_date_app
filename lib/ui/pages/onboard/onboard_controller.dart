import 'package:flutter/widgets.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/models/onboard_item.dart';
import 'package:mockito_dating_app/data/repositories/preferences_repository.dart';

class OnboardController with ChangeNotifier {
  final PageController pageController = PageController();
  final List<OnboardItem> items = [
    //? SLIDERS CONTENT
    OnboardItem(
        image: "assets/svg/select_employed.svg",
        title: "Select an Employed",
        description:
            "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"),
    OnboardItem(
        image: "assets/svg/date.svg",
        title: "Schedule Date",
        description:
            "non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
    OnboardItem(
        image: "assets/svg/portfolio_feedback.svg",
        title: "Add Notes or Images",
        description:
            "Ut placerat orci nulla pellentesque. Aliquet nec ullamcorper sit amet risus")
  ];

//? AFTER FIRST ONBOARD CHARGE
  void afterFirstlayout() {
    pageController.addListener(
      () {
        final double page = pageController.page!;
        _currentPage = page;
        notifyListeners();
      },
    );
  }

  //? IS ONBOARD READY
  Future<void> setReady() {
    return Get.i.find<PrefsRepository>().setOnboardAndWelcomeReady(true);
  }

  //? ON NEXT PAGE SLIDER
  void onNext(BuildContext context, OnboardController controller) {
    if (controller.currentPage == 2) {
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      controller.pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
    notifyListeners();
  }

  double _currentPage = 0;
  double get currentPage => _currentPage;

  //? DISPOSE
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
