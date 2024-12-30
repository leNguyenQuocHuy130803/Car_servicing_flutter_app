import 'package:car_servicing/extension/string_ext.dart';
import 'package:car_servicing/models/auth_validation_model.dart';
import 'package:car_servicing/presentation/pages/Home.dart';
import 'package:car_servicing/presentation/pages/auth/Login.dart';
import 'package:car_servicing/presentation/pages/infor_car/add_car_screen.dart';
import 'package:car_servicing/presentation/pages/user/UserProfile.dart';
import 'package:car_servicing/presentation/widgets/snackbarMessage.dart';
import 'package:car_servicing/services/Auth_service.dart';
import 'package:flutter/material.dart';

class UserAuthenticationViewmodel {
  ValidationModel name = ValidationModel(value: null, error: null);
  ValidationModel email = ValidationModel(value: null, error: null);
  ValidationModel password = ValidationModel(value: null, error: null);
  ValidationModel rePassword = ValidationModel(value: null, error: null);
  ValidationModel phone = ValidationModel(value: null, error: null);
  ValidationModel address = ValidationModel(value: null, error: null);
  final _authService = AuthService();
  final TextEditingController addressController = TextEditingController();

  final List<String> cities = [
    "Hanoi",
    "Ho Chi Minh City",
    "Da Nang",
    "Hai Phong",
    "Can Tho",
    "Gia Lai",
    "Quang Nam",
    "Hue"
  ];

  bool get isValidLogin =>
      email.value?.isValidEmail == true &&
      password.value?.isValidPassword == true;

  bool get isValidRegister =>
      name.value?.isValidName == true &&
      email.value?.isValidEmail == true &&
      password.value?.isValidPassword == true &&
      password.value == rePassword.value &&
      phone.value?.isValidPhoneNumber == true &&
      address.value != null;

  bool get isValidEditProfile =>
      name.value?.isValidName == true &&
      email.value?.isValidEmail == true &&
      phone.value?.isValidPhoneNumber == true;

  validateName(String value) {
    if (value.isValidName) {
      name = ValidationModel(value: value, error: null);
    } else {
      name = ValidationModel(
          value: value, error: "Name contains only letters and spaces");
    }
  }

  validateEmail(String value) {
    if (value.isValidEmail) {
      email = ValidationModel(value: value, error: null);
    } else {
      email =
          ValidationModel(value: value, error: "Please ENTER a valid email");
    }
  }

  validatePassword(String value) {
    if (value.isValidPassword) {
      password = ValidationModel(value: value, error: null);
    } else {
      password = ValidationModel(
          value: value, error: "Password must be 6-16 characters.");
    }
  }

  validateRePassword(String value) {
    if (value == password.value) {
      rePassword = ValidationModel(value: value, error: null);
    } else {
      rePassword =
          ValidationModel(value: value, error: "Passwords do not match");
    }
  }

  validatePhone(String value) {
    if (value.isValidPhoneNumber) {
      phone = ValidationModel(value: value, error: null);
    } else {
      phone = ValidationModel(
          value: value, error: "Phone contains exactly 10 digits");
    }
  }

  validateAddress(String value) {
    if (cities.contains(value)) {
      address = ValidationModel(value: value, error: null);
    } else {
      address =
          ValidationModel(value: value, error: "Please select a valid city");
    }
  }

  Future<void> login(BuildContext context) async {
    // try {
    final user = await _authService.loginUserWithEmailAndPassword(
        email.value!, password.value!, context);
    if (user != null) {
      // Show success snackbar
      snackbarMessage(
        message: "Login successful!",
        isError: false,
        context: context,
      ).show();
      // Navigate to UserProfile page
      goToHome(context);
    }
  }

  Future<void> register(BuildContext context) async {
    final user = await _authService.createUserWithEmailAndPassword(email.value!,
        password.value!, name.value!, phone.value!, address.value!, context);
    if (user != null) {
      // Show success snackbar
      snackbarMessage(
              message: "Registration user successful!",
              isError: false,
              context: context)
          .show();
      // Navigate to Add Car page
      goToAddCar(context);
    }
  }

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );

  goToUserProfile(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfile()),
      );

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );

  goToAddCar(BuildContext context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const AddCarScreen()));
}
