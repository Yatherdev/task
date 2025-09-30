import 'package:blood_bank/presentation/Auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Model/custom_color.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text_form_field.dart';
import '../../Widgets/gradiant_scaffold.dart';
import '../../Widgets/login_button.dart';
import '../Screens/home_page.dart';
import 'forgetpassword_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

   Future <void> _login() async{
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Error: $e')),
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
                Image.asset(
                  'Assets/images/bloodbag1.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
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
                        Text("Sign In",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
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
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>                          ForgetPasswordPage()
                          ));
                          ForgetPasswordPage();
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Forgot password ?",style: TextStyle(color: CustomColors.darkRed),),
                          ],
                        )),
                        CustomButton(onPressed: _login, child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),),
                      ],
                    ),
                  ),
                ),
                LoginButton(onPressed: (){}),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(color: CustomColors.dried),),
                      TextButton(
                          onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      }, child: Text("Sign Up",style: TextStyle(color: CustomColors.clotted),)),
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