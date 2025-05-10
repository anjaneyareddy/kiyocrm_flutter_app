import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneDetails extends StatefulWidget {
  final String phoneName;

  const PhoneDetails({Key? key, required this.phoneName}) : super(key: key);

  @override
  _PhoneDetailsState createState() => _PhoneDetailsState();
}

class _PhoneDetailsState extends State<PhoneDetails> {
  Future<List<dynamic>> _loadPhoneData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/phone_data.json',
    );
    return json.decode(jsonString);
  }

  Future<Map<String, dynamic>?> _getPhoneDetails() async {
    final List<dynamic> allPhones = await _loadPhoneData();
    return allPhones.firstWhere(
          (phone) => phone['name'] == widget.phoneName,
          orElse: () => null,
        )
        as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text(widget.phoneName), // Use the passed phoneName
      ),
      body: FutureBuilder(
        future: _getPhoneDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading phone details'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final phoneDetails = snapshot.data!;
            final images =
                (phoneDetails['images'] as List<dynamic>?)?.cast<String>() ??
                [];
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            images[index],
                            height: 150,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Model:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${phoneDetails['model'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // Container for Brand
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Brand:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${phoneDetails['brand'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // Container for Storage
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Storage:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${phoneDetails['storage'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // Container for RAM
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'RAM:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${phoneDetails['ram'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // Container for Display
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Display:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${phoneDetails['display'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // Container for Camera
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Camera:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '  Main: ${phoneDetails['camera']?['main'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '  Ultrawide: ${phoneDetails['camera']?['ultrawide'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '  Telephoto: ${phoneDetails['camera']?['telephoto'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // Container for Battery
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Battery:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${phoneDetails['battery'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // Container for Operating System
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Operating System:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${phoneDetails['operating_system'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Phone details not found'));
          }
        },
      ),
      backgroundColor: Colors.deepPurple[200],
    );
  }
}
