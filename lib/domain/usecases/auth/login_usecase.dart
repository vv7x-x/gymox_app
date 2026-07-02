import '../../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _repository;
  LoginUsecase(this._repository);
  Future<({String? error})> call(String email, String password) => _repository.login(email, password);
}
