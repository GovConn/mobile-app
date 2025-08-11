
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedTimeIndex = 1;

  final Map<DateTime, int> _availableSlots = {
    // A map to simulate available slots per day
    DateTime.now().add(const Duration(days: 2)): 15,
    DateTime.now().add(const Duration(days: 3)): 10,
    DateTime.now().add(const Duration(days: 5)): 20,
    DateTime.now().add(const Duration(days: 10)): 5,
  };

  final List<String> _timeSlots = [
    '8.30 AM - 9.00 AM',
    '9.00 AM - 9.30 AM',
    '9.30 AM - 10.00 AM',
    '10.00 AM - 10.30 AM',
    '10.30 AM - 11.00 AM',
    '11.00 AM - 11.30 AM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text('Back',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Reservation',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),
              const Text(
                'Reserve the date and time',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              _buildCalendarHeader(),
              const SizedBox(height: 16),
              _buildCalendar(),
              const SizedBox(height: 24),
              const Text(
                'Your Time Slot',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              _buildTimeSlotsGrid(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Next button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Next',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  _focusedDay =
                      DateTime(_focusedDay.year, _focusedDay.month - 1);
                });
              },
            ),
            Text(
              '${_focusedDay.monthName} ${_focusedDay.year}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                setState(() {
                  _focusedDay =
                      DateTime(_focusedDay.year, _focusedDay.month + 1);
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            _buildLegendItem(Colors.amber, 'Available'),
            const SizedBox(width: 16),
            _buildLegendItem(Colors.grey[300]!, 'Filled'),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.now().subtract(const Duration(days: 365 * 10)),
      lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.amber[600],
          borderRadius: BorderRadius.circular(8),
        ),
        todayDecoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(8),
        ),
        outsideDaysVisible: false,
        markerDecoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final isPastDay = day.isBefore(
              DateTime.now().subtract(const Duration(hours: 24)));
          final availableSlots = _availableSlots[
              DateTime(day.year, day.month, day.day, 0, 0, 0)];
          final bool hasSlots = availableSlots != null && availableSlots > 0;
          return GestureDetector(
            onTap: () {
              if (!isPastDay) {
                setState(() {
                  _selectedDay = day;
                  _focusedDay = focusedDay;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSameDay(day, _selectedDay)
                    ? Colors.amber[600]
                    : (isPastDay
                        ? Colors.grey[100]
                        : (hasSlots
                            ? Colors.amber[100]
                            : Colors.grey[300])),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isSameDay(day, _selectedDay)
                        ? Colors.white
                        : Colors.black,
                    fontWeight: isSameDay(day, _selectedDay)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.amber[600],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          final isPastDay = day.isBefore(
              DateTime.now().subtract(const Duration(hours: 24)));
          return GestureDetector(
            onTap: () {
              if (!isPastDay) {
                setState(() {
                  _selectedDay = day;
                  _focusedDay = focusedDay;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSameDay(day, _selectedDay)
                    ? Colors.amber[600]
                    : (isPastDay ? Colors.grey[100] : Colors.amber[100]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isSameDay(day, _selectedDay)
                        ? Colors.white
                        : Colors.black,
                    fontWeight: isSameDay(day, _selectedDay)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  Widget _buildTimeSlotsGrid() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(_timeSlots.length, (index) {
        final time = _timeSlots[index];
        final isSelected = _selectedTimeIndex == index;
        final isUnavailable = index == 3; // Example of an unavailable slot
        final count = 11 - index; // Dynamic count example

        return GestureDetector(
          onTap: isUnavailable
              ? null
              : () => setState(() => _selectedTimeIndex = index),
          child: Card(
            elevation: 0,
            color: isSelected
                ? Colors.amber[600]
                : (isUnavailable ? Colors.red[100] : Colors.white),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: isSelected
                      ? Colors.amber[600]!
                      : (isUnavailable
                          ? Colors.red[100]!
                          : Colors.grey[300]!),
                  width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available: $count',
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

extension on DateTime {
  String get monthName {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

