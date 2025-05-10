import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'settings_page.dart'; // Make sure this import is correct

class SettingSignUp extends StatefulWidget {
  const SettingSignUp({super.key});
  @override
  _SettingSignUpState createState() => _SettingSignUpState();
}

class _SettingSignUpState extends State<SettingSignUp> {
  final _secureStorage = const FlutterSecureStorage();
  String _storedPassword = '';
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadPassword();
  }

  Future<void> _loadPassword() async {
    try {
      final password = await _secureStorage.read(key: 'password');
      setState(() {
        _storedPassword = password ?? '';
      });
    } catch (e) {
      // Log the error
      print('Error reading password: $e');
      // Show error to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load password.'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _checkPassword() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          //Wrap form
          key: _formKey, // Associate the form with the key
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Enter Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value != _storedPassword) {
                    return 'Incorrect password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkPassword, // Use the new function name
                child: const Text('Sign-Up Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
