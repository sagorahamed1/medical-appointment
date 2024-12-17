import 'package:doctor_appointment/views/screens/message/message/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../helpers/network_connection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../profile/profile/profile_screen.dart';
import '../doctor_appointments/doctor_appointments_screen.dart';
import '../doctor_home/doctor_home_screen.dart';


class DoctorBottomNavBar extends StatefulWidget {
  const DoctorBottomNavBar({super.key});

  @override
  State<DoctorBottomNavBar> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<DoctorBottomNavBar> {
  int _selectedIndex = 0;
  final NetworkController networkController = Get.put(NetworkController());

  static final List _widgetOptions = [
    DoctorHomeScreen(),
    DoctorAppointmentsScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),

          Obx(() {
            return networkController.isConnection.value
                ? const SizedBox.shrink()
                : Padding(
              padding:  EdgeInsets.all(8.r),
              child: Container(
                color: AppColors.primaryColor,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "🚫  No Internet Connection",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          ///---------------home---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
            _selectedIndex==0? AppIcons.homeicon:AppIcons.home_outline,
              color: _selectedIndex== 0 ? Colors.white : Colors.white60,
            ),
            label: 'Home',
          ),

          ///---------------Appointments---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
            _selectedIndex==1?AppIcons.appointments:  AppIcons.appointments_outline,
              color: _selectedIndex== 1 ? Colors.white : Colors.white60,
            ),
            label: 'Appointments',
          ),

          ///---------------Message---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
           _selectedIndex==2?AppIcons.message: AppIcons.message_outline,
              color: _selectedIndex== 2 ? Colors.white : Colors.white60,
            ),
            label: 'Message',
          ),

          ///---------------Profile---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
           _selectedIndex==3?AppIcons.profile:AppIcons.profile_outline,
              color: _selectedIndex== 3 ? Colors.white : Colors.white60,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        iconSize: 20.h,
        backgroundColor: AppColors.primaryColor,
        selectedFontSize: 14.h,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
      ),
    );
  }
}
