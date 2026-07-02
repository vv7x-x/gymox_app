import '../../repositories/profile_repository.dart';

class UploadPhotoUsecase {
  final ProfileRepository _repository;
  UploadPhotoUsecase(this._repository);
  Future<({String? error})> call(String filePath) => _repository.uploadPhoto(filePath);
}
