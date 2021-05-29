import 'dart:async';

import 'package:ryder/exceptions/profile_exception.dart';
import 'package:ryder/utils/postgres_errors.dart';
import 'package:ryder/utils/supabase.dart';
import 'package:supabase/supabase.dart';

import '../utils/dependency_injection.dart';
import 'auth_service.dart';

final _authService = injected<AuthService>();

class ProfileService {
  final SupabaseClient _supabase;

  ProfileService() : _supabase = Supabase.client;

  Future<bool> hasProfile() async {
    _authService.assertLoggedIn();

    final query = _supabase
        .from('profiles')
        .select('*')
        .eq('id', _authService.currentUser?.id)
        .single();
    final result = await query.execute();

    if (result.error != null) {
      return false;
    }

    return result.data != null;
  }

  Future<void> create({
    required String username,
    String? bio,
  }) async {
    await _authService.assertLoggedIn();

    final query = _supabase.from('profiles').insert({
      'id': _authService.currentUser?.id,
      'username': username.trim(),
      'bio': bio?.trim(),
    });
    final result = await query.execute();

    if (result.error != null) {
      final error = result.error!;

      if (error.code == PostgresErrorCodes.uniqueKeyViolation) {
        throw UsernameAlreadyTakenException();
      } else if (error.code == PostgresErrorCodes.unmetCheckViolation) {
        throw UsernameTooShortException();
      } else {
        print('Error #${error.code}: ${error.message}');
        throw ProfileException(result.error!.message);
      }
    }

    return result.data;
  }
}
