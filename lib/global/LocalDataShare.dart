import 'package:shared_preferences/shared_preferences.dart';

class LocalDataShare {
  static Future<void> saveUserID(String userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("userid", userID);
  }

  static Future<String?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("userid");
  }

  static Future<void> saveEmail(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("email", userEmail);
  }

  static Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("email");
  }

  static Future<void> savePassword(String userPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("pwd", userPassword);
  }

  static Future<String?> getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("pwd");
  }

  static Future<void> removeUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("userid");
  }

  static Future<void> removePassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("pwd");
  }

  removeEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("email");
  }
}
