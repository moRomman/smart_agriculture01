
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture/main.dart';
import '../../../../Shared/consts.dart';
import '../../Community/Repository/post_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
         await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await currentUser.updateDisplayName(_userNameController.text);
          PostUtils.saveUid(currentUser.uid);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainBottomNavScreen()),
        );

        print('Success: ${currentUser?.uid} ${currentUser?.email}');
      } catch (e) {
        print('Error: $e');
        // Show error message to the user (consider using a Snackbar or similar)
      }
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
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyColors.mainColor, width: 2),
          ),
          labelStyle: const TextStyle(color: MyColors.mainColor),
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
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyColors.mainColor, width: 2),
          ),
          labelStyle: const TextStyle(color: MyColors.mainColor),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: MyColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    controller: _userNameController,
                    hintText: 'Enter your name',
                    labelText: 'User Name',
                    icon: Icons.person,
                    validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  _buildTextFormField(
                    controller: _phoneNumberController,
                    hintText: 'Enter your Phone Number',
                    labelText: 'Phone Number',
                    icon: Icons.phone,
                    validator: (value) => value!.isEmpty ? 'Please enter your Phone Number' : null,
                  ),
                  _buildTextFormField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    icon: Icons.email,
                    validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                  ),
                  _buildPasswordFormField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    validator: (value) => value!.length < 6 ? 'Password too short.' : null,
                  ),
                  _buildPasswordFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _signUp,
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
