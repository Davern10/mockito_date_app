// import 'package:sembast/sembast.dart';
import 'package:flutter/material.dart';
// import 'package:mockito_dating_app/models/db.dart';

class MyAppTheme extends ChangeNotifier {
  static final MyAppTheme _instance = MyAppTheme._();
  static MyAppTheme get instance => _instance;

  MyAppTheme._();

  // final StoreRef _store = StoreRef.main();
  // final Database _db = DB.instance.database;

  final bool _theme = false;
  bool get theme => _theme;

  // bool _darkEnabled = false;
  // bool get darkEnabled => _darkEnabled;

  // Future<void> init() async {
  //   this._darkEnabled =
  //       (await this._store.record('DARK_ENABLED').get(this._db)) ?? false;
  // }

  // change(bool themeChange) async {
  //   _darkEnabled = themeChange;
  //   _theme = themeChange;
  //   final dataSaved = await this
  //       ._store
  //       .record('DARK_ENABLED')
  //       .put(this._db, this._darkEnabled);
  //   debugPrint("theme darkEnabled: $dataSaved");
  //   notifyListeners();
  // }
}
