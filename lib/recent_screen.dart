import 'package:flutter/material.dart';
import 'json_Extraction.dart';
import 'phone_details.dart';

class RecentScreen extends StatefulWidget {
  final Function(bool) onScroll;
  const RecentScreen({Key? key, required this.onScroll}) : super(key: key);

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

enum UserScrollDirection { reverse, forward }

class _RecentScreenState extends State<RecentScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _scrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == UserScrollDirection.reverse && !_scrollingDown) {
        _scrollingDown = true;
        widget.onScroll(false);
      } else if (direction == UserScrollDirection.forward && _scrollingDown) {
        _scrollingDown = false;
        widget.onScroll(true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return FutureBuilder<List<dynamic>>(
      future: apiService.fetchdata(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return OrientationBuilder(
            builder: (context, orientation) {
              int crossAxisCount = 2;
              double childAspectRatio = 1.45;
              if (orientation == Orientation.landscape) {
                crossAxisCount = 3;
                childAspectRatio = 2;
              }
              return GridView.count(
                controller: _scrollController,
                crossAxisCount: crossAxisCount,
                padding: const EdgeInsets.all(30),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: childAspectRatio,
                children:
                    data.map<Widget>((item) {
                      return Container(
                        padding: const EdgeInsets.all(18.0),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.blue[400],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            PhoneDetails(phoneName: item.name),
                                  ),
                                );
                              },
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              );
            },
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
