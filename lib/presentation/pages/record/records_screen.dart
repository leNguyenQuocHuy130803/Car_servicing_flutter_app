import 'package:car_servicing/presentation/pages/checkout.dart';
import 'package:car_servicing/presentation/pages/track_order/track_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/appoinment_model.dart';
import '../../../models/service_model.dart';
import '../../../services/Auth_service.dart';
import '../../../viewmodels/appointment_vm.dart';
import '../../widgets/bottom_nav_bar.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();  // lấy tên và id người dùng
  }

  Future<void> _fetchUserName() async {
    final authService = AuthService();
    final uid = authService.getCurrentUserId(); // Gọi phương thức getCurrentUserId từ AuthService để lấy UID của người dùng hiện tại.
    if (uid != null) {
    //   Kiểm tra xem UID có hợp lệ không.
    // Nếu uid là null, có nghĩa là không có người dùng nào đăng nhập và phương thức dừng tại đây.
      final name = await authService.getUserName(uid); // ấy tên người dùng từ cơ sở dữ liệu Firebase dựa trên UID.
      setState(() {
        userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record'),
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
              // _buildUserGreeting(context, userName),
              const SizedBox(height: 16),
              _buildServiceRecord(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}

Widget _buildServiceRecord(BuildContext context) {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TrackOrder(),
        ),
      );
    },
    child: StreamBuilder<List<AppointmentModel>>( // StreamBuilder sử dụng để lắng nghe các thay đổi của một stream
      // Khi dữ liệu thay đổi, StreamBuilder sẽ tự động gọi lại builder để cập nhật giao diện.
      // getUserAppointments(userId): Gọi phương thức trả về một stream của danh sách AppointmentModel
      stream: Provider.of<AppointmentViewModel>(context)
          .getUserAppointments(userId), // trả về một stream, trong đó phát danh sách các cuộc hẹn của người dùng userId từ nguồn dữ liệu (có thể là Firestore hoặc cơ sở dữ liệu khác).
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {  // ConnectionState.waiting: Đang chờ dữ liệu từ stream.
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Nếu có lỗi xảy ra khi nhận dữ liệu từ stream, hiển thị thông báo lỗi chứa thông tin cụ thể của lỗi (snapshot.error).
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
     // Nếu không có dữ liệu (!snapshot.hasData) hoặc danh sách dữ liệu rỗng (snapshot.data!.isEmpty), hiển thị thông báo
          return const Text('No appointments found');
        } else {
          return ListView.builder(
            shrinkWrap: true, // chỉ định rằng danh sách nên chỉ chiếm không gian vừa đủ với nội dung bên trong, thay vì chiếm toàn bộ chiều cao có sẵn.
            physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa khả năng cuộn của danh sách.
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              // context: Bối cảnh của widget hiện tại.
              // index: Vị trí của item hiện tại trong danh sách.
              final appointment = snapshot.data![index]; // Lấy dữ liệu cuộc hẹn tại vị trí index từ danh sách snapshot.data.
              if (appointment.serviceId == null ||
                  appointment.serviceId!.isEmpty) {
                return const Text('Service ID is missing');
              }
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('services') // Truy cập vào collection "services" trong Firestore.
                    .doc(appointment.serviceId) // Lấy tài liệu (document) có ID là "serviceId" của cuộc hẹn hiện tại.
                    .get(), // // Gọi phương thức get() để lấy tài liệu.
                builder: (context, serviceSnapshot) {
                  if (serviceSnapshot.connectionState ==
                      ConnectionState.waiting) { // người dùng biết rằng ứng dụng đang tải dữ liệu.
                    return const CircularProgressIndicator();
                  } else if (serviceSnapshot.hasError) { // Kiểm tra xem có lỗi xảy ra trong quá trình lấy dữ liệu hay không. Nếu có lỗi, hasError sẽ trả về true, và bạn có thể lấy thông tin lỗi từ serviceSnapshot.error.
                    return Text('Error: ${serviceSnapshot.error}'); // lỗi thì trả về dòng này
                  } else if (!serviceSnapshot.hasData || // neeus ko tìm thấy dịch vụ
                      !serviceSnapshot.data!.exists) {
                    return const Text('Service not found'); // thì tbap
                  } else {
                    final service = ServiceModel.fromFirestore(
                        serviceSnapshot.data!.data() as Map<String, dynamic>,
                        serviceSnapshot.data!.id);
                    if (appointment.carId == null ||
                        appointment.carId!.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      service.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        appointment.status.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Booking ID: ${appointment.id}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Car: Unknown Car',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "DATE",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  appointment.appointmentDate != null
                                      ? "${appointment.appointmentDate!.hour}:${appointment.appointmentDate!.minute}  ${appointment.appointmentDate!.day}, ${appointment.appointmentDate!.month}, ${appointment.appointmentDate!.year}"
                                      : "Date",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        // Action for "Book Again"
                                        Navigator.pushNamed(
                                            context, CheckoutScreen.id);
                                      },
                                      child: const Text("BOOK AGAIN"),
                                    ),
                                    OutlinedButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('appointments')
                                            .doc(appointment.id)
                                            .delete();
                                      },
                                      child: const Text("DELETE",
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('cars')
                          .doc(appointment.carId)
                          .get(),
                      builder: (context, carSnapshot) {
                        if (carSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (carSnapshot.hasError) {
                          return Text('Error: ${carSnapshot.error}');
                        } else if (!carSnapshot.hasData ||
                            !carSnapshot.data!.exists) {
                          return const Text('Car not found');
                        } else {
                          final carData =
                              carSnapshot.data!.data() as Map<String, dynamic>;
                          final carBrand = carData['carBrand'] ?? 'Unknown Car';
                          final carPlate = carData['carPlate'] ?? 'Unknown Car';
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          service.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            appointment.status.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Booking ID: ${appointment.id}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Car: $carBrand - $carPlate',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "DATE",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      appointment.appointmentDate != null
                                          ? "${appointment.appointmentDate!.hour}:${appointment.appointmentDate!.minute}  ${appointment.appointmentDate!.day}, ${appointment.appointmentDate!.month}, ${appointment.appointmentDate!.year}"
                                          : "Date",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            // Action for "Book Again"
                                          },
                                          child: const Text("BOOK AGAIN"),
                                        ),
                                        OutlinedButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('appointments')
                                                .doc(appointment.id)
                                                .delete();
                                          },
                                          child: const Text("DELETE",
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              );
            },
          );
        }
      },
    ),
  );
}
