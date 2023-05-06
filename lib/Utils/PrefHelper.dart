

import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper{
  static Future setFavorites(List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList( "favorites", value);
  }
}