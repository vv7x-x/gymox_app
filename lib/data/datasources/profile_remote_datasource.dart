import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/supabase_constants.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/profile_model.dart';

class ProfileRemoteDatasource {
  final SupabaseClient _client;

  ProfileRemoteDatasource(this._client);

  Future<ProfileModel?> getProfile() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return null;

      final response = await _client
          .from(SupabaseTables.profiles)
          .select('*, member:members(*)')
          .eq('id', userId)
          .maybeSingle();

      if (response == null) return null;
      return ProfileModel.fromJson(response);
    } catch (e) {
      throw ServerException('Failed to load profile');
    }
  }

  Future<({String? error})> updateProfile({String? fullName, String? phone}) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return (error: 'Not authenticated');

      final data = <String, dynamic>{};
      if (fullName != null) data['full_name'] = fullName;
      if (phone != null) data['phone'] = phone;

      await _client.from(SupabaseTables.profiles).update(data).eq('id', userId);
      return (error: null);
    } catch (e) {
      return (error: 'Failed to update profile');
    }
  }

  Future<({String? error})> uploadPhoto(String filePath) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return (error: 'Not authenticated');

      final fileName = '$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _client.storage.from(AppConstants.storageBucket).upload(fileName, filePath);

      final photoUrl = _client.storage.from(AppConstants.storageBucket).getPublicUrl(fileName);
      await _client.from(SupabaseTables.profiles).update({'photo_url': photoUrl}).eq('id', userId);

      return (error: null);
    } catch (e) {
      return (error: 'Failed to upload photo');
    }
  }
}
