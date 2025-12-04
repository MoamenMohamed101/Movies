// what is the used of this class?
// This class is used to provide access to session-related data,
// such as the client ID, user ID, access token, and refresh token.

/*
SessionProvider → handles USER SESSION data

This provider stores values related to the user currently logged in, such as:

✔ Access Token
✔ Refresh Token
✔ User ID
✔ Client ID (unique device/app identifier)

🔥 Meaning:

SessionProvider = everything related to the current logged-in user.
 */
abstract class SessionProvider {
  String getClientId();
  String getUserId();
  String getAccessToken();
  String getRefreshToken();

  void setUserId(String userId);
  void setAccessToken(String accessToken);
  void setRefreshToken(String refreshToken);
}
