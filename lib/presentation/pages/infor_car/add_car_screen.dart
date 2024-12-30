import 'package:car_servicing/models/service_model.dart';
import 'package:car_servicing/presentation/pages/Home.dart';
import 'package:car_servicing/services/Auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../../models/car_model.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  static const String id = 'car_register';

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  late ServiceModel serviceModel;
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final _focusNodes =
      List.generate(5, (_) => FocusNode()); // FocusNode cho từng TextField

  // Controllers
  final TextEditingController _carPlateController = TextEditingController();
  final TextEditingController _carBrandController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _carYearController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();
  final _auth = AuthService();

  bool _isFormValid = false; // Theo dõi trạng thái hợp lệ của form

  @override
  void initState() {
    super.initState();
    // Lắng nghe thay đổi trên từng TextField để cập nhật nút SAVE
    _carPlateController.addListener(_updateFormValidity);
    _carBrandController.addListener(_updateFormValidity);
    _carModelController.addListener(_updateFormValidity);
    _carYearController.addListener(_updateFormValidity);
    _vinController.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isFormValid = isValid;
    });
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Tạo collection Firestore
        final carsCollection = FirebaseFirestore.instance.collection('cars');

        // Upload hình ảnh nếu có
        // String? imageUrl;
        if (_image != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('car_images')
              .child('${_carPlateController.text}.jpg');
          await storageRef.putFile(_image!);
          // imageUrl = await storageRef.getDownloadURL();
        }

        // Tạo đối tượng CarModel
        final car = CarModel(
          id: '',
          userId: _auth.getCurrentUserId().toString(),
          carPlate: _carPlateController.text.trim(),
          carBrand: _carBrandController.text.trim(),
          carModel: _carModelController.text.trim(),
          carYear: _carYearController.text.trim(),
          vin: _vinController.text.trim(),
          // imageUrl: imageUrl,
        );

        // Lưu vào Firestore
        final docRef = await carsCollection.add(car.toMap());

        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Car added successfully with ID: ${docRef.id}')),
        );
        // Điều hướng đến trang Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        // Xóa form sau khi lưu
        _formKey.currentState?.reset();
        setState(() {
          _image = null; // Xóa ảnh đã chọn
        });
      } catch (error) {
        // Hiển thị lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save car: $error')),
        );
      }
    } else {
      print("Form is invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Register'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // Hiển thị lỗi tự động
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20),
              CustomTextField(
                label: 'Car Plate',
                controller: _carPlateController,
                focusNode: _focusNodes[0],
                nextFocusNode: _focusNodes[1],
                hintText: 'Enter Car Plate',
              ),
              CustomTextField(
                label: 'Car Brand Name',
                controller: _carBrandController,
                focusNode: _focusNodes[1],
                nextFocusNode: _focusNodes[2],
                hintText: 'Enter Car Brand Name',
              ),
              CustomTextField(
                label: 'Car Model',
                controller: _carModelController,
                focusNode: _focusNodes[2],
                nextFocusNode: _focusNodes[3],
                hintText: 'Enter Car Model',
              ),
              CustomTextField(
                label: 'Car Manufacture Year',
                controller: _carYearController,
                focusNode: _focusNodes[3],
                nextFocusNode: _focusNodes[4],
                hintText: 'Enter Car Manufacture Year',
              ),
              CustomTextField(
                label: 'VIN (Vehicle Identification Number)',
                controller: _vinController,
                focusNode: _focusNodes[4],
                hintText: 'Enter VIN',
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isFormValid ? _saveForm : null,
                    // Vô hiệu hóa nút nếu form không hợp lệ
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid ? Colors.blue : Colors.grey,
                      // Nổi bật nút khi hợp lệ
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Hủy FocusNodes và Controllers để tránh rò rỉ bộ nhớ
    _focusNodes.forEach((node) => node.dispose());
    _carPlateController.dispose();
    _carBrandController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _vinController.dispose();
    super.dispose();
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  CustomTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
            ),
            textInputAction: nextFocusNode != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: (_) {
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
