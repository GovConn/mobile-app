import 'package:flutter/material.dart';
import 'package:gov_connect_app/models/service_model.dart';
import 'package:gov_connect_app/services/service_api_service.dart';

enum NotifierState { initial, loading, loaded, error }

class ServiceProvider extends ChangeNotifier {
  final ServiceApiService _apiService = ServiceApiService();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  List<Service> _services = [];
  List<Service> get services => _services;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getServices(String token) async {
    _setState(NotifierState.loading);
    try {
      _services = await _apiService.fetchServices(token);
      _setState(NotifierState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(NotifierState.error);
    }
  }

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }
}