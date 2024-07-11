class AppConstants{
  ///=======================Prefs Helper data===============================>
  static const String role = "role";
  static const String mockRole = "mockRole";
  static const String token = "token";
 static const String userId = "userId";
 static const String isLogged = "isLogged";
 static const String bearerToken = "bearerToken";
 static String roleMock = '';

  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

 static bool validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
    return regex.hasMatch(value);
  }
}
