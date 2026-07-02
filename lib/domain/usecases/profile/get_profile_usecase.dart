import '../../entities/profile.dart';
import '../../repositories/profile_repository.dart';

class GetProfileUsecase {
  final ProfileRepository _repository;
  GetProfileUsecase(this._repository);
  Future<Profile?> call() => _repository.getProfile();
}
