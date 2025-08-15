import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/floating_navbar.dart';
import 'package:gov_connect_app/Screens/Appointment/appointment_service_screen.dart';
import 'package:gov_connect_app/Screens/login/login_screen.dart';
import 'package:gov_connect_app/Screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/color_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: height * 0.01),
            child: Column(
              children: [
                _buildHeader(width, height, context),
                SizedBox(height: height * 0.01),
                _buildOngoingServicesCard(),
                SizedBox(height: height * 0.025),
                _buildServiceGrid(context),
                SizedBox(height: height * 0.028),
                FloatingNavBar(
                  currentIndex: 0,
                  onTap: (index) {
                    if (index == 0) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width, double height, BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/logo/logo.png',
          width: width * 0.35,
          fit: BoxFit.contain,
        ),
        authProvider.isAuthenticated
            ? Container(
                decoration: const BoxDecoration(
                  color: primaryColor, 
                  shape: BoxShape.circle,              
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    color: blackPrimary,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  },
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  authProvider.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              )
      ],
    );
  }

  Widget _buildOngoingServicesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ongoing Services',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.black),
                  onPressed: () {
                    // Handle refresh action
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'No Ongoing Services',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 60),
          GestureDetector(
            onTap: () {
              // Handle "View All" tap
            },
            child: const Text(
              'View All',
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.05, // Adjust aspect ratio for card size
      children: [
        _buildServiceButton(
          imagePath: 'assets/icons/schedule.png',
          label: 'Book an\nAppointment',
          onTap: () {
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            authProvider.loadToken().then((_) async {
              if (authProvider.token == null) {
                debugPrint("No token");
              }
              log("Token: ${authProvider.token}");
            });
            if (authProvider.status == AuthStatus.Authenticated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AppointmentServicesScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
        ),
        _buildServiceButton(
          imagePath: 'assets/icons/services.png',
          label: 'E Services',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AppointmentServicesScreen()),
            );
          },
        ),
        _buildServiceButton(
          imagePath: 'assets/icons/Ai-logo.png',
          label: 'AI Assistant',
          onTap: () {
            // Handle AI Assistant tap
          },
        ),
        _buildServiceButton(
          imagePath: 'assets/icons/coming-soon.png',
          label: 'Coming Soon',
          onTap: () {
            // Handle Coming Soon tap
          },
        ),
      ],
    );
  }

  // A helper widget to create each button in the grid
  Widget _buildServiceButton({
    required String label,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: whitePrimary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 68,
              height: 68,
            ),
            const SizedBox(height: 15),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: blackPrimary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: blackPrimary,
          ),
          child: const Text(
            'History',
            style: TextStyle(
              color: whitePrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
