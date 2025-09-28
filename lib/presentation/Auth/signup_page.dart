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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  Future<void> _Signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Error: $e')),
      );
    }
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
      body:Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: Lottie.asset(
                    'Assets/animation/splash.json',
                    fit: BoxFit.contain,
                    onLoaded: (composition) {
                      Future.delayed(composition.duration, () {
                        Duration(seconds: 20);
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.4),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("Sign Up",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          controller: _nameController,
                          labelText: 'User Name',
                          hintText: 'Ahmed yasser',
                          prefixIcon: Icons.person,
                          isPassword: false,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'example@gmail.com',
                          prefixIcon: Icons.email_outlined,
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Your Email';
                            }if (!value.contains('@')){
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: "Password",
                          hintText: "example123##",
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null ){
                              return "Enter Your Password" ;
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 Characters';
                            }return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          hintText: '',
                          controller: _confirmPasswordController,
                          labelText: "Confirm Password",
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null ){
                              return "Enter Your Password" ;
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 Characters';
                            }return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomButton(onPressed: _Signup, child: Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                ),
                LoginButton(onPressed: (){}),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("I have an account?",style: TextStyle(color: CustomColors.arterial),),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }, child: Text("Login",style: TextStyle(color: CustomColors.darkRed),)),
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
