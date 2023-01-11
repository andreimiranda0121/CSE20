import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/services/auth_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser?.uid;
  @override
  State<HomePage> createState() => _HomePageState(user!);
}

class _HomePageState extends State<HomePage> {
  final String uid;
  String input = "";
  _HomePageState(this.uid);
  var taskcollections = FirebaseFirestore.instance.collection('task');
  String task = "";
  void signOut() {
    AuthService().logout();
    FirebaseAuth.instance.signOut();
  }

  void showdialog(bool isUpdate, DocumentSnapshot? ds) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                isUpdate ? const Text("Update Todo") : const Text("Add Todo"),
            content: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task",
                ),
                validator: (_val) {
                  if (_val!.isEmpty) {
                    return "Can't Be Empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (_val) {
                  task = _val;
                },
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState?.save();
                    if (isUpdate) {
                      taskcollections
                          .doc(uid)
                          .collection('task')
                          .doc(ds?.id)
                          .update({
                        'task': task,
                        'time': DateTime.now(),
                      });
                    } else {
                      //  insert

                      taskcollections.doc(uid).collection('task').add({
                        'task': task,
                        'time': DateTime.now(),
                      });
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "tepeno",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text('To-Do'),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showdialog(false, null),
        child: const Icon(Icons.add),
        backgroundColor: Colors.greenAccent[700],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .doc(uid)
            .collection('task')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      ds['task'],
                      style: const TextStyle(
                        fontFamily: "tepeno",
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    onLongPress: () {
                      // delete
                      taskcollections
                          .doc(uid)
                          .collection('task')
                          .doc(ds.id)
                          .delete();
                    },
                    onTap: () {
                      // == Update
                      showdialog(true, ds);
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              content: const Text("Please re log in, thank you."),
              actions: <Widget>[
                TextButton(
                  onPressed: signOut,
                  child: const Text("OK"),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
