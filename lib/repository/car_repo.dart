import 'package:car_servicing/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarRepository {
  final CollectionReference carsCollection =
      FirebaseFirestore.instance.collection('cars');

// Lấy một car dựa trên id
  Stream<CarModel?> getCarById(String? carId) {
    if (carId == null || carId.isEmpty) {
      throw Exception('Invalid car ID');
    }

    return carsCollection.doc(carId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return CarModel.fromFirestore(
          snapshot.data() as Map<String, dynamic>,
          snapshot.id,
        );
      } else {
        throw Exception('Car not found');
      }
    });
  }
}
