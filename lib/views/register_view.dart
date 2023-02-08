import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_alert_dialog.dart';

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
                        await AuthService.firebase().createAccount(email: email, password: password);
                        await AuthService.firebase().sendEmailVerification();
                          Navigator.of(context).pushNamed(verifyEmailRoute);
                      }on IncompleteInputsAuthException{
                        showErrorDialog(context, "All fields are required");
                      }on GenericAuthException{
                        showErrorDialog(context, "Authentication error");
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