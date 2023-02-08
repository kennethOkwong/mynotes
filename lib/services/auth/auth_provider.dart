

import 'dart:ffi';

import 'package:mynotes/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<void> initialise();
  
  Future<AuthUser> logIn({
    required String email, 
    required String password,
    });

  Future<AuthUser> createAccount({
    required String email, 
    required String password,
    });

  Future<void> sendEmailVerification(); 

  Future<void> logOut();


}