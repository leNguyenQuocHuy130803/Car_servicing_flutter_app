import 'package:car_servicing/presentation/pages/infor_car/vehicle.dart';
import 'package:car_servicing/presentation/pages/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/appoinment_model.dart';
import '../../repository/appointment_repo.dart';
import '../widgets/date_time_custom.dart';
import '../../provider/service_cart_provider.dart';
import '../../models/car_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const String id = 'checkout';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isDateTimeSelected = false; // xdinh xem đã chọn ngày giờ chưa
  DateTime? selectedDateTime;  // đã chọn thì lưu vào selec
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  List<CarModel> userCars = [];
  CarModel? selectedCar;


  @override
  void initState() {
    super.initState();
    _fetchUserCars();
  }

  Future<void> _fetchUserCars() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final carsSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .where('userId', isEqualTo: uid)
        .get();
    setState(() {
      userCars = carsSnapshot.docs
          .map((doc) => CarModel.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  void _onDateSelected(DateTime dateTime) {
    final now = DateTime.now();
    final bool isValidTime = dateTime.isAfter(now) &&
        (dateTime.hour > 8 || (dateTime.hour == 8 && dateTime.minute >= 0)) &&
        (dateTime.hour < 17 ||
            (dateTime.hour == 17 &&
                dateTime.minute == 0)); // Ensure time between 08:00 and 17:00

    setState(() {
      isDateTimeSelected = isValidTime;
      if (isValidTime) {
        selectedDateTime = dateTime;
      }
    });
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _proceedToPayment() async {
    if (selectedDateTime != null) {  // Chỉ cần kiểm tra selectedDateTime
      final cartProvider = Provider.of<ServiceCartProvider>(context, listen: false);
      final firstServiceId = cartProvider.cartItems.keys.first.id; // Lấy ID dịch vụ đầu tiên

      // Tạo đối tượng AppointmentModel (không cần carId)
      final appointment = AppointmentModel(
        appointmentDate: selectedDateTime,
        userId: userId,
        serviceId: firstServiceId,
        carId: "",
      );

      // Lưu lịch hẹn vào Firebase
      await _appointmentRepository.bookAppointment(
        appointment,
        userId,
        firstServiceId,
        "", // Truyền carId rỗng nếu không cần
      );

      // Chuyển đến trang PaymentPage
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PaymentPage(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ServiceCartProvider>(context);
    final totalPrice = cartProvider.cartItems.entries
        .map((entry) => entry.key.price * entry.value)
        .reduce((value, element) => value + element);
    final serviceTitles =
        cartProvider.cartItems.keys.map((service) => service.title).join(', ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          // Back button
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, VehicleScreen.id);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'When do you want the service?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date & Time',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: DateTimePickerCustom(
                      onDateSelected: _onDateSelected,
                    ),
                  ),
                  const SizedBox(height: 18),


                ],
              ),
            ),
            Text(
              'Services: $serviceTitles',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total: ${(totalPrice).toStringAsFixed(2)} VND',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // onPressed: isDateTimeSelected && selectedCar != null
              onPressed: isDateTimeSelected
                  ? _proceedToPayment
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              child: const Text('PROCEED'),
            ),
          ],
        ),
      ),
    );
  }
}
