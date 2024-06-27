// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:smart_agriculture/Shared/consts.dart';
// import 'package:smart_agriculture/screens/Community/Screens/community_screen.dart';
// import 'package:smart_agriculture/screens/Home/Screens/home_screen.dart';
// import 'package:smart_agriculture/screens/Login/Screens/splash_screen.dart';
// import 'package:smart_agriculture/screens/Market/Screens/market_screen.dart';
// import 'package:smart_agriculture/screens/Settings/Screens/setting_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

// class MainBottomNavScreen extends StatefulWidget {
//   const MainBottomNavScreen({super.key});

//   @override
//   _MainBottomNavScreenState createState() => _MainBottomNavScreenState();
// }

// class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
//   int _selectedIndex = 0;
//   final PageController _pageController = PageController();

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         children: const [
//           HomeScreen(),
//           CommunityScreen(),
//           MarketScreen(),
//           SettingScreen(),
//         ],
//       ),
//       bottomNavigationBar: Card(
//         clipBehavior: Clip.antiAlias,
//         margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//         elevation: 20,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(
//               icon: ImageIcon(
//                 AssetImage('images/leaf.png'),
//               ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(
//                 AssetImage('images/community.png'),
//               ),
//               label: 'Community',
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(
//                 AssetImage('images/crop.png'),
//               ),
//               label: 'Market',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings_outlined),
//               label: 'Settings',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: MyColors.mainColor,
//           onTap: (value) {
//             _pageController.animateToPage(
//               value,
//               duration: const Duration(milliseconds: 10),
//               curve: Curves.linear,
//             );
//           },
//           unselectedItemColor: Colors.lightGreen.shade600,
//           selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           showUnselectedLabels: false,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_agriculture/Shared/consts.dart';
import 'package:smart_agriculture/screens/Community/Screens/community_screen.dart';
import 'package:smart_agriculture/screens/Home/Screens/home_screen.dart';
import 'package:smart_agriculture/screens/Login/Screens/splash_screen.dart';
import 'package:smart_agriculture/screens/Market/Screens/market_screen.dart';
import 'package:smart_agriculture/screens/Settings/Screens/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  _MainBottomNavScreenState createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          HomeScreen(),
          CommunityScreen(),
          MarketScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/leaf.png'),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/community.png'),
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/crop.png'),
            ),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.mainColor,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.lightGreen.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
      ),
    );
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.linear,
    );
  }
}
