

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/screens/Auth/ContinueDoctorDetails/continue_doctor_details_screen.dart';
import '../views/screens/Auth/fill_profile/fill_profile_screen.dart';
import '../views/screens/Auth/forgot_password/forgot_password_screen.dart';
import '../views/screens/Auth/set_password/set_password_screen.dart';
import '../views/screens/Auth/sign_in/sign_in_screen.dart';
import '../views/screens/Auth/sign_up/sign_up_screen.dart';
import '../views/screens/Auth/veryfy_email/veryfy_email_screen.dart';
import '../views/screens/Doctor/doctor_appointment_details/doctor_appointment_details_screen.dart';
import '../views/screens/Doctor/doctor_appointment_request/doctor_appointment_request_screen.dart';
import '../views/screens/Doctor/doctor_bottom_nav_bar/doctor_bottom_nav_bar.dart';
import '../views/screens/Doctor/doctor_details/doctor_details_screen.dart';
import '../views/screens/Doctor/doctor_edit_details_prfile/doctor_edit_details_profile_screen.dart';
import '../views/screens/Doctor/prescription_from/prescription_from_screen.dart';
import '../views/screens/Doctor/review/review_screen.dart';
import '../views/screens/Doctor/see_all_appointments/see_all_appintment_screen.dart';
import '../views/screens/Doctor/wallet/wallet_screen.dart';
import '../views/screens/Doctor/wallet/wallet_withraw_screen.dart';
import '../views/screens/User/User_Appointments_Details/user_appointments_details_screen.dart';
import '../views/screens/User/User_Available_Doctors/user_availablle_doctors_screen.dart';
import '../views/screens/User/User_Book_Schedule/user_book_schedule_screen.dart';
import '../views/screens/User/User_Emergency_Doctors/user_emergency_doctors_screen.dart';
import '../views/screens/User/User_Give_Review/user_give_review_screen.dart';
import '../views/screens/User/User_Patient_Details/user_patient_details.dart';
import '../views/screens/User/User_Records/add_records_screen.dart';
import '../views/screens/User/User_Records/patient_details_for_record_screen.dart';
import '../views/screens/User/User_Records/user_records_screen.dart';
import '../views/screens/User/User_doctor_details/user_doctor_details_screen.dart';
import '../views/screens/User/User_home/user_home_screen.dart';
import '../views/screens/User/user_bottom_nav_bar/user_bottom_nav_bar.dart';
import '../views/screens/User/user_category/user_category_screen.dart';
import '../views/screens/User/user_search/user_search_screen.dart';
import '../views/screens/User/user_select_package/user_select_package_screen.dart';
import '../views/screens/message/audio_call/audio_call_screen.dart';
import '../views/screens/message/chat_screen/chat_screen.dart';
import '../views/screens/message/video_call/video_call_screen.dart';
import '../views/screens/notifications/notifications_screen.dart';
import '../views/screens/onboarding/onboarding_screen.dart';
import '../views/screens/profile/edit_profile/edit_profile_screen.dart';
import '../views/screens/profile/personal_information/personal_information_screen.dart';
import '../views/screens/role/role_screen.dart';
import '../views/screens/setting/All_Privacy_Policy/all_privacy_policy_screen.dart';
import '../views/screens/setting/change_password/change_password_screen.dart';
import '../views/screens/setting/setting/setting_screen.dart';
import '../views/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen.dart";
  static const String onboardingScreen = "/OnboardingScreen.dart";
  static const String roleScreen = "/RoleScreen.dart";
  static const String signUpScreen = "/SignUpScreen.dart";
  static const String veryfyEmailScreen = "/VeryfyEmailScreen.dart";
  static const String fillProfileScreen = "/FillProfileScreen.dart";
  static const String signInScreen = "/SignInScreen.dart";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen.dart";
  static const String setPasswordScreen = "/SetPasswordScreen.dart";
  static const String userHomeScreen = "/UserHomeScreen.dart";
  static const String userBottomNavBar = "/UserBottomNavBar.dart";
  static const String notificationScreen = "/NotificationScreen.dart";
  static const String userSearchScreen = "/UserSearchScreen.dart";
  static const String useravailablleDoctorsScreen = "/AvailablleDoctorsScreen.dart";
  static const String useremergencyDoctorsScreen = "/EmergencyDoctorsScreen.dart";
  static const String userCategoryScreen = "/UserCategoryScreen.dart";
  static const String userDoctorDetailsScreen = "/DoctorDetailsScreen.dart";
  static const String userSelectPackageScreen = "/SelectPackageScreen.dart";
  static const String userBookScheduleScreen = "/UserBookScheduleScreen.dart";
  static const String userPatientDetailsScreen = "/UserPatientDetailsScreen.dart";
  static const String userAppointmentsDetailsScreen = "/UserAppointmentsDetailsScreen.dart";
  static const String userGiveReviewScreen = "/UserGiveReviewScreen.dart";
  static const String chatScreen = "/ChatScreen.dart";
  static const String audioCallScreen = "/AudioCallScreen.dart";
  static const String videoCallScreen = "/VideoCallScreen.dart";
  static const String personalInformationScreen = "/PersonalInformationScreen.dart";
  static const String editProfileScreen = "/EditProfileScreen.dart";
  static const String settingScreen = "/SettingScreen.dart";
  static const String changePasswordScreen = "/ChangePasswordScreen.dart";
  static const String allPrivacyPolicyScreen = "/AllPrivacyPolicyScreen.dart";
  static const String doctorBottomNavBar = "/DoctorBottomNavBar.dart";
  static const String dcotorAppointmentsDetailsScreen = "/DcotorAppointmentsDetailsScreen.dart";
  static const String doctorDetailsProfileScreen = "/DoctorDetailsProfileScreen.dart";
  static const String doctorEditDetailsProfileScreen = "/DoctorEditDetailsProfileScreen.dart";
  static const String walletScreen = "/WalletScreen.dart";
  static const String walletWithdrawalScreen = "/WalletWithdrawalScreen.dart";
  static const String reviewScreen = "/ReviewScreen.dart";
  static const String continueDoctorDetailsScreen = "/ContinueDoctorDetailsScreen.dart";
  static const String doctorAppointmentRequestScreen = "/DoctorAppointmentRequestScreen.dart";
  static const String userRecordsScreen = "/UserRecordsScreen.dart";
  static const String patientDetailsForRecordScreen = "/PatientDetailsForRecordScreen.dart";
  static const String addRecordsScreen = "/AddRecordsScreen.dart";
  static const String prescriptionFormScreen = "/PrescriptionFormScreen.dart";
  static const String seeAllAppintmentScreen = "/SeeAllAppintmentScreen.dart";


  static List<GetPage> get routes => [
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
        GetPage(name: roleScreen, page: () => RoleScreen()),
        GetPage(name: signUpScreen, page: () => SignUpScreen()),
        GetPage(name: veryfyEmailScreen, page: () => VeryfyEmailScreen()),
        GetPage(name: fillProfileScreen, page: () => FillProfileScreen()),
        GetPage(name: signInScreen, page: () => SignInScreen()),
        GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
        GetPage(name: setPasswordScreen, page: () => SetPasswordScreen()),
        GetPage(name: userHomeScreen, page: () => UserHomeScreen()),
        GetPage(name: userBottomNavBar, page: () => UserBottomNavBar()),
        GetPage(name: notificationScreen, page: () => NotificationScreen()),
        GetPage(name: userSearchScreen, page: () => UserSearchScreen()),
        GetPage(name: useravailablleDoctorsScreen, page: () => UserAvailablleDoctorsScreen()),
        GetPage(name: useremergencyDoctorsScreen, page: () => UserEmergencyDoctorsScreen()),
        GetPage(name: userCategoryScreen, page: () => UserCategoryScreen()),
        GetPage(name: userDoctorDetailsScreen, page: () => UserDoctorDetailsScreen()),
        GetPage(name: userSelectPackageScreen, page: () => UserSelectPackageScreen()),
        GetPage(name: userBookScheduleScreen, page: () => UserBookScheduleScreen()),
        GetPage(name: userPatientDetailsScreen, page: () => UserPatientDetailsScreen()),
        GetPage(name: userAppointmentsDetailsScreen, page: () => UserAppointmentsDetailsScreen()),
        GetPage(name: userGiveReviewScreen, page: () => UserGiveReviewScreen()),
        GetPage(name: chatScreen, page: () => ChatScreen()),
        GetPage(name: audioCallScreen, page: () => AudioCallScreen()),
        GetPage(name: videoCallScreen, page: () => VideoCallScreen()),
        GetPage(name: personalInformationScreen, page: () => PersonalInformationScreen()),
        GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
        GetPage(name: settingScreen, page: () => SettingScreen()),
        GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
        GetPage(name: allPrivacyPolicyScreen, page: () => AllPrivacyPolicyScreen()),
        GetPage(name: doctorBottomNavBar, page: () => DoctorBottomNavBar()),
        GetPage(name: dcotorAppointmentsDetailsScreen, page: () => DcotorAppointmentsDetailsScreen()),
        GetPage(name: doctorDetailsProfileScreen, page: () => DoctorDetailsProfileScreen()),
        GetPage(name: doctorEditDetailsProfileScreen, page: () => DoctorEditDetailsProfileScreen()),
        GetPage(name: walletScreen, page: () => WalletScreen()),
        GetPage(name: walletWithdrawalScreen, page: () => WalletWithdrawalScreen()),
        GetPage(name: reviewScreen, page: () => ReviewScreen()),
        GetPage(name: continueDoctorDetailsScreen, page: () => ContinueDoctorDetailsScreen()),
        GetPage(name: doctorAppointmentRequestScreen, page: () => DoctorAppointmentRequestScreen()),
        GetPage(name: userRecordsScreen, page: () => UserRecordsScreen()),
        GetPage(name: patientDetailsForRecordScreen, page: () => PatientDetailsForRecordScreen()),
        GetPage(name: addRecordsScreen, page: () => AddRecordsScreen()),
        GetPage(name: prescriptionFormScreen, page: () => PrescriptionFormScreen()),
        GetPage(name: seeAllAppintmentScreen, page: () => SeeAllAppintmentScreen()),
  ];
}
