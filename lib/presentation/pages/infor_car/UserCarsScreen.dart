import 'package:flutter/material.dart';
import 'package:car_servicing/models/car_model.dart';
import 'package:car_servicing/presentation/pages/infor_car/CarService.dart';

class UserCarsScreen extends StatefulWidget {
  const UserCarsScreen({Key? key}) : super(key: key);

  @override
  _UserCarsScreenState createState() => _UserCarsScreenState();
}

class _UserCarsScreenState extends State<UserCarsScreen> {
  late Future<List<CarModel>> _userCars;

  @override
  void initState() {
    super.initState();
    _userCars = CarService().getUserCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cars'),
      ),
      body: FutureBuilder<List<CarModel>>(
        future: _userCars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cars found.'));
          } else {
            // Nếu có xe, hiển thị danh sách các xe
            var cars = snapshot.data!;
            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                var car = cars[index];
                return ListTile(
                  title: Text(car.carBrand),
                  subtitle: Text(car.carPlate),
                  onTap: () {
                    // Xử lý khi người dùng nhấn vào một chiếc xe
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarDetailScreen(car: car),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CarDetailScreen extends StatelessWidget {
  final CarModel car;
  const CarDetailScreen({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.carPlate),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Car Plate: ${car.carPlate}', style: TextStyle(fontSize: 18)),
            Text('Car Brand: ${car.carBrand}', style: TextStyle(fontSize: 18)),
            Text('Car Model: ${car.carModel}', style: TextStyle(fontSize: 18)),
            Text('Car Year: ${car.carYear}', style: TextStyle(fontSize: 18)),
            Text('VIN: ${car.vin}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
