import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  Future<Profile?> getProfile() async {
    final model = await _datasource.getProfile();
    return model?.toEntity();
  }

  @override
  Future<({String? error})> updateProfile({String? fullName, String? phone}) =>
      _datasource.updateProfile(fullName: fullName, phone: phone);

  @override
  Future<({String? error})> uploadPhoto(String filePath) => _datasource.uploadPhoto(filePath);
}
