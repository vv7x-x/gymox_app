class Member {
  final String id;
  final String memberNumber;
  final String fullName;
  final String? phone;
  final String? gender;
  final String? birthDate;
  final String? address;
  final String? photoUrl;
  final String? notes;

  Member({
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
}
