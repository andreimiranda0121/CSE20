import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/home_page.dart';
import 'package:untitled/services/utils.dart';

import 'auth_page.dart';


class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isEmailVerified = false;
  bool resendEmail = false;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Timer? timer;
  @override
  void initState(){
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerifyEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
          (_) => checkEmailVerify(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  Future checkEmailVerify() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) {
      timer?.cancel();
    };
  }

  Future sendVerifyEmail() async{
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        resendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        resendEmail = true;
      });
    }on FirebaseAuthException catch(e){
      Utils.showSnackBar(e.code);
    }

  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? const AuthPage() : Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A verification email has been sent to your email.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.email,size:32),
              label: const Text(
                "Resent Email",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: resendEmail ? sendVerifyEmail:null,
            ),
            const SizedBox(
              height:10,
            ),
            TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 14),
                )
            )
          ],
        ),
      ),
    );
  }
}