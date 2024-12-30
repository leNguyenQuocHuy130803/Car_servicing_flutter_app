import 'package:flutter/material.dart';
import 'package:car_servicing/presentation/pages/AboutUs.dart';
import 'package:car_servicing/presentation/pages/hotline.dart';
import 'package:car_servicing/constants.dart';
import 'package:car_servicing/presentation/widgets/button_widget.dart';
import 'package:car_servicing/services/auth_service.dart';
import 'package:car_servicing/viewmodels/Auth_viewmodel.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static const String id = 'setting_screen';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final validation = UserAuthenticationViewmodel();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
          ),
          title: const Text('Settings'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(
                children: [
                  buildFieldRow(
                    icon: Icons.info,
                    text: "AboutUs",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUsPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildFieldRow(
                    icon: Icons.phone,
                    text: "Hotline",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HotlineServicePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    label: "Sign Out",
                    onPressed: () async {
                      await _auth.signout(context);
                      validation.goToHome(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFieldRow({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
        padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
    border: Border(
    bottom: BorderSide(
    color: kTextColor,
    width: 1,
    ),
    ),
    ),
    width: double.maxFinite,
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    text,
                    style: const TextStyle(color: kTextColor, fontSize: 16),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
    );
  }
}