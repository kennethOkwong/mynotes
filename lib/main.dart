import 'package:flutter/material.dart'; //Importing Material for UI
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';


void main() {
  // runApp(const MyApp);
  WidgetsFlutterBinding.ensureInitialized;
  runApp(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          loginRoute:(context) => const LoginView(),
          registerRoute:(context) => const RegisterView(),
          notesRoute:(context) => const NotesView(),
          verifyEmailRoute:(context) => const VerifyEmailView(),
        },
      ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
          future: AuthService.firebase().initialise(),
          builder:(context, snapshot) {
            switch (snapshot.connectionState){
              case ConnectionState.done:
                final user = AuthService.firebase().currentUser;
                if ((user != null) && (user.isEmailVerified == true)){
                  return const NotesView();
                }else if ((user != null) && (user.isEmailVerified
                 == false)){
                  return const VerifyEmailView();
                }else{
                  return const LoginView();
                }
              default:
              return const CircularProgressIndicator();
            } 
          },
          
       
        );
  }
}


