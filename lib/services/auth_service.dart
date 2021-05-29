import 'dart:async';

import 'package:ryder/constants/auth.dart';
import 'package:ryder/exceptions/auth_exception.dart';
import 'package:ryder/utils/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService() : _supabase = Supabase.client;

  User? get currentUser => _supabase.auth.user();
  bool get isLoggedIn => currentUser != null;

  Stream<User?> onAuthStateChanged() {
    final streamController = StreamController<User?>();

    if (currentUser != null) {
      streamController.add(currentUser);
    } else {
      _restoreSession().then((value) => streamController.add(value?.user));
    }

    _supabase.auth.onAuthStateChange((event, session) {
      if (!streamController.isPaused && !streamController.isClosed)
        streamController.add(session?.user);
    });

    streamController.onCancel = () {
      streamController.close();
    };

    return streamController.stream;
  }

  Future<Session?> _restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    bool exist = prefs.containsKey(PERSIST_SESSION_KEY);
    if (!exist) {
      return null;
    }

    final jsonStr = prefs.getString(PERSIST_SESSION_KEY)!;
    final response = await Supabase.client.auth.recoverSession(jsonStr);
    if (response.error != null) {
      prefs.remove(PERSIST_SESSION_KEY);
      return null;
    }

    return response.data;
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

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      PERSIST_SESSION_KEY,
      sessionResponse.data!.persistSessionString,
    );

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
    try {
      final sessionResponse = await _supabase.auth.signUp(email, password);

      if (sessionResponse.error != null) {
        print(sessionResponse.error!.message);
        throw AuthException(sessionResponse.error!.message);
      }

      return sessionResponse.user!;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future resetPassword({required String email}) async {
    await _supabase.auth.api.resetPasswordForEmail(email);
  }

  Future signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(PERSIST_SESSION_KEY);

    await _supabase.auth.signOut();
  }

  Future assertLoggedIn() async {
    if (!isLoggedIn) throw MustBeLoggedInException();
  }
}
