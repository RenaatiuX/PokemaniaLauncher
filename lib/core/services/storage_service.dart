import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _keyNickname = 'user_nickname';
  static const String _keyFullscreen = 'mc_fullscreen';
  static const String _keyMaxRam = 'java_max_ram';
  static const String _keyGameDir = 'launcher_game_dir';

  static String get nickname => _prefs.getString(_keyNickname) ?? '';
  static set nickname(String value) => _prefs.setString(_keyNickname, value);

  static bool get fullscreen => _prefs.getBool(_keyFullscreen) ?? false;
  static set fullscreen(bool value) => _prefs.setBool(_keyFullscreen, value);

  static double get maxRam => _prefs.getDouble(_keyMaxRam) ?? 4096.0;
  static set maxRam(double value) => _prefs.setDouble(_keyMaxRam, value);

  static String get gameDir => _prefs.getString(_keyGameDir) ?? '%appdata%/.pokemania';
  static set gameDir(String value) => _prefs.setString(_keyGameDir, value);

  // Metodo para borrar la sesion
  static Future<void> clearAuth() async {
    await _prefs.remove(_keyNickname);
  }
}