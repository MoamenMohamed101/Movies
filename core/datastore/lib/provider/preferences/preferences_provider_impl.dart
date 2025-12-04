import 'package:datastore/provider/preferences/pref_string.dart';
import 'package:datastore/provider/preferences/preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProviderImpl implements PreferencesProvider {
  final SharedPreferences _preferences;

  PreferencesProviderImpl(this._preferences);
  @override
  String getAppBaseUrl() {
    return _preferences.getString(PreferenceString.baseUrlKey) ??
        PreferenceString.baseUrlDefault;
  }

  @override
  String getAppLanguage() {
    return _preferences.getString(PreferenceString.appLanguage) ??
        PreferenceString.appLanguageDefault;
  }

  @override
  void setAppBaseUrl(String baseUrl) {
    _preferences.setString(PreferenceString.baseUrlKey, baseUrl);
  }

  @override
  void setAppLanguage(String language) {
    _preferences.setString(PreferenceString.appLanguage, language);
  }
}
