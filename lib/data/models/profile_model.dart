import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/profile.dart';

class ProfileModel {
  final String id;
  final String? memberId;
  final String fullName;
  final String? phone;
  final String? photoUrl;

  ProfileModel({
    required this.id,
    this.memberId,
    required this.fullName,
    this.phone,
    this.photoUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String?,
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String?,
      photoUrl: json['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (memberId != null) 'member_id': memberId,
      'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (photoUrl != null) 'photo_url': photoUrl,
    };
  }

  Profile toEntity() {
    return Profile(id: id, memberId: memberId, fullName: fullName, phone: phone, photoUrl: photoUrl);
  }

  PostgrestFilter? applyUserIdFilter(PostgrestFilter query) {
    return query.eq('id', id);
  }
}
