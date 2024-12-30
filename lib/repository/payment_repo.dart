import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/payment_model.dart';

class PaymentRepository {
  final CollectionReference _payments =
      FirebaseFirestore.instance.collection('payments');

  // Xử lý thanh toán mới
  Future<void> processPayment(PaymentModel payment) async {
    await _payments.add(payment.toFirestore());
  }

  // Lấy danh sách thanh toán của người dùng
  Stream<List<PaymentModel>> getUserPayments(String userId) {
    return _payments.where('userId', isEqualTo: userId).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => PaymentModel.fromFirestore(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }
}
