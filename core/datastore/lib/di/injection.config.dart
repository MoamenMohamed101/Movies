// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:datastore/di/data_store_%20module.dart' as _i572;
import 'package:datastore/provider/preferences/preferences_provider.dart'
    as _i940;
import 'package:datastore/provider/session/session_provider.dart' as _i1014;
import 'package:datastore/provider/session/session_provider_imp.dart' as _i626;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dataStroreModule = _$DataStroreModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => dataStroreModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i940.PreferencesProvider>(
      () => dataStroreModule.providePreferencesProvider(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i1014.SessionProvider>(
      () => _i626.DevSessionProviderImp(gh<_i460.SharedPreferences>()),
      registerFor: {_dev},
    );
    gh.factory<_i1014.SessionProvider>(
      () => _i626.ProdSessionProviderImp(gh<_i460.SharedPreferences>()),
      registerFor: {_prod},
    );
    return this;
  }
}

class _$DataStroreModule extends _i572.DataStroreModule {}
