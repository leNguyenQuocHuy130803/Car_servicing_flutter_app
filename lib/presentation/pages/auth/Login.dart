import 'package:car_servicing/constants.dart';
import 'package:car_servicing/presentation/pages/auth/Registation.dart';
import 'package:car_servicing/viewmodels/Auth_viewmodel.dart';
import 'package:car_servicing/presentation/widgets/button_widget.dart';
import 'package:car_servicing/presentation/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String id = 'login_screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final validation = UserAuthenticationViewmodel();

  final _email = TextEditingController();
  final _password = TextEditingController();


  //text trong controller chiếM nhiều dung lg trong bộ nhớ -> loại bỏ
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: SafeArea(
                child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Center(
                    child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: kTextColor),
                )),
                const SizedBox(height: 40),
                CustomTextField(
                  label: "Email",
                  hint: "Enter Your Email",
                  controller: _email,
                  errorText: validation.email.error,
                  onChanged: (value) {
                    validation.validateEmail(value);
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  label: "Password",
                  hint: "Enter Your Password",
                  controller: _password,
                  isPass: true,
                  errorText: validation.password.error,
                  onChanged: (value) {
                    validation.validatePassword(value);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  label: "LOGIN",
                  onPressed: validation.isValidLogin
                      ? () {
                          validation.login(context);
                        }
                      : null,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create new account?',
                      style: TextStyle(fontSize: 16, color: kTextColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Registation.id);
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryContainerColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 56,
                      child: Divider(
                        color: kTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'or login with',
                      style: TextStyle(fontSize: 14, color: kTextColor),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      width: 56,
                      child: Divider(
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSocialBtnRow()
              ],
            )),
          ),
        ),
      ),
      // debugShowCheckedModeBanner: false,
    );
  }
}

Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  return GestureDetector(
    onTap: onTap(),
    child: Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
}

Widget _buildSocialBtnRow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildSocialBtn(
          () {},
          const AssetImage(
            "assets/images/facebook_icon.png",
          ),
        ),
        _buildSocialBtn(
          () {},
          const AssetImage(
            "assets/images/gmail_icon.png",
          ),
        ),
      ],
    ),
  );
}
