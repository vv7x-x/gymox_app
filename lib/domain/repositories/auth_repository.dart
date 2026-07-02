import '../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<({String? error})> login(String email, String password);
  Future<({String? error})> register(String email, String password, String fullName, String phone);
  Future<void> logout();
  Future<({String? error})> resetPassword(String email);
  bool isLoggedIn();
  String? getCurrentUserId();
}
