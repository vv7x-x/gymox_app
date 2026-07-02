class Profile {
  final String id;
  final String? memberId;
  final String fullName;
  final String? phone;
  final String? photoUrl;

  Profile({
    required this.id,
    this.memberId,
    required this.fullName,
    this.phone,
    this.photoUrl,
  });
}
