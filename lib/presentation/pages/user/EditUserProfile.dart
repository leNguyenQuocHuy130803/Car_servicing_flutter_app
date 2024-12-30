import 'package:car_servicing/constants.dart';
import 'package:car_servicing/presentation/pages/user/UserProfile.dart';
import 'package:car_servicing/presentation/widgets/button_widget.dart';
import 'package:car_servicing/presentation/widgets/dropdown.dart';
import 'package:car_servicing/presentation/widgets/textfield_widget.dart';
import 'package:car_servicing/viewmodels/Auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});
  static const String id = 'edit_user_profile_screen';

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? _user;

  final validation = UserAuthenticationViewmodel();
  
  final  _name = TextEditingController();
  final  _email = TextEditingController();
  final  _phone = TextEditingController();
  final  _address = TextEditingController();
  String? _oldAddress;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot userDoc =
        await _firestore.collection('Users').doc(_user!.uid).get();
    setState(() {
      _name.text = userDoc['name'];
      _email.text = userDoc['email'];
      _phone.text = userDoc['phone'];
      _address.text = userDoc['address'];
      _oldAddress = userDoc['address'];
    });
  }

  Future<void> _updateUserData() async {
    await _firestore.collection('Users').doc(_user!.uid).update({
      'name':  _name.text,
      'email':  _email.text,
      'phone':  _phone.text,
      'address': _address.text.isEmpty ? _oldAddress : _address.text,
    });
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
              Navigator.pushNamed(context, UserProfile.id);
            },
          ),
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/dao.jpg'),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: "Name",
                    controller: _name,
                     hint: '',
                    errorText: validation.name.error,
                    onChanged: (value){
                        validation.validateName(value);
                        setState(() {});
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: "Email",
                    controller: _email,
                     hint: '',
                    errorText: validation.email.error,
                    onChanged: (value){
                        validation.validateEmail(value);
                        setState(() {});
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: "Phone",
                    controller: _phone
                    , hint: '',
                    errorText: validation.phone.error,
                    inputType: TextInputType.phone,
                    onChanged: (value){
                        validation.validatePhone(value);
                        setState(() {});
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomDropdownField(
                      label: "Address",
                      hint: _address.text,
                      value: validation.address.value,
                      items: validation.cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      controller: _address,
                    ),
                  const SizedBox(height: 24),
                  CustomButton(
                    label: "SAVE",
                    onPressed:() async {
                            await _updateUserData();
                            Navigator.pushNamed(context, UserProfile.id);
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
}
