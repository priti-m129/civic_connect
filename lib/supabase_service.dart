import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // Method to create a new user account
  Future<User?> createAccount({
    required String firstName,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'first_name': firstName},
      );
      return response.user;
    } on AuthException {
      return null;
    }
  }

  // Method to sign in a user with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } on AuthException {
      return null;
    }
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}