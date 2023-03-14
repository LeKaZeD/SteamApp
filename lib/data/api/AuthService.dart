import 'dart:async';

import 'package:steam_app/Screen/Component/errorException.dart';
import 'package:steam_app/data/api/databaseService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client;

  AuthService(this.client);

  Future<AuthResponse> signInUser(String userEmail, String userPassword) async {
    final res = await client.auth
        .signInWithPassword(password: userPassword, email: userEmail);
    return res;
  }

  Future<AuthResponse> signUp(String userEmail, String userPassword) async {
    final res =
        await client.auth.signUp(password: userPassword, email: userEmail);

    if (res.session != null) {
      DatabaseService(client).createUser(res);
    }
    return res;
  }

  StreamSubscription<AuthState> listenToAuthStatus() {
    return client.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      final AuthChangeEvent event = data.event;

      switch (event) {
        case AuthChangeEvent.signedIn:
          if (session != null) {}
          break;
      }
    });
  }

  bool isLoggedIn() {
    return client.auth.currentSession != null;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
