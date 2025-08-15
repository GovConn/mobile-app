
import 'dart:convert';
import 'package:intl/intl.dart';

class AppointmentSlot {
  final int slotId;
  final int reservationId;
  final DateTime startTime;
  final DateTime endTime;
  final int maxCapacity;
  final int reservedCount;
  final String status;

  AppointmentSlot({
    required this.slotId,
    required this.reservationId,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.reservedCount,
    required this.status,
  });

  // A computed property to check if the slot is full
  bool get isFull => reservedCount >= maxCapacity;

  factory AppointmentSlot.fromMap(Map<String, dynamic> map) {
    return AppointmentSlot(
      slotId: map['slot_id']?.toInt() ?? 0,
      reservationId: map['reservation_id']?.toInt() ?? 0,
      startTime: DateTime.parse(map['start_time']),
      endTime: DateTime.parse(map['end_time']),
      maxCapacity: map['max_capacity']?.toInt() ?? 0,
      reservedCount: map['reserved_count']?.toInt() ?? 0,
      status: map['status'] ?? '',
    );
  }

  factory AppointmentSlot.fromJson(String source) =>
      AppointmentSlot.fromMap(json.decode(source));

  String get displayLabel {
    final formatter = DateFormat.jm();
    return "${formatter.format(startTime)} - ${formatter.format(endTime)}";
  }
}