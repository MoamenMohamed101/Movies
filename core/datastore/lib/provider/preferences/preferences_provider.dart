// what is the used of this class?
// This class is used to provide access to preferences-related data,
// such as the application language and base URL.

/*
PreferencesProvider → handles APP CONFIGURATION data

This provider stores general app settings, such as:

✔ App base URL
✔ App language
✔ Theme
✔ Intro/onboarding flags
…etc.

🔥 Meaning:

PreferencesProvider = everything related to the app settings, NOT the user.
 */
abstract class PreferencesProvider {
  String getAppLanguage();
  String getAppBaseUrl();
  void setAppLanguage(String language);
  void setAppBaseUrl(String baseUrl);
}
