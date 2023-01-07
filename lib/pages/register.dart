import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/email_textfield.dart';
import 'package:untitled/components/password_textfield.dart';
import 'package:untitled/components/sign_button.dart';
import 'package:untitled/main.dart';
import 'package:untitled/services/utils.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(
                  height: 30,
                ),
                //logo
                const Icon(
                  Icons.flutter_dash,
                  size: 100,
                ),
                //welcome back
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                //username
                const SizedBox(
                  height: 20,
                ),
                EmailText(
                    controller: _email,
                    hintText: 'Enter your email',
                    autoCorrect: false,
                    suggestion: false),
                //password
                const SizedBox(
                  height: 10,
                ),

                PasswordText(
                  controller: _password,
                  hintText: 'Enter your password',
                  obscureText: true,
                  autoCorrect: false,
                  suggestion: false,
                ),
                //forgot password
                const SizedBox(
                  height: 10,
                ),
                PasswordText(

                  controller: _confirmPassword,
                  hintText: 'Confirm your password',
                  obscureText: true,
                  autoCorrect: false,
                  suggestion: false,
                ),
                //sigin button
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Sign Up',
                  onTap: signUp,
                ),
                //google sigin
                const SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                          )),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //google icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'lib/images/google-icon.png',
                        height: 40,
                      ),
                    )
                  ],
                ),
                //register

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
  Future signUp() async {
    //show loading circle
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //sign in
    try {
      if(_password.text == _confirmPassword.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);
      }else {
        Utils.showSnackBar('Password is not same');
      }

      // ignore: use_build_context_synchronously

    } on FirebaseAuthException catch (e) {
      //wrong email

      Utils.showSnackBar(e.code);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // ignore: use_build_context_synchronously
  }
}
