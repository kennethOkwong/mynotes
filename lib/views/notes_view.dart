import 'package:flutter/material.dart';
import 'dart:developer' as dev_tools show log;
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums.dart';
import 'package:mynotes/services/auth/auth_service.dart';


class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [PopupMenuButton<MenuAction>(
          onSelected: (value) async {
            switch (value){
              case MenuAction.logout:
                final shouldLogout = await showLogoutDialog(context);
                if (shouldLogout){
                  AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  dev_tools.log("Signed out");
                }
            }
          },
          itemBuilder: ((context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Logout")),
            ];
          }
          ),
        )
        ],  
      ),
      body: const Text("Welcome Christy!"),
    );
  }
}


Future<bool> showLogoutDialog(BuildContext context){
 return showDialog<bool>(
  context: context, 
  builder: (context){
    return AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          }, 
          child: const Text("Cancel")),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop(true);
          }, 
          child: const Text("Logout")),
      ],
    );
  }
 ).then((value) => value ?? false);
}