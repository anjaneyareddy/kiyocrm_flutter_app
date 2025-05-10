import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'json_Extraction.dart';
import 'recent_screen.dart';

class Detailscrmp extends StatefulWidget {
  @override
  DetailscrmState createState() => DetailscrmState();
}

class DetailscrmState extends State<Detailscrmp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showBox = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      _showBox = true;
    });
  }

  void toggleBox(bool visible) {
    if (_showBox != visible) {
      setState(() {
        _showBox = visible;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          if (_showBox)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              height: 85,
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircularPercentIndicator(
                    radius: 20.0,
                    lineWidth: 7.0,
                    percent: 0.76,
                    center: const Text(
                      "76%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    progressColor: Colors.white,
                    backgroundColor: Colors.blue,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overall Task Completion",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // SizedBox(height: 1),
                        Text(
                          "Achievement against total calls targeted for the month of September",
                          style: TextStyle(fontSize: 11.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Recent'),
                Tab(text: 'All Groups'),
                Tab(text: 'Archived'),
              ],
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RecentScreen(onScroll: toggleBox),
                AllGroupsScreen(onScroll: toggleBox),
                ArchivedScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllGroupsScreen extends StatefulWidget {
  final Function(bool) onScroll;
  const AllGroupsScreen({Key? key, required this.onScroll}) : super(key: key);

  @override
  State<AllGroupsScreen> createState() => _AllGroupsScreenState();
}

enum UserScrollDirection { reverse, forward }

class _AllGroupsScreenState extends State<AllGroupsScreen> {
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
          return GridView.count(
            controller: _scrollController,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(30),
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children:
                data.map<Widget>((item) {
                  return Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.data.toString(),
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Archived Content'));
  }
}
