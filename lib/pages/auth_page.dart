import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/pages/home_page.dart';
import 'package:untitled/pages/login_or_register_page.dart';
import 'package:untitled/pages/verify_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else if(snapshot.hasError){
              return const Center(child: Text("Something went wrong"));
            }else if (snapshot.hasData && snapshot.data!.emailVerified == false) {
              return  const VerifyPage();
            }else if(snapshot.hasData && snapshot.data!.emailVerified == true){
              return HomePage();
            }else{
              return const LoginOrRegister();
            }
          },
        ));
  }
}
