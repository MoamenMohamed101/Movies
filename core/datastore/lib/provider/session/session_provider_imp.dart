import 'package:datastore/provider/session/session_provider.dart';
import 'package:datastore/provider/session/session_string.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// what is the difference between user id and client id?
// The difference between user id and client id is that user id is a unique identifier for a specific user,
// while client id is a unique identifier for a specific device or application.

// Where each one comes from?
// The user id comes from the server, while the client id comes from the device or application.

// When each one changes?
// The user id changes when the user logs in with a different account,
// while the client id changes when the application is reinstalled or the device is reset.
@Injectable(as: SessionProvider, env: [Environment.prod])
class ProdSessionProviderImp extends SessionProvider {
  final SharedPreferences _sharedPreferences;
  ProdSessionProviderImp(this._sharedPreferences);

  @override
  String getAccessToken() {
    return _sharedPreferences.getString(SessionString.accessTokenKey) ?? '';
  }

  @override
  String getClientId() {
    return Uuid().v4();
  }

  @override
  String getRefreshToken() {
    return _sharedPreferences.getString(SessionString.refreshTokenKey) ?? '';
  }

  @override
  String getUserId() {
    return _sharedPreferences.getString(SessionString.userIdKey) ?? '';
  }

  @override
  void setAccessToken(String accessToken) {
    _sharedPreferences.setString(SessionString.accessTokenKey, accessToken);
  }

  @override
  void setRefreshToken(String refreshToken) {
    _sharedPreferences.setString(SessionString.refreshTokenKey, refreshToken);
  }

  @override
  void setUserId(String userId) {
    _sharedPreferences.setString(SessionString.userIdKey, userId);
  }
}

@Injectable(as: SessionProvider, env: [Environment.dev])
class DevSessionProviderImp extends SessionProvider {
  final SharedPreferences _sharedPreferences;
  DevSessionProviderImp(this._sharedPreferences);

  @override
  String getAccessToken() {
    return _sharedPreferences.getString(SessionString.accessTokenKey) ?? '';
  }

  @override
  String getClientId() {
    return "22222222";
  }

  @override
  String getRefreshToken() {
    return _sharedPreferences.getString(SessionString.refreshTokenKey) ?? '';
  }

  @override
  String getUserId() {
    return _sharedPreferences.getString(SessionString.userIdKey) ?? '';
  }

  @override
  void setAccessToken(String accessToken) {
    _sharedPreferences.setString(SessionString.accessTokenKey, accessToken);
  }

  @override
  void setRefreshToken(String refreshToken) {
    _sharedPreferences.setString(SessionString.refreshTokenKey, refreshToken);
  }

  @override
  void setUserId(String userId) {
    _sharedPreferences.setString(SessionString.userIdKey, userId);
  }
}
