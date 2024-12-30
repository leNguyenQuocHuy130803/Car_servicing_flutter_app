class ServiceModel {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;

  ServiceModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.price});

  // Factory method to create a ServiceModel from Firebase data
  factory ServiceModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return ServiceModel(
      id: docId,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
    );
  }
}
