import 'package:flutter/material.dart';
import 'package:task_manager/tabs/settings_tab.dart';
// import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/widgets/add_bottom_sheet_task.dart';
import 'package:task_manager/tabs/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFECDB),
      body: currentIndex==0? TasksTab():SettingsTab(),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        // color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/icon_list.png')),
              label: "menu",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/icon_settings.png")),
              label: "settings",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AddBottomSheetTask(),),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child:Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
