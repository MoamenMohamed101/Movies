import 'package:datastore/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Configures and initializes the dependency injection for the data store module.
@InjectableInit()
Future<void> configureDataStoreDependencies(GetIt getIt, String? environment) =>
    getIt.init(environment: environment);
