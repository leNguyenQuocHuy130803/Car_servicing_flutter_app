import 'package:car_servicing/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceCartProvider extends ChangeNotifier {
  int _serviceCount = 0;

  // int get serviceCount => _serviceCount;

  // Lưu các dịch vụ cùng số lượng
  final Map<ServiceModel, int> _serviceCounts = {};

  // Lấy danh sách các dịch vụ trong giỏ hàng
  Map<ServiceModel, int> get cartItems => _serviceCounts;

  // Đếm tổng số dịch vụ trong giỏ hàng
  int get serviceCount =>
      _serviceCounts.values.fold(0, (sum, count) => sum + count);

  // Thêm dịch vụ vào giỏ hàng
  void addService(ServiceModel service) {
    if (_serviceCounts.containsKey(service)) {
      _serviceCounts[service] = _serviceCounts[service]! + 1;
    } else {
      _serviceCounts[service] = 1;
    }
    notifyListeners();
  }

  // Method to reset service count
  void resetServiceCount() {
    _serviceCount = 0;
    notifyListeners();
  }

// Đặt lại giỏ hàng
  void resetCart() {
    _serviceCounts.clear();
    notifyListeners();
  }

  // Cập nhật serviceCount
  void updateServiceCount(int count) {
    _serviceCount = count;
    notifyListeners();
  }

  // Lấy số lượng của một dịch vụ
  int getServiceCount(ServiceModel service) {
    return _serviceCounts[service] ?? 0;
  }

  // Xóa một dịch vụ khỏi giỏ hàng
  void removeService(ServiceModel service) {
    if (_serviceCounts.containsKey(service)) {
      if (_serviceCounts[service]! > 1) {
        _serviceCounts[service] = _serviceCounts[service]! - 1;
      } else {
        _serviceCounts.remove(service);
      }
      notifyListeners();
    }
// Xóa tất cả các dịch vụ khỏi giỏ hàng
    void clearCart() {
      _serviceCounts.clear();
      notifyListeners();
    }
  }
}
