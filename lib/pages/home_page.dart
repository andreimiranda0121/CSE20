import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut() {
    AuthService().logout();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: 100,
            width:double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(5), //border corner radius
              /*boxShadow:[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: const Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                )
                //you can set more BoxShadow() here
              ],*/
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  "Hello World",
                  style: TextStyle(
                    color: Colors.green[900],
                  ),
                ),
                const SizedBox(height: 5,),
                const Text(
                  "₱ 5000",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 100,),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            height: 200,
            width:double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5), //border corner radius
              boxShadow:[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: const Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
