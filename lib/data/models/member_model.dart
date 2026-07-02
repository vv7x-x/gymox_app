import '../../domain/entities/member.dart';

class MemberModel {
  final String id;
  final String memberNumber;
  final String fullName;
  final String? phone;
  final String? gender;
  final String? birthDate;
  final String? address;
  final String? photoUrl;
  final String? notes;

  MemberModel({
    required this.id,
    required this.memberNumber,
    required this.fullName,
    this.phone,
    this.gender,
    this.birthDate,
    this.address,
    this.photoUrl,
    this.notes,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as String,
      memberNumber: json['member_number'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birth_date'] as String?,
      address: json['address'] as String?,
      photoUrl: json['photo_url'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_number': memberNumber,
      'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (birthDate != null) 'birth_date': birthDate,
      if (address != null) 'address': address,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (notes != null) 'notes': notes,
    };
  }

  Member toEntity() {
    return Member(
      id: id,
      memberNumber: memberNumber,
      fullName: fullName,
      phone: phone,
      gender: gender,
      birthDate: birthDate,
      address: address,
      photoUrl: photoUrl,
      notes: notes,
    );
  }
}
