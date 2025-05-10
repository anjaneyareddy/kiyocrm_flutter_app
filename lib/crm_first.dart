import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'details_crm.dart';
import 'flutter_storage.dart';

class crmpage extends StatefulWidget {
  @override
  crmpageState createState() => crmpageState();
}

class crmpageState extends State<crmpage> {
  final FlutterStorage _flutterStorage = FlutterStorage();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF6554BF),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                await _flutterStorage.handleLogout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
        title: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello! Welcome back!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.fromLTRB(16, 32, 16, 0),
                height: 208,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 190,
                      width: (screenwidth - 32) * 0.50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "50,000,000",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "Total Revenue",
                            style: TextStyle(color: Colors.black, fontSize: 8),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xff081952),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Deducted',
                                style: TextStyle(
                                  color: const Color(0xff081952),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "30,000,000",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xff081952),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Profit',
                                style: TextStyle(
                                  color: const Color(0xff081952),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "480,000,000",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: (screenwidth - 32) * 0.025),
                    SizedBox(
                      height: 190,
                      width: (screenwidth - 32) * 0.37,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Detailscrmp(),
                                  ),
                                );
                              },
                              child: Text(
                                'Details>',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.deepPurple,
                                    value: 70,
                                    title: 'Profit',
                                    radius: 40,
                                    titleStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.orange,
                                    value: 30,
                                    title: 'Deducted',
                                    radius: 40,
                                    titleStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _builditems(
                    icon: Icon(
                      Icons.shopping_basket,
                      size: 30,
                      color: Color(0xffFFA500),
                    ),
                    label: 'Inventory',
                  ),
                  _builditems(
                    icon: Icon(Icons.store, size: 30, color: Color(0xff673AB7)),
                    label: 'Store',
                  ),
                  _builditems(
                    icon: Icon(
                      Icons.campaign,
                      size: 30,
                      color: Color(0xffFF7043),
                    ),
                    label: 'Marketing',
                  ),
                  _builditems(
                    icon: Icon(
                      Icons.storefront,
                      size: 30,
                      color: Color(0xff3F51B5),
                    ),
                    label: 'Online Store',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "    Management",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Revenue", textAlign: TextAlign.start),
                  ),
                  Row(
                    children: [
                      Text('Total Revenue'),
                      SizedBox(width: 20),
                      Text("Total Order"),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                fromY: 0,
                                toY: 30,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(
                                fromY: 0,
                                toY: 70,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 1:
                                    return Text('Revenue');
                                  case 2:
                                    return Text('Orders');
                                  default:
                                    return Text('');
                                }
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _builditems({required Widget icon, required String label}) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Center(child: icon),
      ),
      SizedBox(height: 8),
      Text(label, style: TextStyle(fontSize: 12)),
    ],
  );
}
