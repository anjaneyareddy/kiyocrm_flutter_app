import 'package:flutter/material.dart';
import 'login_page.dart';
import 'flutter_storage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FlutterStorage _flutterStorage = FlutterStorage();
  final _formKey = GlobalKey<FormState>();
  String _statusMessage = '';
  bool _ispasswordVisible = true;
  bool _isReposswordVisible = true;
  String _selectedMaritalStatus = '';
  String? _selectedJob; // Added for job dropdown

  void _togglePasswordVisibility() {
    setState(() {
      _ispasswordVisible = !_ispasswordVisible;
    });
  }

  void _toggleRePasswordVisibility() {
    setState(() {
      _isReposswordVisible = !_isReposswordVisible;
    });
  }

  // Validation functions
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }

    final RegExp regex = RegExp(r'.*?@?[^@]*\..*');
    if (!regex.hasMatch(value)) {
      return 'Invalid email format.';
    }

    return null;
  }

  String? _validateJob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a job';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  String? _validateRePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != _flutterStorage.passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // List of marital status options
  final List<String> _maritalStatusOptions = ['Married', 'Single'];
  //list of job options
  final List<String> _jobOptions = [
    '-select-',
    'Software Engineer',
    'Doctor',
    'Teacher',
    'Accountant',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _selectedJob = _jobOptions.first; // Initialize with a default value.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _flutterStorage.firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _flutterStorage.lastnameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _flutterStorage.usernameController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: _validateUsername,
                ),
                const SizedBox(height: 20),
                // Marital Status Choice Chips
                Row(
                  children: [
                    const Text(
                      'Marital Status: ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    Wrap(
                      spacing: 8.0,
                      children:
                          _maritalStatusOptions.map((status) {
                            return ChoiceChip(
                              label: Text(
                                status,
                                style: const TextStyle(color: Colors.black),
                              ),
                              selected: _selectedMaritalStatus == status,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedMaritalStatus = status;
                                    _flutterStorage.status.text =
                                        status; // Update the controller
                                  });
                                }
                              },
                              selectedColor: Colors.deepPurple[300],
                              backgroundColor: Colors.grey[300],
                            );
                          }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Job Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedJob,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedJob = newValue;
                      _flutterStorage.jobs.text = newValue!;
                    });
                  },
                  items:
                      _jobOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Job',
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: _validateJob,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _flutterStorage.phoneNumber,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: _validatePhoneNumber,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _flutterStorage.passwordController,
                  obscureText: _ispasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'password',
                    floatingLabelStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: Icon(
                        _ispasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _flutterStorage.reenteredPasswordController,
                  obscureText: _isReposswordVisible,
                  decoration: InputDecoration(
                    labelText: ' Re-enter password',
                    floatingLabelStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: _toggleRePasswordVisibility,
                      icon: Icon(
                        _isReposswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: _validateRePassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _flutterStorage.saveCredentials(context);
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 10),
                Text(
                  _statusMessage,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flutterStorage.usernameController.dispose();
    _flutterStorage.passwordController.dispose();
    _flutterStorage.reenteredPasswordController.dispose();
    _flutterStorage.phoneNumber.dispose();
    _flutterStorage.jobs.dispose();
    _flutterStorage.status.dispose();
    super.dispose();
  }
}
