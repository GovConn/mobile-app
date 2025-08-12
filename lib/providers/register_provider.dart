import 'package:flutter/material.dart';
import 'package:gov_connect_app/services/register_service.dart';
import '../models/citizen_reg_model.dart'; // Assuming this is your model path

enum RegistrationStatus { initial, loading, success, error }

class RegistrationProvider with ChangeNotifier {
  final RegisterApiService _apiService = RegisterApiService();

  String? nic;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? nicFrontUrl;
  String? nicBackUrl;

  RegistrationStatus _status = RegistrationStatus.initial;
  String _errorMessage = '';
  CitizenRegistrationResponse? _registrationResponse;

  RegistrationStatus get status => _status;
  String get errorMessage => _errorMessage;
  CitizenRegistrationResponse? get registrationResponse => _registrationResponse;

  void updateBioData({
    required String newNic,
    required String newFirstName,
    required String newLastName,
  }) {
    nic = newNic;
    firstName = newFirstName;
    lastName = newLastName;
    notifyListeners();
  }

  void setNicFrontUrl(String url) {
    nicFrontUrl = url;
    notifyListeners();
  }

  void setNicBackUrl(String url) {
    nicBackUrl = url;
    notifyListeners();
  }

  void setEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void setPhone(String newPhone) {
    phone = newPhone;
    notifyListeners();
  }

  bool get isBiodataComplete {
  return firstName != null && firstName!.isNotEmpty &&
         nic != null && nic!.isNotEmpty &&
         true;
}

bool get isReadyForNext {
  final biodataComplete = firstName != null && firstName!.isNotEmpty &&
                          nic != null && nic!.isNotEmpty;
  
  final docsComplete = nicFrontUrl != null && nicBackUrl != null;

  return biodataComplete && docsComplete;
}


  Future<void> registerCitizen() async {
    if (nic == null ||
        firstName == null ||
        lastName == null ||
        email == null ||
        phone == null ||
        nicFrontUrl == null ||
        nicBackUrl == null) {
      _status = RegistrationStatus.error;
      _errorMessage = "Incomplete registration data.";
      notifyListeners();
      return;
    }

    _status = RegistrationStatus.loading;
    notifyListeners();

    final request = CitizenRegistrationRequest(
      nic: nic!,
      firstName: firstName!,
      lastName: lastName!,
      email: email!,
      phone: phone!,
      documentLinks: [
        DocumentLink(title: 'NICFront', url: nicFrontUrl!),
        DocumentLink(title: 'NICBack', url: nicBackUrl!),
      ],
    );

    try {
      _registrationResponse = await _apiService.registerCitizen(request);
      _status = RegistrationStatus.success;
    } catch (e) {
      debugPrint(e.toString());
      _status = RegistrationStatus.error;
      _errorMessage = e.toString();
    }
    
    notifyListeners();
  }
}
