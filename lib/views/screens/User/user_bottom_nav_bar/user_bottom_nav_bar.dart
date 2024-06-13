import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../User_Home/user_home_screen.dart';



class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<UserBottomNavBar> {
  int _selectedIndex = 0;


  static final List _widgetOptions = [
    UserHomeScreen(),
    UserHomeScreen(),
    UserHomeScreen(),
    UserHomeScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _widgetOptions.elementAt(_selectedIndex),

      ///------------------------bottom nav bar----------------------------?>
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          ///---------------home---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AppIcons.homeicon,
                color: Colors.white
            ),
            label: 'Home',
          ),

          ///---------------Appointments---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AppIcons.appointments,
                color: Colors.white
            ),
            label: 'Appointments',
          ),

          ///---------------Message---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AppIcons.messageIcon,
                color: Colors.white
            ),
            label: 'Message',
          ),

          ///---------------Profile---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AppIcons.profileIcon,
                color: Colors.white
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
        unselectedItemColor: Colors.white,

      ),
    );
  }
}