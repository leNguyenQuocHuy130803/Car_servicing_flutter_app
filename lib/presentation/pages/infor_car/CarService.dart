import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_servicing/models/car_model.dart';

class CarService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lấy thông tin xe của người dùng từ Firestore theo email
  Future<List<CarModel>> getUserCars() async {
    try {
      // Lấy email của người dùng hiện tại
      String userEmail = FirebaseAuth.instance.currentUser!.email!;

      // Truy vấn thông tin xe của người dùng từ collection 'cars'
      final carCollection = _firestore.collection('cars');
      final carDocs = await carCollection
          .where('userEmail', isEqualTo: userEmail) // Giả sử mỗi xe có một trường 'userEmail'
          .get();

      // Duyệt qua các tài liệu và chuyển đổi chúng thành danh sách CarModel
      List<CarModel> cars = carDocs.docs.map((doc) {
        return CarModel.fromFirestore(doc.data(), doc.id);
      }).toList();

      return cars;
    } catch (e) {
      print("Error getting user cars: $e");
      return [];
    }
  }
}
