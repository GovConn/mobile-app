import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/toast_message.dart';
import 'package:gov_connect_app/Screens/Appointment/appointment_details_screen.dart';
import 'package:gov_connect_app/models/service_model.dart';
import 'package:gov_connect_app/providers/service_provider.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:gov_connect_app/utils/service_icon_mapper.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../login/login_screen.dart';

class AppointmentServicesScreen extends StatefulWidget {
  const AppointmentServicesScreen({super.key});

  @override
  State<AppointmentServicesScreen> createState() =>
      _AppointmentServicesScreenState();
}

class _AppointmentServicesScreenState extends State<AppointmentServicesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.loadToken().then((_) {
        final token = authProvider.token;
        if (token != null) {
          Provider.of<ServiceProvider>(context, listen: false)
              .getServices(token);
        } else {
          ToastMessage.showError(context, 'Please log in to access services');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Text(
              'Back',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Services',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Consumer<ServiceProvider>(
                builder: (context, serviceProvider, child) {
                  if (serviceProvider.state == NotifierState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (serviceProvider.state == NotifierState.error) {
                    return Center(
                        child: Text(
                            'An error occurred: ${serviceProvider.errorMessage}'));
                  }
                  if (serviceProvider.state == NotifierState.loaded &&
                      serviceProvider.services.isEmpty) {
                    return const Center(child: Text('No services found.'));
                  }
                  return ListView.builder(
                    itemCount: serviceProvider.services.length,
                    itemBuilder: (context, index) {
                      final service = serviceProvider.services[index];
                      return _buildServiceCard(
                        context,
                        service: service,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetailsScreen(
                                categoryId: serviceProvider.services[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context,
      {required Service service, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: lightGreyColor.withOpacity(0.45),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: greyTextColor.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                getIconForService(service.categoryEn.toString()),
                color: primaryColor,
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.categoryEn
                          .split(' ')
                          .map((word) => word.isNotEmpty
                              ? word[0].toUpperCase() +
                                  word.substring(1).toLowerCase()
                              : '')
                          .join(' '),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.descriptionEn,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
