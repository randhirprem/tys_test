import 'package:flutter/material.dart';
import 'mysql_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MySQLService _mysqlService = MySQLService();
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Fetch data from the service
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final fetchedData = await _mysqlService.getUsers();
    setState(() {
      _data = fetchedData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MySQL Data'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _data.isEmpty
              ? const Center(child: Text('No data available.'))
              : ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_data[index]['username']
                          .toString()), // Replace with your column name
                    );
                  },
                ),
    );
  }
}
