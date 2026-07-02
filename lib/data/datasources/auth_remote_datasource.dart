import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/errors/exceptions.dart';
import '../../core/constants/supabase_constants.dart';

class AuthRemoteDatasource {
  final SupabaseClient _client;

  AuthRemoteDatasource(this._client);

  Future<({String? error})> login(String email, String password) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      return (error: null);
    } on AuthException catch (e) {
      return (error: e.message);
    } catch (e) {
      return (error: 'Login failed. Please check your credentials.');
    }
  }

  Future<({String? error})> register(String email, String password, String fullName, String phone) async {
    try {
      final response = await _client.auth.signUp(email: email, password: password);
      final user = response.user;
      if (user == null) return (error: 'Registration failed');

      await _client.from(SupabaseTables.profiles).insert({
        'id': user.id,
        'full_name': fullName,
        'phone': phone,
      });

      return (error: null);
    } on AuthException catch (e) {
      return (error: e.message);
    } catch (e) {
      return (error: 'Registration failed. Please try again.');
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  Future<({String? error})> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
      return (error: null);
    } on AuthException catch (e) {
      return (error: e.message);
    } catch (e) {
      return (error: 'Failed to send reset email.');
    }
  }

  bool isLoggedIn() {
    return _client.auth.currentSession != null;
  }

  String? getCurrentUserId() {
    return _client.auth.currentUser?.id;
  }
}
