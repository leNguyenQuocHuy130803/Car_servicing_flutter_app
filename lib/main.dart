import 'package:car_servicing/firebase_option.dart';
import 'package:car_servicing/presentation/pages/Home.dart';
import 'package:car_servicing/presentation/pages/checkout.dart';
import 'package:car_servicing/presentation/pages/infor_car/vehicle.dart';
import 'package:car_servicing/presentation/pages/user/EditUserProfile.dart';
import 'package:car_servicing/presentation/pages/auth/Login.dart';
import 'package:car_servicing/presentation/pages/auth/Registation.dart';
import 'package:car_servicing/presentation/pages/settings.dart';
import 'package:car_servicing/presentation/pages/user/UserProfile.dart';
import 'package:car_servicing/provider/service_cart_provider.dart';
import 'package:car_servicing/viewmodels/appointment_vm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //firebase authentication
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServiceCartProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Login.id,
        routes: {
          Home.id: (context) => const Home(),
          // SelectServicePage.id (context) => const SelectServicePage(),
          UserProfile.id: (context) => const UserProfile(),
          EditUserProfile.id: (context) => const EditUserProfile(),
          Settings.id: (context) => const Settings(),
          Login.id: (context) => const Login(),
          Registation.id: (context) => const Registation(),
          VehicleScreen.id: (context) => const VehicleScreen(),
          CheckoutScreen.id: (context) => const CheckoutScreen(),
        },
      ),
    );
  }
}
