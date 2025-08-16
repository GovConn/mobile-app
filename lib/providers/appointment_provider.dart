import 'package:flutter/material.dart';
import 'package:gov_connect_app/models/office_service_model.dart';
import 'package:gov_connect_app/services/office_api_service.dart';
import '../models/appointment_slot_model.dart';
import '../models/office_model.dart';

enum NotifierState { initial, loading, loaded, error }

class AppointmentProvider with ChangeNotifier {
  final OfficeAPiService _apiService = OfficeAPiService();

  List<AppointmentSlot> _slots = [];
  List<Office> _offices = [];
  List<GovService> _services = [];

  Office? _selectedOffice;
  GovService? _selectedService;
  DateTime _selectedDate = DateTime.now();
  AppointmentSlot? _selectedSlot;

  NotifierState _officeState = NotifierState.initial;
  NotifierState _serviceState = NotifierState.initial;
  NotifierState _slotState = NotifierState.initial;
  String _errorMessage = '';

  List<Office> get offices => _offices;
  List<GovService> get services => _services;
  List<AppointmentSlot> get slots => _slots;
  Office? get selectedOffice => _selectedOffice;
  GovService? get selectedService => _selectedService;
  DateTime get selectedDate => _selectedDate;
  AppointmentSlot? get selectedSlot => _selectedSlot;
  NotifierState get officeState => _officeState;
  NotifierState get serviceState => _serviceState;
  NotifierState get slotState => _slotState;
  String get errorMessage => _errorMessage;

  Future<void> getOffices(int categoryId) async {
    _officeState = NotifierState.loading;
    notifyListeners();

    try {
      _offices = await _apiService.fetchOffices(categoryId);
      _officeState = NotifierState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _officeState = NotifierState.error;
    }
    notifyListeners();
  }

  void selectOffice(Office? office) {
    if (_selectedOffice != office) {
      _selectedOffice = office;
      _selectedService = null;
      _services = [];
      notifyListeners();

      if (office != null) {
        getServices(office.id);
      }
    }
  }

  void selectSlot(AppointmentSlot? slot) {
    _selectedSlot = slot;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _resetSlotSelection();
    notifyListeners();
    if (_selectedService != null) {
      getAvailableSlots();
    }
  }

  void selectService(GovService? service) {
    if (_selectedService != service) {
      _selectedService = service;
      _resetSlotSelection();
      notifyListeners();
      if (service != null) {
        getAvailableSlots();
      }
    }
  }

  Future<void> getAvailableSlots() async {
    if (_selectedService == null) return;

    _slotState = NotifierState.loading;
    notifyListeners();

    try {
      _slots = await _apiService.fetchAvailableSlots(
          _selectedService!.serviceId, _selectedDate);
      _slotState = NotifierState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _slots = []; // Clear slots on error
      _slotState = NotifierState.error;
    }
    notifyListeners();
  }

  Future<void> getServices(int officeId) async {
    _serviceState = NotifierState.loading;
    notifyListeners();

    try {
      _services = await _apiService.fetchServices(officeId);
      _serviceState = NotifierState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _serviceState = NotifierState.error;
    }
    notifyListeners();
  }

  Map<String, dynamic> buildCreateSlotBody() {
    if (selectedService == null) {
      throw Exception("Service must be selected before creating slot");
    }

    return {
      "booking_date": "2025-08-09", // Replace with actual selected date
      "start_time": "2025-08-09T07:00:00Z", // Replace dynamically
      "end_time": "2025-08-09T08:00:00Z", // Replace dynamically
      "max_capacity": 10,
      "reservation_id": selectedService!.serviceId, // 👈 service_id here
      "reserved_count": 5,
      "status": "available",
    };
  }

  void _resetSlotSelection() {
    _slots = [];
    _selectedSlot = null;
    _slotState = NotifierState.initial;
  }
}
