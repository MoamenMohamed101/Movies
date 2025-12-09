import 'package:data/di/data_module_keys.dart';
import 'package:data/factory/dio_factory.dart';
import 'package:datastore/provider/preferences/preferences_provider.dart';
import 'package:datastore/provider/session/session_provider.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// The main purpose of this module is to hide the implementation details of
// data-related dependencies from the rest of the application.

// What are data-related dependencies?
// → Components responsible for handling data operations such as:
//   - Making HTTP requests (Dio)
//   - Managing access tokens
//   - Storing and retrieving preferences (language, base URL)
//   - Any source that provides data from APIs or local storage

/*
Why does this module exist?
- To provide dependencies related to data operations (base URL, token, language, Dio)
- To keep data configuration isolated and injectable using Injectable
- To allow other layers to depend only on abstractions, not implementations

What does "providing dependencies" mean?
- It means: making objects available to the DI container so other classes can request them.

What is @module?
- Tells Injectable that this class contains functions that provide dependencies.

What is @Named?
- A tag to differentiate between dependencies of the same type (e.g., multiple Strings).

What is @lazySingleton?
- The dependency will be created only ONCE and only WHEN first requested.
*/
@module
abstract class DataModule {
  // what is this method for? // This method provides the base URL for the application by retrieving it from the PreferencesProvider.
  // what is means by retrieving it from the PreferencesProvider? // It means that the method calls the getAppBaseUrl() function of the PreferencesProvider to obtain the base URL value that has been stored in the application's preferences.
  @Named(DataModuleKeys.baseUrl)
  String provideBaseUrl(PreferencesProvider provider) =>
      provider.getAppBaseUrl();

  // what is this method for? // This method provides the access token for the application by retrieving it from the SessionProvider.
  @Named(DataModuleKeys.accessToken)
  String provideAccessToken(SessionProvider provider) =>
      provider.getAccessToken();

  // what is this method for? // This method provides the language setting for the application by retrieving it from the PreferencesProvider.
  @Named(DataModuleKeys.language)
  String provideLanguage(PreferencesProvider provider) =>
      provider.getAppLanguage();

  // what is this method for? // This method provides a Dio instance configured with the base URL, access token, and language settings.
  @lazySingleton
  Dio dio(
    @Named(DataModuleKeys.baseUrl) String baseUrl,
    @Named(DataModuleKeys.accessToken) String accessToken,
    @Named(DataModuleKeys.language) String language,
  ) {
    final dioFactory = DioFactory(
      baseUrl: baseUrl,
      accessToken: accessToken,
      language: language,
    );
    return dioFactory.getDio();
  }
}
