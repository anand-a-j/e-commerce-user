import 'package:e_commerce_app/screens/auth/widgets/login_title.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/screens/auth/widgets/sign_in_bottom_title.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
 static const String routeName = '/sign-in-screen';
 const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

 AuthService authService = AuthService();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

    void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signInFormKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginTitle(),
                Dimensions.kHeight10,
                CustomTextField(controller: _emailController, hintText: "Email"),
                Dimensions.kHeight10,
                CustomTextField(controller: _passwordController, hintText: "Password"),
                Dimensions.kHeight20,
                CustomButton(title: "Login", onPressed: signInUser),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                const SignInBottomTitle()
              ],
            ),
          ),
        ),
      ),
    );
  }
}