import 'package:car_servicing/presentation/pages/infor_car/add_car_screen.dart';
import 'package:car_servicing/presentation/pages/services/select_service.dart';
import 'package:car_servicing/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:car_servicing/services/Auth_service.dart';

import 'infor_car/car_profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const String id = 'home';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<Home> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Vô hiệu hóa nút Back (←)
        backgroundColor: Colors.blue, // Màu nền xanh
        elevation: 0, // Loại bỏ đổ bóng
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn đều hai bên
          children: [
            // Text 'Hello User'
            Text(
              'Hello ${userName ?? 'User'}',
              style: const TextStyle(
                fontSize: 20,
                // color: Colors.white, // Màu chữ trắng
                fontWeight: FontWeight.bold, // Đậm chữ
              ),
            ),
            // Avatar có điều hướng
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CarProfileScreen(), // Điều hướng đến CarProfileScreen
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage:
                    AssetImage('assets/images/car.png'), // Đường dẫn ảnh
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap Column in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchBar(),
              _buildServiceBanner(),
              _buildServiceSelectionGrid(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for a car service',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildServiceBanner() {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset('assets/images/banner.png',
          fit: BoxFit.cover), // Replace with actual banner image
    );
  }

  Widget _buildServiceSelectionGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GridView.count(
        shrinkWrap: true,
        // Enable GridView to take only necessary space
        physics: const NeverScrollableScrollPhysics(),
        // Disable GridView's scroll
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: [
          _buildServiceIcon(context, 'Car Service', Icons.car_repair),
          _buildAddCarIcon(context), // Thêm nút Add Car
          _buildServiceIcon(context, 'Tyres & Wheel Care', Icons.settings),
          _buildServiceIcon(context, 'Denting & Painting', Icons.brush),
          _buildServiceIcon(context, 'AC Service & Repair', Icons.ac_unit),
          _buildServiceIcon(context, 'Car Cleaning', Icons.cleaning_services),

        ],
      ),
    );
  }

  // add car
  Widget _buildAddCarIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddCarScreen()),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_circle, size: 36, color: Colors.blue),
          const SizedBox(height: 8),
          Text('Add Car', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(BuildContext context, String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectServicePage()),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 36, color: Colors.blue),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
