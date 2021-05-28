import 'package:ryder/utils/dependency_injection.dart';

import '../services/auth_service.dart';

abstract class ServiceConfiguration {
  static void registerServices() {
    injected.registerLazySingleton<AuthService>(() => AuthService());
  }
}
