import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class BioDataFormDialog extends StatefulWidget {
  const BioDataFormDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BioDataFormDialogState createState() => _BioDataFormDialogState();
}

class _BioDataFormDialogState extends State<BioDataFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nicController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();


  @override
  void dispose() {
    _nicController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  String? _validateNic(String? value) {
    if (value == null || value.isEmpty) {
      return 'NIC cannot be empty';
    }
    final is12Digits = RegExp(r'^\d{12}$').hasMatch(value);
    final is9DigitsV = RegExp(r'^\d{9}[vV]$').hasMatch(value);
    if (!is12Digits && !is9DigitsV) {
      return 'Enter a valid NIC (12 digits or 9 digits + V)';
    }
    return null;
  }

  void _confirm() {
    if (_formKey.currentState!.validate()) {
      final bioData = {
        'nic': _nicController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
      };
      Navigator.of(context).pop(bioData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: whitePrimary,
      surfaceTintColor: whitePrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
        vertical: deviceHeight * 0.05,
      ),
      child: SizedBox(
        width: deviceWidth * 0.9,
        height: deviceHeight * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  color: blackPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(thickness: 1, height: 20),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTextFormField(
                            controller: _nicController,
                            label: 'NIC Number',
                            validator: _validateNic),
                        const SizedBox(height: 16),
                        _buildTextFormField(
                            controller: _firstNameController,
                            label: 'First Name'),
                        const SizedBox(height: 16),
                        _buildTextFormField(
                            controller: _lastNameController,
                            label: 'Last Name'),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: greyTextColor),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _confirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                          color: blackPrimary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: blackPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: greyTextColor, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: lightGreyColor.withOpacity(0.3),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: greyTextColor.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:BorderSide(color: greyTextColor.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return '$label cannot be empty';
            }
            return null;
          },
    );
  }
}
