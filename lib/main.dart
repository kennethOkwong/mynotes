import 'package:firebase_core/firebase_core.dart'; //Important firebase_core to use it's libraries
import 'package:flutter/material.dart'; //Importing Material for UI
import 'package:firebase_auth/firebase_auth.dart'; //Importing auth for authentication
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
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
        },
      ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
          future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
          builder:(context, snapshot) {
            switch (snapshot.connectionState){
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if ((user != null) && (user.emailVerified == true)){
                  return const NotesView();
                }else if ((user != null) && (user.emailVerified == false)){
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


