import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';


enum AuthStatus { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
    final AuthService _authService = AuthService();
    UserModel? _user;
    AuthStatus _status = AuthStatus.Uninitialized;
    String _errorMessage = '';

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
        } else {
            _status = AuthStatus.Unauthenticated;
        }
        notifyListeners();
    }
    
    Future<bool> login(String nic, String password) async {
        _status = AuthStatus.Authenticating;
        _errorMessage = '';
        notifyListeners();

        try {
            _user = await _authService.login(nic, password);
            _status = AuthStatus.Authenticated;
            notifyListeners();
            return true;
        } catch (e) {
            _errorMessage = e.toString();
            _status = AuthStatus.Unauthenticated;
            notifyListeners();
            return false;
        }
    }

    // Handles the logout logic
    Future<void> logout() async {
        await _authService.logout();
        _user = null;
        _status = AuthStatus.Unauthenticated;
        notifyListeners();
    }
}
