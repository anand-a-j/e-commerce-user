import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/login/screen/sign_in_screen.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/widgets/bottom_nav_bar.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    _auth.getUserData(context: context);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
       
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<UserProvider>(context, listen: false)
                          .user
                          .token
                          .isNotEmpty &&
                      Provider.of<UserProvider>(context, listen: false)
                              .user
                              .type ==
                          'user'
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    )
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
            });
            return const Scaffold(body: Loader());
          } else {
            return const NewSplashScreen();
          }
        });
  }
}

class NewSplashScreen extends StatelessWidget {
  const NewSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(10),
          width: 700,
          height: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash_logo.gif'),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
