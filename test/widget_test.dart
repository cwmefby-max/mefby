import 'package:flutter/material.dart';

void main() {
  runApp(const BMWApp());
}

class BMWApp extends StatelessWidget {
  const BMWApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMW iX Status',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const VehicleStatusPage(),
    );
  }
}

class VehicleStatusPage extends StatelessWidget {
  const VehicleStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 2,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('iX xDrive50'),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12),
          Icon(Icons.directions_car),
          SizedBox(width: 12),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'ALL GOOD',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/3/3e/BMW_iX.jpg',
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              const Text(
                'Updated from vehicle on 9/20/2021 01:59 PM',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              const Text(
                'State of Charge 100% / 556 km',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.lock_open, size: 32, color: Colors.white),
                  Icon(Icons.lightbulb_outline, size: 32, color: Colors.white),
                  Icon(Icons.volume_up, size: 32, color: Colors.white),
                  Icon(Icons.ac_unit, size: 32, color: Colors.white),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.grey[900],
                child: const ListTile(
                  leading: Icon(Icons.location_on, color: Colors.white),
                  title: Text('Vehicle Finder', style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    'Karl-Dompert-Straße 7, 84130 Dingolfing',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.grey[900],
                child: const ListTile(
                  leading: Icon(Icons.videocam, color: Colors.white),
                  title: Text('Remote Cameras', style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    'Remote 3D and Remote Inside View',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
