import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/service_model.dart';

class ServiceRepository {
  final CollectionReference servicesCollection =
      FirebaseFirestore.instance.collection('services');

  // Lấy danh sách dịch vụ từ Firestore
  Stream<List<ServiceModel>> getServicesStream() {
    return servicesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

// Lấy một dịch vụ dựa trên id
  Stream<ServiceModel?> getServiceById(String? serviceId) {
    if (serviceId == null || serviceId.isEmpty) {
      throw Exception('Invalid service ID');
    }

    return servicesCollection.doc(serviceId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return ServiceModel.fromFirestore(
          snapshot.data() as Map<String, dynamic>,
          snapshot.id,
        );
      } else {
        throw Exception('Service not found');
      }
    });
  }
}
