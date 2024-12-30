import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/service_model.dart';
import '../../../repository/service_repo.dart';
import '../../../provider/service_cart_provider.dart';
import '../home.dart';
import '../../widgets/service_card.dart';
import '../infor_car/vehicle.dart';

class SelectServicePage extends StatefulWidget {
  const SelectServicePage({super.key});

  static const String id = 'select_service';

  @override
  _SelectServicePageState createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  final ServiceRepository _serviceRepository = ServiceRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Service'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: StreamBuilder<List<ServiceModel>>(
        stream: _serviceRepository.getServicesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No services available'));
          }

          // Get list of services
          final List<ServiceModel> services = snapshot.data!;

          return Column(
            children: [
              // Expanded ListView displaying services
              Expanded(
                child: ListView.builder( // hiển thị dsach dvu dưới dạng dsach cuộn
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return Consumer<ServiceCartProvider>(
                      builder: (context, cartProvider, child) {
                        return ServiceCard(
                            service: service, // Truyền đối tượng ServiceModel
                            cartProvider: cartProvider);
                      },
                    );
                  },
                ),
              ),
              // Display total selected services and button to navigate to VehicleScreen
              Consumer<ServiceCartProvider>(
                builder: (context, cartProvider, child) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.orangeAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cartProvider.serviceCount} Services',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (cartProvider.serviceCount > 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VehicleScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please add services to the cart first'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text('Go To Cart'),
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
