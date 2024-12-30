import 'package:car_servicing/constants.dart';
import 'package:car_servicing/presentation/pages/auth/Login.dart';
import 'package:car_servicing/presentation/pages/user/EditUserProfile.dart';
import 'package:car_servicing/presentation/widgets/button_widget.dart';
import 'package:car_servicing/services/Auth_service.dart';
import 'package:car_servicing/viewmodels/Auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});
  static const String id = 'user_profile_screen';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _auth = AuthService();
  final validation = UserAuthenticationViewmodel();
  User? _user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    userData = await _auth.getUserData(_user!.uid, context);
    setState(() {});
  }

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
              // print("click arrow back");
            },
          ),
          title: const Text('Profile'),
        ),
        body: _user == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Please Login to view your profile",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 120,
                      child: CustomButton(
                        label: "LOGIN",
                        onPressed: () {
                          Navigator.pushNamed(context, Login.id);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : userData == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('images/dao.jpg'),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              userData!['name'] ?? '',
                              style: const TextStyle(
                                fontFamily: '',
                                fontSize: 24,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                              width: 160,
                              child: Divider(color: kTextColor),
                            ),
                            const SizedBox(height: 16),
                            buildInfoCard(icon: Icons.email, text: userData!['email'] ?? ''),
                            const SizedBox(height: 16),
                            buildInfoCard(icon: Icons.phone, text: userData!['phone'] ?? ''),
                            const SizedBox(height: 16),
                            buildInfoCard(icon: Icons.house, text: userData!['address'] ?? ''),
                            const SizedBox(height: 16),
                            CustomButton(
                              label: "EDIT PROFILE",
                              onPressed: () {
                                Navigator.pushNamed(context, EditUserProfile.id);
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              label: "Sign Out",
                              onPressed: () async {
                                await _auth.signout(context);
                                validation.goToLogin(context);
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget buildInfoCard({required IconData icon, required String text}) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(icon, size: 24, color: Colors.black),
          title: Text(
            text,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: const TextStyle(
              color: kTextColor,
              fontFamily: 'Arial',
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}

