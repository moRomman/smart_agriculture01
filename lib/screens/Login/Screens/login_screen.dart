import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_agriculture/Shared/consts.dart';
import 'package:smart_agriculture/main.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _showSnackBar(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Close',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  Future<User?> _signInWithGoogle(
      {required BuildContext snackBarContext}) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      return user;
    } catch (e) {
      _showSnackBar(snackBarContext, 'Failed to sign in with Google');
      return null;
    }
  }

  Future<User?> _signInAnonymously(
      {required BuildContext snackBarContext}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      User? user = userCredential.user;

      if (user != null) {
        return user;
      } else {
        _showSnackBar(snackBarContext, 'Failed to sign in anonymously');
        return null;
      }
    } catch (e) {
      print('Error signing in anonymously: $e');
      _showSnackBar(snackBarContext, 'Failed to sign in anonymously');
      return null;
    }
  }

  Future<User?> _login({required BuildContext snackBarContext}) async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      return user;
    } catch (e) {
      print('Login Error: $e');
      _showSnackBar(
          snackBarContext, 'Failed to sign in. Please check your credentials.');
      return null;
    }
  }

  Widget _buildPasswordFormField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: MyColors.mainColor),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: MyColors.mainColor,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          hintText: hintText,
          labelText: labelText,
          floatingLabelStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.7),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyColors.mainColor, width: 2),
          ),
          labelStyle: const TextStyle(
              color: MyColors.mainColor, fontWeight: FontWeight.bold),
        ),
        obscureText: !_passwordVisible,
        validator: validator,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: MyColors.mainColor),
          hintText: hintText,
          labelText: labelText,
          floatingLabelStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.7),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyColors.mainColor, width: 2),
          ),
          labelStyle: const TextStyle(
              color: MyColors.mainColor, fontWeight: FontWeight.bold),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/splash.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.85,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100.withOpacity(0.4),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(
                            'The World Of Smart Agriculture',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                              // Apply gradient color
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.black,
                                    Colors.blueGrey,
                                  ],
                                ).createShader(const Rect.fromLTWH(70.0, 70.0,
                                    200.0, 70.0)), // Adjust Rect size as needed
                            ),
                          ),
                        ),
                        const Spacer(),
                        _buildTextFormField(
                          controller: _emailController,
                          hintText: 'Enter your email',
                          labelText: 'Email',
                          icon: Icons.email,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your email' : null,
                        ),
                        _buildPasswordFormField(
                          controller: _passwordController,
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          validator: (value) =>
                              value!.length < 6 ? 'Password too short.' : null,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 40,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xff598216).withOpacity(0.999),
                              ),
                              overlayColor: WidgetStateProperty.all<Color>(
                                Colors.green.shade100.withOpacity(0.5),
                              ),
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              _login(snackBarContext: context).then(
                                (value) {
                                  if (value != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainBottomNavScreen()),
                                    );
                                  }
                                },
                              );
                            },
                            child: const Text(
                              'LogIn',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 40,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xff598216).withOpacity(0.5),
                              ),
                              overlayColor: WidgetStateProperty.all<Color>(
                                Colors.green.shade100.withOpacity(0.5),
                              ),
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignUpPage()));
                            },
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'OR',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.overline),
                        ),
                        Container(
                          height: 1,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: IconButton(
                                onPressed: () async {
                                  _signInWithGoogle(snackBarContext: context)
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainBottomNavScreen()),
                                        );
                                      }
                                    },
                                  );
                                },
                                icon: const Image(
                                  image: AssetImage('images/google_300221.png'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: IconButton(
                                onPressed: () async {
                                  _signInAnonymously(snackBarContext: context)
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainBottomNavScreen()),
                                        );
                                      }
                                    },
                                  );
                                },
                                icon: const Image(
                                  image: AssetImage('images/incognito.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:smart_agriculture/Shared/consts.dart';
// import 'package:smart_agriculture/main.dart';
//
// import 'signup_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _passwordVisible = false;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _showSnackBar(BuildContext context, String message) async {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 2),
//         content: Text(
//           message,
//           style: const TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.red,
//         action: SnackBarAction(
//           label: 'Close',
//           onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//         ),
//       ),
//     );
//   }
//
//   Future<User?> _signInWithGoogle({required snackBarContext}) async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//       if (googleSignInAccount == null) return null;
//
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       final UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       final User? user = userCredential.user;
//
//       return user;
//     } catch (e) {
//       _showSnackBar(snackBarContext, 'Failed to sign in with Google');
//       return null;
//     }
//   }
//
//   // Future<User?> _signInWithFacebook({required snackBarContext}) async {
//   //   try {
//   //     final LoginResult result = await FacebookAuth.instance.login();
//   //     if (result.status == LoginStatus.success) {
//   //       final AccessToken? accessToken = result.accessToken;
//   //       final OAuthCredential facebookAuthCredential =
//   //           FacebookAuthProvider.credential(accessToken!.tokenString);
//   //
//   //       final UserCredential userCredential = await FirebaseAuth.instance
//   //           .signInWithCredential(facebookAuthCredential);
//   //
//   //       return userCredential.user;
//   //     } else {
//   //       _showSnackBar(snackBarContext, 'Failed to sign in with Facebook');
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     _showSnackBar(snackBarContext, 'Failed to sign in with Facebook');
//   //     return null;
//   //   }
//   // }
//   Future<User?> _signInAnonymously({required snackBarContext}) async {
//     try {
//       // Sign in anonymously
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInAnonymously();
//
//       // Access the user information
//       User? user = userCredential.user;
//
//       if (user != null) {
//         // Return the signed-in user
//         return user;
//       } else {
//         // Handle login failure
//         _showSnackBar(snackBarContext, 'Failed to sign in anonymously');
//         return null;
//       }
//     } catch (e) {
//       // Handle other errors
//       print('Error signing in anonymously: $e');
//       _showSnackBar(snackBarContext, 'Failed to sign in anonymously');
//       return null;
//     }
//   }
//
//   Future<User?> _login({required snackBarContext}) async {
//     try {
//       final String email = _emailController.text.trim();
//       final String password = _passwordController.text.trim();
//
//       // Sign in user with email and password
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       // If login is successful, you can navigate to another screen
//       final User? user = userCredential.user;
//
//       return user;
//       // For example:
//       // Navigator.pushReplacementNamed(context, '/home');
//     } catch (e) {
//       // Handle login errors here
//       print('Login Error: $e');
//       // Show error message to user
//
//       _showSnackBar(
//           snackBarContext, 'Failed to sign in. Please check your credentials.');
//       return null;
//     }
//   }
//
//   Widget _buildPasswordFormField({
//     required TextEditingController controller,
//     required String hintText,
//     required String labelText,
//     required String? Function(String?) validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.lock, color: MyColors.mainColor),
//           suffixIcon: IconButton(
//             icon: Icon(
//               _passwordVisible ? Icons.visibility_off : Icons.visibility,
//               color: MyColors.mainColor,
//             ),
//             onPressed: () {
//               setState(() {
//                 _passwordVisible = !_passwordVisible;
//               });
//             },
//           ),
//           hintText: hintText,
//           labelText: labelText,
//           floatingLabelStyle:
//               const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
//           filled: true,
//           fillColor: Colors.grey.withOpacity(0.7),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: MyColors.mainColor, width: 2),
//           ),
//           labelStyle: const TextStyle(
//               color: MyColors.mainColor, fontWeight: FontWeight.bold),
//         ),
//         obscureText: !_passwordVisible,
//         validator: validator,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Form(
//           key: _formKey,
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('images/splash.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SingleChildScrollView(
//                 child: Container(
//                   width: double.infinity,
//                   height: MediaQuery.of(context).size.height * 0.85,
//                   margin: const EdgeInsets.only(top: 40),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade100.withOpacity(0.4),
//                     borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(50),
//                       topLeft: Radius.circular(50),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ListTile(
//                           title: Text(
//                             'The World Of Smart Agriculture',
//                             textAlign: TextAlign.center,
//                             textScaler: const TextScaler.linear(2),
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               // Apply gradient color
//                               foreground: Paint()
//                                 ..shader = const LinearGradient(
//                                   colors: [
//                                     Colors.black,
//                                     Colors.black,
//                                     Colors.blueGrey,
//                                     // Colors.black,
//
//                                     // Colors.blueAccent
//                                   ],
//                                   // Adjust colors as needed
//                                   // begin: Alignment.topLeft,
//                                   // end: Alignment.bottomRight,
//                                 ).createShader(const Rect.fromLTWH(70.0, 70.0,
//                                     200.0, 70.0)), // Adjust Rect size as needed
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         buildTextFormField(
//                           controller: _emailController,
//                           hintText: 'Enter your email',
//                           labelText: 'Email',
//                           icon: Icons.email,
//                           validator: (value) =>
//                               value!.isEmpty ? 'Please enter your email' : null,
//                         ),
//                         _buildPasswordFormField(
//                           controller: _passwordController,
//                           hintText: 'Enter your password',
//                           labelText: 'Password',
//                           validator: (value) =>
//                               value!.length < 6 ? 'Password too short.' : null,
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width / 1.5,
//                           height: 40,
//                           child: OutlinedButton(
//                             style: ButtonStyle(
//                               backgroundColor: WidgetStateProperty.all<Color>(
//                                 const Color(0xff598216).withOpacity(0.999),
//                               ),
//                               overlayColor: WidgetStateProperty.all<Color>(
//                                 Colors.green.shade100.withOpacity(0.5),
//                               ),
//                               shape: WidgetStateProperty.all<OutlinedBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             onPressed: () async {
//                               _login(snackBarContext: context).then(
//                                 (value) {
//                                   if (value != null) {
//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const MainBottomNavScreen()),
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                             child: const Text(
//                               'LogIn',
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width / 1.5,
//                           height: 40,
//                           child: OutlinedButton(
//                             style: ButtonStyle(
//                               backgroundColor: WidgetStateProperty.all<Color>(
//                                 const Color(0xff598216).withOpacity(0.5),
//                               ),
//                               overlayColor: WidgetStateProperty.all<Color>(
//                                 Colors.green.shade100.withOpacity(0.5),
//                               ),
//                               shape: WidgetStateProperty.all<OutlinedBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => const SignUpPage()));
//                             },
//                             child: const Text(
//                               'Sign Up',
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         const Text(
//                           'OR',
//                           style: TextStyle(
//                               color: Colors.white,
//                               decoration: TextDecoration.overline),
//                         ),
//                         Container(
//                           height: 1,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(height: 30),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: 80,
//                               height: 80,
//                               child: IconButton(
//                                 onPressed: () async {
//                                   _signInWithGoogle(snackBarContext: context)
//                                       .then(
//                                     (value) {
//                                       if (value != null) {
//                                         Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const MainBottomNavScreen()),
//                                         );
//                                       }
//                                     },
//                                   );
//                                 },
//                                 icon: const Image(
//                                   image: AssetImage('images/google_300221.png'),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             SizedBox(
//                               height: 80,
//                               width: 80,
//                               child: IconButton(
//                                 onPressed: () async {
//                                   _signInAnonymously(snackBarContext: context)
//                                       .then(
//                                     (value) {
//                                       if (value != null) {
//                                         Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const MainBottomNavScreen()),
//                                         );
//                                       }
//                                     },
//                                   );
//                                 },
//                                 icon: const Image(
//                                   image: AssetImage('images/incognito.png'),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:smart_agriculture/main_bottom_navigation.dart';
// // import 'package:smart_agriculture/presentation_layer/screens/signup_screen.dart';
// //
// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   final GoogleSignIn _googleSignIn = GoogleSignIn();
// //
// //   Future<String?> _signInWithGoogle() async {
// //     try {
// //       final GoogleSignInAccount? googleSignInAccount =
// //           await _googleSignIn.signIn();
// //       if (googleSignInAccount == null) return 'invalid';
// //
// //       final GoogleSignInAuthentication googleSignInAuthentication =
// //           await googleSignInAccount.authentication;
// //
// //       final AuthCredential credential = GoogleAuthProvider.credential(
// //         accessToken: googleSignInAuthentication.accessToken,
// //         idToken: googleSignInAuthentication.idToken,
// //       );
// //
// //       final UserCredential userCredential =
// //           await FirebaseAuth.instance.signInWithCredential(credential);
// //       final User? user = userCredential.user;
// //
// //       if (user != null) {
// //         return 'valid';
// //       } else {
// //         return 'invalid';
// //       }
// //     } catch (e) {
// //       print('Error signing in with Google: $e');
// //       return 'invalid';
// //     }
// //   }
// //
// //   Future<String?> _signInWithFacebook() async {
// //     try {
// //       final LoginResult result = await FacebookAuth.instance.login();
// //
// //       if (result.status == LoginStatus.success) {
// //         final AccessToken? accessToken = result.accessToken;
// //         final OAuthCredential facebookAuthCredential =
// //             FacebookAuthProvider.credential(accessToken!.token);
// //
// //         await FirebaseAuth.instance
// //             .signInWithCredential(facebookAuthCredential);
// //         return 'valid';
// //       } else {
// //         print('Facebook login failed: ${result.message}');
// //         return 'invalid';
// //       }
// //     } catch (e) {
// //       print('Error signing in with Facebook: $e');
// //       return 'invalid';
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         alignment: Alignment.bottomCenter,
// //         children: [
// //           Container(
// //             decoration: const BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage('images/splash.jpg'),
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             top: 100,
// //             child: Column(
// //               children: [
// //                 CircleAvatar(
// //                   radius: 50,
// //                   backgroundImage: AssetImage('images/smartphone_5399177.png'),
// //                   backgroundColor: Colors.transparent,
// //                 ),
// //                 const SizedBox(height: 20),
// //                 Text(
// //                   'The World Of Smart Agriculture',
// //                   style: TextStyle(
// //                     fontSize: 24,
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.w100,
// //                   ),
// //                   textAlign: TextAlign.center,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             bottom: 0,
// //             child: Container(
// //               width: MediaQuery.of(context).size.width,
// //               decoration: const BoxDecoration(
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(30),
// //                   topRight: Radius.circular(30),
// //                 ),
// //                 color: Colors.white,
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => SignUpPage()),
// //                         );
// //                       },
// //                       child: const Text('Sign Up'),
// //                     ),
// //                     const SizedBox(height: 10),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         // Sign in action
// //                       },
// //                       child: const Text('Sign In'),
// //                     ),
// //                     const SizedBox(height: 20),
// //                     const Text(
// //                       'OR',
// //                       style: TextStyle(
// //                         color: Colors.black54,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 20),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Expanded(
// //                           child: IconButton(
// //                             iconSize: 50,
// //                             onPressed: () async {
// //                               final result = await _signInWithGoogle();
// //                               if (result == 'valid') {
// //                                 Navigator.pushReplacement(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: (context) => MainScreen()),
// //                                 );
// //                               } else {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(
// //                                     content: Text(
// //                                       'Invalid Sign Up',
// //                                       style: TextStyle(color: Colors.red),
// //                                     ),
// //                                     duration: Duration(seconds: 1),
// //                                     action: SnackBarAction(
// //                                       label: 'Close',
// //                                       onPressed: () {
// //                                         ScaffoldMessenger.of(context)
// //                                             .hideCurrentSnackBar();
// //                                       },
// //                                     ),
// //                                   ),
// //                                 );
// //                               }
// //                             },
// //                             icon: Image.asset('images/google_300221.png'),
// //                           ),
// //                         ),
// //                         const SizedBox(width: 20),
// //                         Expanded(
// //                           child: IconButton(
// //                             iconSize: 50,
// //                             onPressed: () async {
// //                               final result = await _signInWithFacebook();
// //                               if (result == 'valid') {
// //                                 Navigator.pushReplacement(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: (context) => MainScreen()),
// //                                 );
// //                               } else {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(
// //                                     content: Text(
// //                                       'Invalid Sign Up',
// //                                       style: TextStyle(color: Colors.red),
// //                                     ),
// //                                     duration: Duration(seconds: 1),
// //                                     action: SnackBarAction(
// //                                       label: 'Close',
// //                                       onPressed: () {
// //                                         ScaffoldMessenger.of(context)
// //                                             .hideCurrentSnackBar();
// //                                       },
// //                                     ),
// //                                   ),
// //                                 );
// //                               }
// //                             },
// //                             icon: Image.asset('images/facebook_5968764.png'),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
