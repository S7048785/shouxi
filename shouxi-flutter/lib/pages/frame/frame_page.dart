import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shouxi/pages/date/date_page.dart';
import 'package:shouxi/pages/emergency/emergency_controller.dart';
import 'package:shouxi/pages/home/home_page.dart';
import 'package:shouxi/pages/setting/setting_page.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    Get.put(EmergencyController());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: [
          const HomePage(),
          const DatePage(),
          const SettingPage(),
        ]),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.date_range), label: '轨迹'),
          NavigationDestination(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
