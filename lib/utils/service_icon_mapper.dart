
String getIconForService(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case 'education services':
      return 'assets/icons/Examination-service.png';
    case 'health services':
      return 'assets/icons/hospital-service.png';
    case 'civil services':
      return 'assets/icons/municipal-service.png';
    case 'securit services':
      return 'assets/icons/Examination-service.png';
    case 'transport services':
      return 'assets/icons/Passport-service.png';
    default:
      return 'assets/icons/services.png';
  }
}