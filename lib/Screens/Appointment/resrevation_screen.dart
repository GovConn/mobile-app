import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gov_connect_app/Screens/Appointment/confirmation_screen.dart';
import 'package:gov_connect_app/providers/appointment_provider.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedTimeIndex = 1;

@override
void initState() {
  super.initState();
    _selectedDay = _focusedDay;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    appointmentProvider.getAvailableSlots();
    
  });
}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text('Back',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'Reservation',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: height * 0.0075),
              const Text(
                'Reserve the date and time',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: height * 0.02),
              _buildCalendarHeader(),
              const SizedBox(height: 12),
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
                  final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
                    final requestBody = appointmentProvider.buildCreateSlotBody();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
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
      mainAxisAlignment: MainAxisAlignment.start,
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
            _buildLegendItem(primaryColor, 'Available'),
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
        final appointmentProvider =
            Provider.of<AppointmentProvider>(context, listen: false);

        appointmentProvider.selectDate(selectedDay);
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
        markerDecoration: const BoxDecoration(
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
          final isPastDay =
              day.isBefore(DateTime.now().subtract(const Duration(days: 1)));

          final appointmentProvider =
              Provider.of<AppointmentProvider>(context, listen: false);

          // Check if there are slots on this date
          final hasSlots = appointmentProvider.slots.any(
            (slot) =>
                slot.bookingDate.year == day.year &&
                slot.bookingDate.month == day.month &&
                slot.bookingDate.day == day.day,
          );

          return GestureDetector(
            onTap: () {
              if (!isPastDay) {
                final appointmentProvider =
                    Provider.of<AppointmentProvider>(context, listen: false);
                appointmentProvider
                    .selectDate(day); // this handles slots + reset
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
                        : (hasSlots ? Colors.amber[100] : Colors.grey[300])),
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
          final isPastDay =
              day.isBefore(DateTime.now().subtract(const Duration(hours: 24)));
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
    return Consumer<AppointmentProvider>(
      builder: (context, appointmentProvider, child) {
        // Handle loading state
        if (appointmentProvider.slotState == NotifierState.loading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: SpinKitFadingCircle(
                color: primaryColor,
                size: 30.0,
              ),
            ),
          );
        }

        // Handle error state
        if (appointmentProvider.slotState == NotifierState.error) {
          return Center(
            child: Column(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 36),
                const SizedBox(height: 8),
                Text(
                  appointmentProvider.errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => appointmentProvider.getAvailableSlots(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Handle empty state
        if (appointmentProvider.slots.isEmpty) {
          return const Center(
            child: Column(
              children: [
                Icon(Icons.schedule, color: Colors.grey, size: 36),
                SizedBox(height: 8),
                Text(
                  'No slots available for this date',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // Display available slots
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(appointmentProvider.slots.length, (index) {
            final slot = appointmentProvider.slots[index];
            final isSelected = _selectedTimeIndex == index;
            appointmentProvider.selectSlot(slot); 
            final dateStr = DateFormat('yyyy-MM-dd').format(slot.bookingDate)  ;      

            return GestureDetector(
              onTap: () => setState(() => _selectedTimeIndex = index),
              child: AnimatedContainer(
                width: double.infinity,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Card(
                  surfaceTintColor: isSelected ? primaryColorLight : greyTextColor.withOpacity(0.5),
                  elevation: isSelected ? 4 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  color:  Colors.white,
                  child: Container(
                    width: 180,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date display
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: isSelected ? primaryColor : Colors.grey[600],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  dateStr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : Colors.grey[800],
                                  ),
                                ),
                                
                              ],
                            ),
                             Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(slot.status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            slot.status.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Time slot
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey[200]!,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              slot.displayLabel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Capacity indicator
                        LinearProgressIndicator(
                          value: slot.maxCapacity > 0
                              ? slot.reservedCount / slot.maxCapacity
                              : 0,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            slot.reservedCount >= slot.maxCapacity
                                ? Colors.red[400]!
                                : isSelected ? primaryColor : primaryColor,
                          ),
                          minHeight: 6,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${slot.reservedCount} of ${slot.maxCapacity} slots',
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? primaryColor : Colors.grey[600],
                          ),
                        ),                       
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

   Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'full':
        return Colors.orange;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
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

