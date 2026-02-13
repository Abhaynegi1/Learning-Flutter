import 'dart:convert';

class FocusSession {
  final String id;
  final int durationMinutes;
  final DateTime dateTime;
  final bool isWin;

  FocusSession({
    required this.id,
    required this.durationMinutes,
    required this.dateTime,
    required this.isWin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'durationMinutes': durationMinutes,
      'dateTime': dateTime.toIso8601String(),
      'isWin': isWin,
    };
  }

  factory FocusSession.fromMap(Map<String, dynamic> map) {
    return FocusSession(
      id: map['id'],
      durationMinutes: map['durationMinutes'],
      dateTime: DateTime.parse(map['dateTime']),
      isWin: map['isWin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FocusSession.fromJson(String source) =>
      FocusSession.fromMap(json.decode(source));
}
