import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _passworditor = TextEditingController();
  final _secureStorage = FlutterSecureStorage();
  String _storedPassword = '';
  String _username = '';
  String _pNumber = '';
  String _job = '';
  String _statusText = '';
  @override
  void initState() {
    super.initState();
    _loadPassword();
  }

  Future<void> _loadPassword() async {
    try {
      final name = await _secureStorage.read(key: 'username');
      final password = await _secureStorage.read(key: 'password');
      _passworditor.text = password ?? '';
      final number = await _secureStorage.read(key: 'phoneNumber');
      final job = await _secureStorage.read(key: 'Job');
      final ststus = await _secureStorage.read(key: 'status');
      setState(() {
        _username = name ?? '';
        _storedPassword = password ?? '';
        _pNumber = number ?? '';
        _job = job ?? '';
        _statusText = ststus ?? '';
      });
    } catch (e) {
      print('Error reading password: $e');
      // Optionally show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          'Sign Up Editor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.black12,
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[400]!),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12.0),
                // margin: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Name:$_username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text('', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[400]!),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12.0),
                // margin: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Password: $_storedPassword',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                // controller: _passworditor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new pasword',
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[400]!),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12.0),
                // margin: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Status: $_statusText',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text('', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[400]!),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12.0),
                // margin: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Job: $_job',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text('', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[400]!),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12.0),
                // margin: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Phone No:$_pNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text('', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
