import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile?> getProfile();
  Future<({String? error})> updateProfile({String? fullName, String? phone});
  Future<({String? error})> uploadPhoto(String filePath);
}
