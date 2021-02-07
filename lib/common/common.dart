import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  static Future<bool> setAllData(List<dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('allData', json.encode(data));
  }

  static Future<List<dynamic>> getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String info = prefs.getString('allData');
    try {
      return json.decode(info) as List<dynamic>;
    } catch (err) {
      return Future(() => null);
    }
  }
}
