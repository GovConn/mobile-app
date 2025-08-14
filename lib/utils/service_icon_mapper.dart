
String getIconForService(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case 'education services':
      return 'assets/icons/Examination-service.png';
    case 'health services':
      return 'assets/icons/hospital-service.png';
    case 'municipal council':
      return 'assets/icons/municipal-service.png';
    case 'examination services':
      return 'assets/icons/Examination-service.png';
    case 'passport services':
      return 'assets/icons/passport-service.png';
    default:
      return 'assets/icons/services.png';
  }
}