import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: selectedIndex == 0 ? Colors.blue : Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car, color: selectedIndex == 1 ? Colors.blue : Colors.grey),
          label: 'Vehicles',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt, color: selectedIndex == 2 ? Colors.blue : Colors.grey),
          label: 'Records',
        ),
      ],
    );
  }
}
