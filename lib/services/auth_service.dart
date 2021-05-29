import 'dart:async';

import 'package:ryder/exceptions/auth_exception.dart';
import 'package:ryder/utils/supabase.dart';
import 'package:supabase/supabase.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService() : _supabase = Supabase.client;

  User? get currentUser => _supabase.auth.user();
  bool get isLoggedIn => currentUser != null;

  Stream<User?> get userStream {
    late StreamController<User?> controller;
    var active = true;

    void update(User? user) {
      controller.add(user);
      if (!active) {
        controller.close();
      }
    }

    void start() {
      _supabase.auth.onAuthStateChange((event, session) {
        if (active) {
          update(session?.user);
        }
      });
    }

    void stop() {
      active = false;
    }

    controller = StreamController<User>(
        onListen: start, onPause: stop, onResume: start, onCancel: stop);

    return controller.stream;
  }

  Future<User> signIn(
    String email,
    String password,
  ) async {
    final sessionResponse = await _supabase.auth.signIn(
      email: email,
      password: password,
    );

    if (sessionResponse.error != null) {
      throw AuthException(sessionResponse.error!.message);
    }

    return sessionResponse.user!;
  }

  Future<User> signInWithProvider(Provider provider) async {
    final sessionResponse = await _supabase.auth.signIn(provider: provider);

    if (sessionResponse.error != null) {
      throw AuthException(sessionResponse.error!.message);
    }

    if (sessionResponse.url != null) {
      print(sessionResponse.url);
    }

    return sessionResponse.user!;
  }

  Future<User> register({
    required String email,
    required String password,
    String? username,
  }) async {
    final sessionResponse = await _supabase.auth.signUp(email, password);

    if (sessionResponse.error != null) {
      print(sessionResponse.error!.message);
      throw AuthException(sessionResponse.error!.message);
    }

    return sessionResponse.user!;
  }

  Future resetPassword({required String email}) async {
    await _supabase.auth.api.resetPasswordForEmail(email);
  }

  Future signOut() async {
    await _supabase.auth.signOut();
  }

  Future assertLoggedIn() async {
    if (!isLoggedIn) throw MustBeLoggedInException();
  }
}
