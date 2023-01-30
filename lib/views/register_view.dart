import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev_tools show log;

import 'package:mynotes/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

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
      appBar: AppBar(title: const Text("Register")),
      body: Column(
                children: [
                  TextField(
                    controller: _email,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(hintText: "Password"),
            
                  ),
                  TextButton(
                    onPressed: () async {
                      try{
                        final email = _email.text;
                        final password = _password.text;
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                      }on FirebaseAuthException catch(e){
                        if(e.code == "unknown"){
                          dev_tools.log("All fields are required");
                        }else{
                          dev_tools.log(e.code);
                        }
                      }
                    },
                    child: const Text("Register"),
                  ),
                  TextButton(
            onPressed: (() {
              Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }), child: const Text("Have an account? Login"))
                ]
              ),
    );
  }
}