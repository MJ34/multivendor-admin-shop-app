import 'package:admin_vendor/screens/category_screen.dart';
import 'package:admin_vendor/screens/dashboard_screen.dart';
import 'package:admin_vendor/screens/main_category_screen.dart';
import 'package:admin_vendor/screens/sub_category_screen.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App Admin',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SideMenu(),
      builder: EasyLoading.init(),
    );
  }
}

class SideMenu extends StatefulWidget {
  static const String id = 'side-menu';
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget _selectedScreen = const DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.id:
        setState(() {
          _selectedScreen = const DashboardScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = const CategoryScreen();
        });
        break;
      case MainCategoryScreen.id:
        setState(() {
          _selectedScreen = const MainCategoryScreen();
        });
        break;
      case SubCategoryScreen.id:
        setState(() {
          _selectedScreen = const SubCategoryScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Shop App Admin',
          style: TextStyle(letterSpacing: 1),
        ),
      ),
      sideBar: SideBar(
        items: const [
          MenuItem(
            title: 'Dashboard',
            route: DashboardScreen.id,
            icon: Icons.dashboard_rounded,
          ),
          MenuItem(
            title: 'Categories',
            icon: IconlyLight.category,
            children: [
              MenuItem(
                title: 'Category',
                route: CategoryScreen.id,
              ),
              MenuItem(
                title: 'Main Category',
                route: MainCategoryScreen.id,
              ),
              MenuItem(
                title: 'Sub Category',
                route: SubCategoryScreen.id,
              ),
            ],
          ),
        ],
        selectedRoute: SideMenu.id,
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: Center(
            child: Text(
              DateTimeFormat.format(DateTime.now(),
                  format: AmericanDateFormats.dayOfWeek),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _selectedScreen,
      ),
    );
  }
}
