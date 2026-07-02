import '../../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _repository;
  RegisterUsecase(this._repository);
  Future<({String? error})> call(String email, String password, String fullName, String phone) =>
      _repository.register(email, password, fullName, phone);
}
