class ApiConstants{
  static const String baseUrl = "http://192.168.10.149:3000/api/v1";
  static const String imageBaseUrl = "http://192.168.10.149:3000";



  static const String signUpEndPoint = "/user/sign-up";
  static const String verifyOtpEndPoint = "/user/verify-code";
  static const String fillUpProfileEndPoint = "/user/fill-Up-update";
  static const String signInEndPoint = "/user/sign-in";
  static const String forgotPasswordPoint = "/user/forgot-password";
  static const String setPasswordPoint = "/user/set-password";
  static const String changePasswordPoint = "/user/change-password";
  static const String reSendOtpPoint = "/user/resendOpt";
  static const String continueDoctorPoint = "/doctor/create-details";
  static const String getProfileEndPoint = "/user/login-user";
  static const String profileUpdate = "/user/update-profile";
  static const String patientDetailsAdd = "/user/patient-details-for-doctor";

  static  String getDoctor(String cetegory) => "/doctor/get-doctors?specialist=$cetegory";
  static  String getSearchDoctor(String searchText) => "/doctor/get-doctors?search=$searchText";
  static  String getAppointments(String status) => "/appointments/user-get-appointments?status=$status";
  static  String doctorDetailsHomeScreen(String id) => "/doctor/get-single-doctor?id=$id";
  static const String emergencyDoctors = "/user/get-emergency-doctor";
  static const String category = "/category/get-category";
  static const String notificationEndPoint = "/notification";
  static const String userRecordsEndPoint = "/user/get-user-prescription";
  static String seeDetailsUserPart(String id) => '/appointments/user-get-single-appointment/$id';



  ///=================Doctor Part============>
  static String doctorAppointmentHomeScreenApiEndPoint(String status) => '/appointments/doctor-get-appointments?status=$status';
  static String seeDetailsDoctorPart(String id) => '/appointments/doctor-get-single-appointment/$id';
  static const String doctorDetailsDoctorPart = "/doctor/doctor-details";
  static const String doctorStatus = "/doctor/login-doctor-status";
  static const String doctorEditDetailsDoctorPart = "/doctor/edit-details";
  static const String sendPrescriptionEndPoint = "/doctor/send-prescription";
  static const String getEarningMonthlyEndPoint = "/doctor/doctor-earnings";
  static const String getWithdrawListEndPoint = "/doctor/last-withdraw-list";
  static const String withdrawRequestEndPoint = "/doctor/withdrawal-request";
  static const String emergencyToggleEndPoint = "/doctor/emergency";
  static const String completeAppointmentEndPoint = "/doctor/complete-appointment";


  ///Chats
  static const String createChatList = "/chat/create-chat";
  static const String getUserListEndPoint = "/chat/get-chat";
  static  String getChatEndPoint(String id) => "/message/get-message/$id";
  static  String senMessageWithFileEndPoint = "/message/create-message-with-file";



  static const String userPayment = "/payment/create-payment";


}