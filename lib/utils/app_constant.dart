class AppConstants{
  ///=======================Prefs Helper data===============================>
  static const String role = "role";
  static const String mockRole = "mockRole";
  // static const String token = "token";
  static const String userId = "userId";
 static const String isLogged = "isLogged";
 static const String pas = "pas";
 static const String bearerToken = "bearerToken";
 static const String email = "email";
 static const String userName = "userName";
 static const String firstName = "firstName";
 static const String lastName = "lastName";
 static const String payerCode = "payerCode";
 static const String payerName = "payerName";
 static const String npi = "npi";
 static const String pin = "pin";
 static const String dateOfBirth = "dateOfBirth";
 static const String startDate = "startDate";
 static const String endDate = "endDate";
 static const String image = "image";
 static const String insurance = "insurance";
 static const String isPrescription = "isPrescription";
 static String roleMock = '';
 static String isEmargency = 'isEmargency';

  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

 static bool validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
    return regex.hasMatch(value);
  }
}

enum Status { loading, completed, error, internetError }
// ximaji7141@0tires.com