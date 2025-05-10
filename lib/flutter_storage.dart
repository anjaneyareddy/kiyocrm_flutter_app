import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login_page.dart';
import 'login_sucessfully.dart';

class FlutterStorage {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reenteredPasswordController =
      TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController jobs = TextEditingController();
  final TextEditingController status = TextEditingController();
  String get firstname => usernameController.text;
  String get lastname => passwordController.text;
  String get username => usernameController.text;
  String get password => passwordController.text;
  String get repassword => reenteredPasswordController.text;
  String get pNumber => phoneNumber.text;
  String get job => jobs.text;
  String get statusText => status.text;

  String _signUpStatus = '';
  String get signUpStatus => _signUpStatus;

  void updateStatus(String status) {
    _signUpStatus = status;
  }

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> handleLogout(BuildContext context) async {
    try {
      // await _secureStorage.delete(key: 'username');
      // await _secureStorage.delete(key: 'password');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<void> saveCredentials(BuildContext context) async {
    if (password != repassword) {
      updateStatus('Passwords do not match.');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match.')),
        );
      }
      return;
    }

    if (firstname.isNotEmpty &&
        lastname.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty &&
        pNumber.isNotEmpty &&
        job.isNotEmpty &&
        statusText.isNotEmpty) {
      try {
        await _secureStorage.write(key: 'firstname', value: firstname);
        await _secureStorage.write(key: 'lastname', value: lastname);
        await _secureStorage.write(key: 'username', value: username);
        await _secureStorage.write(key: 'password', value: password);
        await _secureStorage.write(key: 'phoneNumber', value: pNumber);
        await _secureStorage.write(key: 'Job', value: job);
        await _secureStorage.write(key: 'status', value: statusText);

        usernameController.clear();
        passwordController.clear();
        reenteredPasswordController.clear();
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginSuccessfully()),
            (route) => false,
          );
        }
      } catch (e) {
        _signUpStatus = 'Error saving credentials: $e';
      }
    } else {
      _signUpStatus = 'Please enter all fields.';
    }
  }
}
