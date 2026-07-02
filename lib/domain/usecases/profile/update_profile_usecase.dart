import '../../repositories/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository _repository;
  UpdateProfileUsecase(this._repository);
  Future<({String? error})> call({String? fullName, String? phone}) =>
      _repository.updateProfile(fullName: fullName, phone: phone);
}
