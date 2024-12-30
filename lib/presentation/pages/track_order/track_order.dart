import 'package:flutter/material.dart';
import '../../widgets/body_servicing.dart';

class TrackOrder extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ServiceCard2(), //  widget này nằm trong file body_servicing.dart
            OrderTimeline(),
          ],
        ),
      ),
    );
  }
}

// Widget hiển thị tiến trình theo dõi đơn hàng (timeline)
class OrderTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Item 1 - New Parts Arrived
        Row(
          children: [
            Column(
              children: [
                Icon(Icons.check_circle, color: Colors.blue),
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'New Parts Arrived',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '21st Sept, 2021 | 15:02',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        // Item 2 - Installation In Progress
        Row(
          children: [
            Column(
              children: [
                Icon(Icons.circle, color: Colors.blue),
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Installation',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'In Progress',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        // Item 3 - Final Inspection
        Row(
          children: [
            Column(
              children: [
                Icon(Icons.circle_outlined, color: Colors.blue),
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Final Inspection',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'In Progress',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        // Item 4 - Ready for Drop
        Row(
          children: [
            Column(
              children: [
                Icon(Icons.circle_outlined, color: Colors.blue),
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Ready for Drop',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'In Progress',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        // Item 5 - Dropped
        Row(
          children: [
            Icon(Icons.circle_outlined, color: Colors.blue),
            const SizedBox(width: 8),
            const Text('Dropped'),
          ],
        ),
      ],
    );
  }
}
