import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/appoinment_model.dart';
import '../repository/appointment_repo.dart';

class AppointmentViewModel extends ChangeNotifier {
  final _repository = AppointmentRepository();

  // Đặt lịch hẹn
  Future<void> bookAppointment(AppointmentModel appointment, String userId,
      String carId, String serviceId) async {
    appointment.userId = userId;
    appointment.carId = carId;
    appointment.serviceId = serviceId;
    await _repository.bookAppointment(appointment, userId,serviceId,carId);
    notifyListeners();
  }

  // Lấy danh sách lịch hẹn của người dùng
  Stream<List<AppointmentModel>> getUserAppointments(String userId) {
    return _repository.getUserAppointments(userId);
  }

  // Cập nhật trạng thái lịch hẹn
  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    await _repository.updateAppointmentStatus(appointmentId, status);
    notifyListeners();
  }

  // Huỷ lịch hen
  Future<void> cancelAppointment(String appointmentId) async {
    final docRef = FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId);
    await docRef.update({'status': 'cancelled'});
  }
}
