import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String? id;
  final String userId;
  final String serviceId;
  final double amount;
  final String paymentMethod; // e.g., "credit_card", "paypal", "cash"
  final DateTime paymentDate;
  final bool isSuccessful;

  PaymentModel({
    this.id,
    required this.userId,
    required this.serviceId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
    this.isSuccessful = false,
  });

  // Tạo PaymentModel từ dữ liệu Firebase
  factory PaymentModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return PaymentModel(
      id: docId,
      userId: data['userId'] ?? '',
      serviceId: data['serviceId'] ?? '',
      amount: data['amount'] ?? 0.0,
      paymentMethod: data['paymentMethod'] ?? 'cash',
      paymentDate: (data['paymentDate'] as Timestamp).toDate(),
      isSuccessful: data['isSuccessful'] ?? false,
    );
  }

  // Chuyển PaymentModel thành JSON để lưu vào Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'paymentDate': paymentDate,
      'isSuccessful': isSuccessful,
    };
  }
}
