import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static final PrefsHelper _instance = PrefsHelper._privateConstructor();

  PrefsHelper._privateConstructor();

  // 0 false;
  // 1 true;

  factory PrefsHelper() {
    return _instance;
  }

  void saveRuntimevalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('firstTimeUsage', 0);
  }

  Future<int> getFirstTimeRunValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('firstTimeUsage') ?? 1;
  }
}
