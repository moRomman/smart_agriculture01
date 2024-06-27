// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_agriculture/main.dart';
// import 'package:smart_agriculture/screens/Login/Screens/login_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _animation;
//
//   @override
//   initState() {
//     // TODO: implement initState
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//
//     _animation = Tween<Offset>(
//       begin: const Offset(-2.0, 0.0),
//       end: Offset.zero,
//     ).animate(_animationController);
//     _animationController.forward();
//
//     _animation.addListener(() {
//       if (_animationController.isCompleted) {
//         Future.delayed(
//           const Duration(seconds: 2),
//           () {
//             FirebaseAuth.instance.authStateChanges().listen((User? user) {
//               if (user == null) {
//                 // User is not logged in
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const LoginScreen()));
//               } else {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const MainBottomNavScreen()));
//                 // User is logged in
//                 debugPrint('User ID: ${user.uid}');
//               }
//             });
//           },
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: const Color(0xff598216),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.width / 2,
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: Image.asset(
//                   'images/smartphone_5399177.png',
//                   alignment: Alignment.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SlideTransition(
//                       position: _animation,
//                       child: const Text(
//                         'Smart  ',
//                         style: TextStyle(
//                           fontSize: 30,
//                           color: Colors.black45,
//                           fontWeight: FontWeight.w300,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     const Text(
//                       'Agriculture',
//                       style: TextStyle(fontSize: 30, color: Colors.black54),
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture/main.dart';
import 'package:smart_agriculture/screens/Login/Screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(_animationController);
    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), _navigateUser);
      }
    });
  }

  void _navigateUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainBottomNavScreen()),
        );
        debugPrint('User ID: ${user.uid}');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff598216),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset(
                'images/smartphone_5399177.png',
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _animation,
                    child: const Text(
                      'Smart  ',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black45,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Text(
                    'Agriculture',
                    style: TextStyle(fontSize: 30, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
