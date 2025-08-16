
String getIconForService(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case 'education services':
      return 'assets/icons/education-services.png';
    case 'health services':
      return 'assets/icons/health-services.png';
    case 'civil services':
      return 'assets/icons/municipal-service.png';
    case 'security services':
      return 'assets/icons/security-services.png';
    case 'transport services':
      return 'assets/icons/transport-services.png';
    default:
      return 'assets/icons/services.png';
  }
}