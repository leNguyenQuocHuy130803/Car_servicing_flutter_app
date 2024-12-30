import 'package:flutter/material.dart';
import 'package:car_servicing/models/service_model.dart';
import '../../provider/service_cart_provider.dart';
import '../pages/services/basic_service.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel service;
  final ServiceCartProvider cartProvider;

  ServiceCard({super.key, required this.service, required this.cartProvider});

  static const String id = 'service_card';

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BasicServicePage(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hiển thị hình ảnh dịch vụ
              Image.asset(
                widget.service.imageUrl, // Sử dụng widget.service
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 100,
                ),
              ),
              const SizedBox(width: 16),
              // Thông tin chi tiết dịch vụ
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.service.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.service.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.service.price} VND',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              // Nút thêm vào giỏ hàng
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  widget.cartProvider.addService(widget.service);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.service.title} added to cart'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.black87,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                label: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
