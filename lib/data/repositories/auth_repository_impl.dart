import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<({String? error})> login(String email, String password) => _datasource.login(email, password);

  @override
  Future<({String? error})> register(String email, String password, String fullName, String phone) =>
      _datasource.register(email, password, fullName, phone);

  @override
  Future<void> logout() => _datasource.logout();

  @override
  Future<({String? error})> resetPassword(String email) => _datasource.resetPassword(email);

  @override
  bool isLoggedIn() => _datasource.isLoggedIn();

  @override
  String? getCurrentUserId() => _datasource.getCurrentUserId();
}
