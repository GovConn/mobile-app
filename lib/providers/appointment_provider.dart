
import 'package:flutter/material.dart';
import 'package:gov_connect_app/models/office_service_model.dart';
import 'package:gov_connect_app/services/office_api_service.dart';

import '../models/office_model.dart';


enum NotifierState { initial, loading, loaded, error }

class AppointmentProvider with ChangeNotifier {
  final OfficeAPiService _apiService = OfficeAPiService();


  List<Office> _offices = [];
  List<GovService> _services = [];

  Office? _selectedOffice;
  GovService? _selectedService;

  NotifierState _officeState = NotifierState.initial;
  NotifierState _serviceState = NotifierState.initial;
  String _errorMessage = '';

  // Getters
  List<Office> get offices => _offices;
  List<GovService> get services => _services;
  Office? get selectedOffice => _selectedOffice;
  GovService? get selectedService => _selectedService;
  NotifierState get officeState => _officeState;
  NotifierState get serviceState => _serviceState;
  String get errorMessage => _errorMessage;

  // Methods
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
  
  void selectService(GovService? service) {
    _selectedService = service;
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
}