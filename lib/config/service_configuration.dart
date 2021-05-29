import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../utils/dependency_injection.dart';

abstract class ServiceConfiguration {
  static void registerServices() {
    injected.registerLazySingleton<AuthService>(() => AuthService());
    injected.registerLazySingleton<ProfileService>(() => ProfileService());
  }
}
