import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<String> fetchStoredValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }

  Future<void> storeValue(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', value);
  }
}
