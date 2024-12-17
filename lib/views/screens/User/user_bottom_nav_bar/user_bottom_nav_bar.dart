import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../helpers/network_connection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../message/message/message_screen.dart';
import '../../profile/profile/profile_screen.dart';
import '../User_Appointments/user_appointments_screen.dart';
import '../User_Home/user_home_screen.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<UserBottomNavBar> {
  final NetworkController networkController = Get.put(NetworkController());
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    UserHomeScreen(),
    UserAppointmentsScreen(),
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
              padding: EdgeInsets.all(8.r),
              child: Container(
                color: AppColors.primaryColor,
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
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

      ///------------------------bottom nav bar---------------------------->
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
              _selectedIndex== 3 ? AppIcons.profile:AppIcons.profile_outline,
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
