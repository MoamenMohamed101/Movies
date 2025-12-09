import 'package:app_settings/di/injection.dart';
import 'package:data/di/injection.dart';
import 'package:datastore/di/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/di/injection.config.dart';
import 'package:login/data/di/injection.dart';
// what is the purpose of this file? // The purpose of this file is to configure and initialize the dependency injection for the entire application by combining dependencies from different modules such as app settings, data store, and core data.

// what is mean by "combining dependencies from different modules"? // It means that this file imports and initializes the dependency injection configurations from various modules (app settings, data store, core data) so that all their dependencies can be managed and accessed through a single GetIt instance.
final getIt = GetIt.instance;

@InjectableInit()
/// Configures and initializes the dependency injection for the entire application
/// by combining dependencies from different modules such as app settings, data store,
/// and core data.
///
/// This function is responsible for initializing the GetIt instance, which is used
/// to manage and access the dependencies of all modules.
///
/// The [environment] parameter is optional and is used to specify the environment
/// in which the application is running. This can be useful for configuring different
/// dependencies based on the environment.
///
/// This function must be called before accessing any dependencies.
///
/// Example:
///
Future<void> configureDependencies(String? environment) async {
  await configureAppSettingsDependencies(getIt, environment);
  await configureDataStoreDependencies(getIt, environment);
  await configureCoreDataDependencies(getIt, environment);
  await configureLoginFeatureDependencies(getIt, environment);
  getIt.init(environment: environment);
}
