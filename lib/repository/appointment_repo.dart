import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appoinment_model.dart';

class AppointmentRepository {
  final CollectionReference _appointments =
      FirebaseFirestore.instance.collection('appointments');

  // Thêm lịch hẹn mới
  Future<void> bookAppointment(AppointmentModel appointment, String userId, String serviceId, String carId) async {
    await _appointments.doc(appointment.id).set(appointment.toFirestore());
  }

  // Lấy danh sách lịch hẹn của người dùng
  Stream<List<AppointmentModel>> getUserAppointments(String userId) {
    return _appointments.where('userId', isEqualTo: userId).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => AppointmentModel.fromFirestore(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  // Cập nhật trạng thái lịch hẹn
  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    await _appointments.doc(appointmentId).update({'status': status});
  }
}
