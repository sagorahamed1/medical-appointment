class ApiConstants{
  static const String baseUrl = "http://192.168.10.46:3000/api/v1";
  static const String imageBaseUrl = "http://192.168.10.46:3000";



  static const String signUpEndPoint = "/user/sign-up";
  static const String verifyOtpEndPoint = "/user/verify-code";
  static const String fillUpProfileEndPoint = "/user/fill-Up-update";
  static const String signInEndPoint = "/user/sign-in";
  static const String forgotPasswordPoint = "/user/forgot-password";
  static const String setPasswordPoint = "/user/set-password";
  static const String reSendOtpPoint = "/user/resendOpt";
  static const String continueDoctorPoint = "/doctor/create-details";
  static const String getProfileEndPoint = "/user/login-user";
  static const String profileUpdate = "/user/update-profile";
  static const String patientDetailsAdd = "/user/patient-details-for-doctor";

  static  String getDoctor(String cetegory) => "/doctor/get-doctors?specialist=$cetegory";
  static  String getAppointments(String status) => "/appointments/user-get-appointments?status=$status";
  static  String doctorDetailsHomeScreen(String id) => "/doctor/get-single-doctor?id=$id";
  static const String category = "/category/get-category";



  ///=================Doctor Part============>
  static String doctorAppointmentHomeScreenApiEndPoint(String status) => '/appointments/doctor-get-appointments?status=$status';
  static const String doctorDetailsDoctorPart = "/doctor/doctor-details";
  static const String doctorEditDetailsDoctorPart = "/doctor/edit-details";



  static const String userPayment = "/payment/create-payment";


}