import '../../repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository _repository;
  ResetPasswordUsecase(this._repository);
  Future<({String? error})> call(String email) => _repository.resetPassword(email);
}
