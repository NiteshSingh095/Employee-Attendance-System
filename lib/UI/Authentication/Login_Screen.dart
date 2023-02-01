import 'package:attendance_system/UI/Authentication/SignUp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffeef444c);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // This Container contains the colour of top container with icon
            Container(
              height: screenHeight / 2.5,
              width: screenWidth,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(70.0),
                  )),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth / 4,
              ),
            ),

            // This Container will contain the text i.e., Login

            Container(
              margin: EdgeInsets.only(
                  top: screenHeight / 15, bottom: screenWidth / 20),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: screenWidth / 18, fontWeight: FontWeight.w500),
              ),
            ),

            // This Column contains container that have text form field for user id and password

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenHeight / 100, left: screenWidth / 15),
                    child: Text(
                      "Email Id",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 20,
                        right: screenWidth / 20,
                        bottom: screenHeight / 50),
                    width: screenWidth,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2))
                        ]),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (!EmailValidator.validate(value, true)) {
                          return 'Invalid email address';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenHeight / 100, left: screenWidth / 15),
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 20,
                        right: screenWidth / 20,
                        bottom: screenHeight / 50),
                    width: screenWidth,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2))
                        ]),
                    child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (!regex.hasMatch(value)) {
                            return 'Enter valid password';
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 20,
                        right: screenWidth / 20,
                        bottom: screenHeight / 50,
                        top: screenHeight / 50),
                    height: screenHeight / 20,
                    width: screenWidth,
                    child: Center(
                      child:  Text("Login", style: TextStyle(fontSize: screenWidth/25, fontWeight: FontWeight.w500),),
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2))
                        ]),
                  )
                ],
              ),
            ),

            // This Container contains the text button for moving to sign up page

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account."),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signUpScreen()));
                    },
                    child: const Text(
                      'SignUp',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
