import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  final String id; // Firestore document ID
  final String userId;
  final String carPlate;
  final String carBrand;
  final String carModel;
  final String carYear;
  final String vin;

  // final String? imageUrl;

  CarModel({
    required this.id,
    required this.userId,
    required this.carPlate,
    required this.carBrand,
    required this.carModel,
    required this.carYear,
    required this.vin,
    // this.imageUrl,
  });

  // Chuyển dữ liệu từ Firestore
  factory CarModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return CarModel(
      id: docId,
      userId: data['userId'] ?? '',
      carPlate: data['carPlate'],
      carBrand: data['carBrand'],
      carModel: data['carModel'],
      carYear: data['carYear'],
      vin: data['vin'],
      // imageUrl: data['imageUrl'],
    );
  }

  // Chuyển thành Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'carPlate': carPlate,
      'carBrand': carBrand,
      'carModel': carModel,
      'carYear': carYear,
      'vin': vin,
      // 'imageUrl': imageUrl,
    };
  }

  static Future<void> deleteCar(String carId) async {
    await FirebaseFirestore.instance.collection('cars').doc(carId).delete();
  }
}
