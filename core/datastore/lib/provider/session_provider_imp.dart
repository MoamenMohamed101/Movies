import 'package:datastore/provider/session_provider.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SessionProvider, env: [Environment.prod])
class ProdSessionProviderImp extends SessionProvider {
  @override
  String getAccessToken() {
    return "Access Token from user session API";
  }

  @override
  String getClientId() {
    return "11111111";
  }

  @override
  String getRefreshToken() {
    return "refresh token from user session API";
  }

  @override
  String getUserId() {
    return "123456789";
  }
}

@Injectable(as: SessionProvider, env: [Environment.dev])
class DevSessionProviderImp extends SessionProvider {
  @override
  String getAccessToken() {
    return "Access Token from user session API";
  }

  @override
  String getClientId() {
    return "22222222";
  }

  @override
  String getRefreshToken() {
    return "refresh token from user session API";
  }

  @override
  String getUserId() {
    return "123456789";
  }
}
