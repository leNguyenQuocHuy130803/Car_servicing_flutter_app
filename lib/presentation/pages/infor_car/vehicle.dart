import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/service_model.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../../provider/service_cart_provider.dart';
import '../checkout.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  static const String id = 'vehicle_screeen';

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  late ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ServiceCartProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FA),
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.blue,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/car.png'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: cartProvider.cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty. Add services to your cart!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final service =
                            cartProvider.cartItems.keys.elementAt(index);
                        final count = cartProvider.cartItems[service]!;
                        return ListTile(
                          leading: Image.asset(service.imageUrl,
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(service.title),
                          subtitle: Text(
                              '${service.price} VND x $count = ${(service.price * count).toStringAsFixed(2)} VND'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartProvider.removeService(service);
                            },
                          ),
                        );
                      },
                    ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 32,
            ),
            ElevatedButton(
              onPressed: cartProvider.cartItems.isEmpty
                  ? null // Vô hiệu hóa nút nếu giỏ hàng trống
                  : () {
                      // Điều hướng đến trang Checkout
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckoutScreen()),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: cartProvider.cartItems.isEmpty
                    ? Colors.grey // Màu nút khi vô hiệu hóa
                    : Theme.of(context).canvasColor,
              ),
              child: const Text(
                'CHECKOUT',
                style: TextStyle(
                  fontSize: 22, // Tăng kích thước chữ
                  fontWeight: FontWeight.bold, // In đậm chữ
                ),
              ),
            ),
            if (cartProvider.cartItems.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Please add services to cart to continue.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
