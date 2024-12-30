import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class AddCarViewModel {
  File? selectedImage;

  // Chọn ảnh từ thư viện
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }
  }

  // Tải ảnh lên Firebase Storage và trả về URL
  Future<String> uploadImageToStorage() async {
    if (selectedImage == null) throw Exception('No image selected');
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child('cars/$fileName.jpg');
    final uploadTask = await ref.putFile(selectedImage!);
    return await uploadTask.ref.getDownloadURL();
  }

  // Lưu thông tin xe vào Firestore
  // Future<void> saveCar(CarModel car) async {
  //   await FirebaseFirestore.instance.collection('cars').add(car.toMap());
  // }
  final CollectionReference carsCollection =
      FirebaseFirestore.instance.collection('cars'); // Tham chiếu bộ sưu tập

// Lưu thông tin xe vào Firestore
// Future<void> saveCar(CarModel car) async {
//   await carsCollection.add(car.toMap());
// }
}
