import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomeController extends ChangeNotifier implements TickerProvider {
  HomeController() {
    onInit();
  }

  int _currentPage = 0;
  int get currentPage => _currentPage;

  //? BOTTOM ICON'S
  final List<BottomBarItem> _bottomBarIcons = [
    BottomBarItem(
      icon: 'assets/svg/home.svg',
      label: 'Home',
    ),
    BottomBarItem(
      icon: 'assets/svg/favorite.svg',
      label: 'Dates',
    ),
    BottomBarItem(
      icon: 'assets/svg/gallery.svg',
      label: 'Gallery',
    ),
    BottomBarItem(
      icon: 'assets/svg/avatar.svg',
      label: 'Profile',
    ),
  ];
  List<BottomBarItem> get bottomBarIcons => _bottomBarIcons;

  //? TAB CONTROLLER = TAB-C
  late TabController tabController;

  //? AFTER FIRST INIT / TAB-C
  void afterFirstLayout() async {
    // _wsRepository.connect("https://websocket.demo");
    // _notificationsSubscription =
    // notificationsController.onNotificationsChanged.listen((notifications) {
    // final int count = notifications.length;
    // List<BottomBarItem> copy = [..._menuItems];
    // copy[2] = copy[2].copyWith(
    // badgeCount: count,
    // );
    // _menuItems = copy;
    // notifyListeners();
    // });
    tabController.addListener(
      () {
        _currentPage = tabController.index;
        notifyListeners();
      },
    );
  }

  //? INIT STATE / TAB-C
  void onInit() {
    tabController = TabController(
      vsync: this,
      length: 4,
    );
  }

  // await _wsRepository.disconnect();
  //   disposed = true;
  //   super.dispose();
  //   notifyListeners();
  // }

  void Function()? onDispose;

  //? DISPOSED FOR TESTING
  @visibleForTesting
  bool disposed = false;

  //? DISPOSE
  @override
  Future<void> dispose() async {
    // await _notificationsSubscription?.cancel();
    tabController.dispose();
    if (onDispose != null) {
      onDispose!();
    }
  }

  //? TICKER
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

class BottomBarItem {
  final String icon, label;
  final int badgeCount;

  BottomBarItem({
    required this.icon,
    required this.label,
    this.badgeCount = 0,
  });

  BottomBarItem copyWith({
    String? icon,
    String? label,
    int? badgeCount,
  }) {
    return BottomBarItem(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}
