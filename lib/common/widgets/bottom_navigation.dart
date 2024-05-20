import 'package:connections/constants/colors.dart';
import 'package:connections/features/createEvent/screens/createevent.dart';
import 'package:connections/features/home/screens/home_screen.dart';
import 'package:connections/features/profile/screens/profile.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  static const String routeName = '/bottom-navigation';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  List<Widget> _pages = [HomeScreen(),CreateEvent(),ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (ind) {
            index = ind;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/home.png',
                  width: 30,
                  height: 30,
                  color: index == 0 ? buttonColor : buttonTextColor,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/event.png',
                    width: 35, height: 35,
                    color: index==1?buttonColor:buttonTextColor,),
                label: ''),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/profile.png',
                  width: 30,
                  height: 30,
                  color: index == 2 ? buttonColor : buttonTextColor,
                ),
                label: ''),
          ]),
    );
  }
}


