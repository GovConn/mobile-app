import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  AuthStatus _status = AuthStatus.Uninitialized;
  String _errorMessage = '';
  String? _token;
  Timer? _tokenExpiryTimer;

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading; 

  String? get token => _token;
  UserModel? get user => _user;
  AuthStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.Authenticated;

  Future<void> checkLoginStatus() => _checkLoginStatus();

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final hasToken = await _authService.hasToken();
    if (hasToken) {
      _status = AuthStatus.Authenticated;
      _startTokenExpiryTimer(); 
    } else {
      _status = AuthStatus.Unauthenticated;
    }
    notifyListeners();
  }

  Future<void> fetchUser() async {
    if (_user != null) return; // Don't fetch if we already have user
    
    _isUserLoading = true;
    notifyListeners();
    
    try {
      _user = await _authService.getUser();
    } catch (e) {
      debugPrint('Error fetching user: $e');
    } finally {
      _isUserLoading = false;
      notifyListeners();
    }
  }

  // Optional: clear user data (logout)
  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<bool> login(String nic, String password) async {
    _status = AuthStatus.Authenticating;
    _errorMessage = '';
    notifyListeners();

    try {
      _user = await _authService.login(nic, password);
      _token = await _authService.getToken(); 
      _status = AuthStatus.Authenticated;
      _startTokenExpiryTimer(); 
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadToken() async {
    _token = await _authService.getToken();
    if (_token != null) {
      _status = AuthStatus.Authenticated;
      _startTokenExpiryTimer();
    }
    notifyListeners();
  }

  void _startTokenExpiryTimer() {
    _tokenExpiryTimer?.cancel(); 
    _tokenExpiryTimer = Timer(const Duration(hours: 3), () async {
      await logout(); 
    });
  }

  Future<void> logout() async {
    await _authService.logout(); 
    clearUser();
    _user = null;
    _token = null;
    _status = AuthStatus.Unauthenticated;
    _tokenExpiryTimer?.cancel(); 
    notifyListeners();
  }
}
