import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text_form_field.dart';
import '../../Widgets/gradiant_scaffold.dart';



class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage  ({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  String email = '';
  final _auth = FirebaseAuth.instance;
  Future<void> _forgetPassword() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent! Check your inbox.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
                Lottie.asset(
                  'Assets/animation/splash.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  onLoaded: (composition) {
                    Future.delayed(composition.duration, () {
                      Duration(seconds: 20);
                    });
                  },
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
                        Text("Forget Password",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
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
                        CustomButton(
                          onPressed: _forgetPassword,
                          child: Text(
                          "Reset Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        )
                      ],
                    ),
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
