import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/Auth_service.dart';
import '../../widgets/bottom_nav_bar.dart';

class CarProfileScreen extends StatefulWidget {
  const CarProfileScreen({super.key});

  @override
  State<CarProfileScreen> createState() => _CarProfileScreenState();
}

class _CarProfileScreenState extends State<CarProfileScreen> {
  String? userName;
  List<Map<String, dynamic>> carList = [];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchCarInfo();
  }

  Future<void> _fetchUserName() async {
    final authService = AuthService();
    final uid = authService.getCurrentUserId();
    if (uid != null) {
      final name = await authService.getUserName(uid);
      setState(() {
        userName = name;
      });
    }
  }

  Future<void> _fetchCarInfo() async {
    final authService = AuthService();
    final uid = authService.getCurrentUserId();
    if (uid != null) {
      final carsSnapshot = await FirebaseFirestore.instance
          .collection('cars')
          .where('userId', isEqualTo: uid)
          .get();
      setState(() {
        carList = carsSnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle'),
        backgroundColor: Colors.blue,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/car.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Wrap Column in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ...carList.map((car) => _buildCarRecord(context, car)).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}

Widget _buildCarRecord(BuildContext context, Map<String, dynamic> car) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Car Details Card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Car Image
                Image.asset(
                  'assets/images/car.png', // Add a car image asset here
                  width: 100,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                // Car Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car['carBrand'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        car['carPlate'],
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      Text(
                        'Car ID: ${car['vin']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
