import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../widgets/text_input_field.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'tikTok',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 35, color: buttonColor),
          ),
          const Text(
            'Register',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 25,
          ),
          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                backgroundColor: Colors.black,
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () => authController.pickImage(),
                  icon: const Icon(Icons.add_a_photo),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _usernameController,
              labelText: 'Username',
              icon: Icons.person,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextInputField(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.email,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextInputField(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.password,
              isObscure: true,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50.0,
            decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: InkWell(
              onTap: () => authController.registerUser(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  authController.profilePhoto),
              child: const Center(
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already  have account? ',
                style: TextStyle(fontSize: 15),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: buttonColor),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
