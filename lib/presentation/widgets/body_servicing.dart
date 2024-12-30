import 'package:flutter/material.dart';

class ServiceCard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Giới hạn chiều cao của Card khung trắng bao trùm
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2, // Giá trị bóng đổ dưới khung
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Căn chỉnh tất cả sang trái
            children: [
              // Phần chứa nội dung chính
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phần bên trái chứa thông tin service
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic services',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Booking ID: 123456789',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'General Motors',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Icon(Icons.star_border,
                                color: Colors.amber, size: 20),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '9th Jan 2024, Monday',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Phần bên phải chứa hình ảnh ô tô
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/car.png', // Đường dẫn đến hình ảnh
                          height: 100, // Chiều cao của hình ảnh
                          width: 100, // Chiều rộng của hình ảnh
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Pick-up Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '9:00-9:30 am',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Thêm SizedBox để tạo khoảng cách trước khi thêm phần "Estimated Completion"
              SizedBox(height: 16),
              // Phần Estimated Completion được đưa vào Row để hiển thị trên cùng một dòng
              Row(
                children: [
                  Text(
                    'Estimated Completion:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 5), // Khoảng cách giữa hai phần text
                  Text(
                    'Tomorrow, 12:30pm',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
