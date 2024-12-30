// button.dart
import 'package:flutter/material.dart';

class ButtonToggle extends StatelessWidget {
  final bool isUpcomingSelected;
  final bool isPastSelected;
  final VoidCallback onUpcomingTap;
  final VoidCallback onPastTap;

  ButtonToggle({
    required this.isUpcomingSelected,
    required this.isPastSelected,
    required this.onUpcomingTap,
    required this.onPastTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Đặt chiều rộng cho các nút
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onUpcomingTap,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: isUpcomingSelected
                        ? Colors.lightBlueAccent
                        : Colors.grey.shade200,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'UPCOMING',
                    style: TextStyle(
                      color: isUpcomingSelected ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onPastTap,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: isPastSelected
                        ? Colors.lightBlueAccent
                        : Colors.grey.shade200,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'PAST',
                    style: TextStyle(
                      color: isPastSelected ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
