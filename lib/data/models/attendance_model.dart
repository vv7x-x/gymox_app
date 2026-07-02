import '../../domain/entities/attendance.dart';

class AttendanceModel {
  final String id;
  final String memberId;
  final String? membershipId;
  final String checkInTime;
  final String date;

  AttendanceModel({
    required this.id,
    required this.memberId,
    this.membershipId,
    required this.checkInTime,
    required this.date,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      membershipId: json['membership_id'] as String?,
      checkInTime: json['check_in_time'] as String? ?? '',
      date: json['date'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_id': memberId,
      if (membershipId != null) 'membership_id': membershipId,
      'check_in_time': checkInTime,
      'date': date,
    };
  }

  Attendance toEntity() {
    return Attendance(
      id: id,
      memberId: memberId,
      membershipId: membershipId,
      checkInTime: checkInTime,
      date: date,
    );
  }
}
