import 'package:ryder/config/environment.dart';
import 'package:supabase/supabase.dart';

abstract class Supabase {
  static final SupabaseClient _singleton = SupabaseClient(
    Environment.supabaseUrl,
    Environment.supabaseKey,
  );

  static SupabaseClient get client => _singleton;
}
