
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentSlot {
  final int slotId;
  final int reservationId;
  final TimeOfDay startTime;  // changed type
  final TimeOfDay endTime;
  final int maxCapacity;
  final int reservedCount;
  final String status;
  final DateTime bookingDate;

  AppointmentSlot({
    required this.slotId,
    required this.reservationId,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.reservedCount,
    required this.status,
    required this.bookingDate,
  });

  // A computed property to check if the slot is full
  bool get isFull => reservedCount >= maxCapacity;

  factory AppointmentSlot.fromMap(Map<String, dynamic> map) {
        TimeOfDay parseTime(String timeStr) {
      final parts = timeStr.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    return AppointmentSlot(
      slotId: map['slot_id']?.toInt() ?? 0,
      reservationId: map['reservation_id']?.toInt() ?? 0,
       startTime: parseTime(map['start_time']),
      endTime: parseTime(map['end_time']),
      maxCapacity: map['max_capacity']?.toInt() ?? 0,
      reservedCount: map['reserved_count']?.toInt() ?? 0,
      status: map['status'] ?? '',
      bookingDate: DateTime.parse(map['booking_date']),
    );
  }

  factory AppointmentSlot.fromJson(String source) =>
      AppointmentSlot.fromMap(json.decode(source));

   String get displayLabel {
    final now = DateTime.now();
    final startDateTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
    final endDateTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
    final formatter = DateFormat.jm();
    return "${formatter.format(startDateTime)} - ${formatter.format(endDateTime)}";
  }
}