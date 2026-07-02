class Attendance {
  final String id;
  final String memberId;
  final String? membershipId;
  final String checkInTime;
  final String date;

  Attendance({
    required this.id,
    required this.memberId,
    this.membershipId,
    required this.checkInTime,
    required this.date,
  });
}
