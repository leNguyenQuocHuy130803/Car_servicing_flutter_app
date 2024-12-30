import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? id;
  String? serviceId;
  String? userId;
  String? carId; // Tham chiếu đến ID của xe
  DateTime? appointmentDate;
  String status; // e.g., "confirmed", "ongoing", "completed"

  AppointmentModel({
    this.id,
    this.serviceId,
    this.userId,
    this.carId,
    this.appointmentDate,
    this.status = "confirmed",
  });

  // Tạo AppointmentModel từ dữ liệu Firebase
  factory AppointmentModel.fromFirestore(
      Map<String, dynamic> data, String docId) {
    return AppointmentModel(
      id: docId,
      serviceId: data['serviceId'] ?? '',
      userId: data['userId'] ?? '',
      carId: data['carId'] ?? '',
      appointmentDate: (data['appointmentDate'] as Timestamp).toDate(),
      status: data['status'] ?? 'confirmed',
    );
  }

  // Chuyển AppointmentModel thành JSON để lưu vào Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'serviceId': serviceId,
      'userId': userId,
      'carId': carId,
      'appointmentDate': appointmentDate,
      'status': status,
    };
  }
}
