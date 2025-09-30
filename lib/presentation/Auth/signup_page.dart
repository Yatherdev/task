import 'package:blood_bank/presentation/Auth/userdata_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Model/custom_color.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text_form_field.dart';
import '../../Widgets/gradiant_scaffold.dart';
import '../../Widgets/login_button.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  Future<void> _Signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created successfully!')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserDataScreen()));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign Up Error: $e')));
    }
  }

  // validators
  String? validateName(value) {
    if (value == null || value.isEmpty) {
      return 'Enter Your Name';
    }
    return null;
  }
  String? validateEmail( value) {
    if (value == null || value.trim().isEmpty) { return 'الرجاء إدخال البريد الإلكتروني';}
    final email = value.trim();
    final emailRegex = RegExp( r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"r"(?:\.[a-zA-Z]{2,})+$",);
    if (!emailRegex.hasMatch(email)) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }
  String? validatePassword( value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    if (value.length < minLength) {
      return 'كلمة المرور يجب أن تكون على الأقل $minLength أحرف';
    }

    final upper = RegExp(r'[A-Z]');
    final digit = RegExp(r'\d');

    if (!upper.hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل';
    }
    if (!digit.hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على رقم واحد على الأقل';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: Image.asset(
                    'Assets/images/bloodbag1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Name TextFormField
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          SizedBox(
                            width: 170,
                            child: CustomTextFormField(
                            controller: _firstNameController,
                            labelText: 'First Name',
                            hintText: 'Ahmed',
                            prefixIcon: Icons.person,
                            isPassword: false,
                            keyboardType: TextInputType.name,
                            validator: validateName,
                                                    ),
                          ),
                          SizedBox(width: 170,
                            child: CustomTextFormField(
                            controller: _secondNameController,
                            labelText: 'Second Name',
                            hintText: 'yasser',
                            prefixIcon: Icons.person,
                            isPassword: false,
                            keyboardType: TextInputType.name,
                            validator: validateName,
                                                    ),
                          ),],),
                        SizedBox(height: 20),
                        // Email TextFormField
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'E-mail',
                          hintText: 'Ahmed yasser',
                          prefixIcon: Icons.email_outlined,
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                        ),
                        SizedBox(height: 20),
                        // Password TextFormField
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: "Password",
                          hintText: "example123##",
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: validatePassword,
                        ),
                        SizedBox(height: 20),
                        // Confirm password TextFormField
                        CustomTextFormField(
                          hintText: '',
                          controller: _confirmPasswordController,
                          labelText: "Confirm Password",
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null) {
                              return "Enter Your Password";
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 Characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          onPressed: _Signup,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                LoginButton(onPressed: () {}),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I have an account?",
                        style: TextStyle(color: CustomColors.arterial),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: CustomColors.darkRed),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
