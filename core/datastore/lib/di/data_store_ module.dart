import 'package:datastore/provider/preferences/preferences_provider.dart';
import 'package:datastore/provider/preferences/preferences_provider_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
what is this module for?
This module is responsible for providing dependencies related to the datastore,
specifically the PreferencesProvider and potentially the SessionProvider.
It uses the Injectable package for dependency injection and ensures that the SharedPreferences instance is pre-resolved before being used.
*/

/* what is @preResolve? // The @preResolve annotation is used to indicate that the provided dependency should be resolved before the module is used, ensuring that it is available when needed. */
// what is mean by resolved? // Resolved means that the dependency has been created and is ready for use in the application.

// what is the purpose of this module? // The purpose of this module is to encapsulate the configuration and creation of datastore-related dependencies,
// allowing other parts of the application to easily access and use these dependencies without needing to know their implementation details.

@module
abstract class DataStroreModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  PreferencesProvider providePreferencesProvider(SharedPreferences prefs) =>
      PreferencesProviderImpl(prefs);

  // todo: check me if needed
  // @lazySingleton
  // SessionProvider provideSessionProvider(SharedPreferences prefs) =>
  //     DevSessionProviderImp(prefs);
}
