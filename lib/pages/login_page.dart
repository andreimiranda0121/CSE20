import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/email_textfield.dart';
import 'package:untitled/components/password_textfield.dart';
import 'package:untitled/components/sign_button.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/forgot_password_page.dart';
import 'package:untitled/services/auth_service.dart';
import 'package:untitled/services/utils.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(
                  height: 50,
                ),
                //logo
                const Icon(
                  Icons.flutter_dash,
                  size: 100,
                ),
                //welcome back
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Welcome back you\'ve been missed!',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    //make the text go to end of the row
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: ()=>Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context)=>const ForgotPasswordPage())
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                //sigin button
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Sign In',
                  onTap: sigiIn,
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
                  height: 20,
                ),
                //google icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()=>AuthService().signInWithGoogle(),
                      child: Container(
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
                      ),
                    )
                  ],
                ),
                //register

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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
  Future sigiIn() async {
    //show loading circle
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      //wrong email
      Utils.showSnackBar(e.code);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // ignore: use_build_context_synchronously
  }

}
