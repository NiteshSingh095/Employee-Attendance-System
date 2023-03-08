import 'package:attendance_system/UI/Authentication/Login_Screen.dart';
import 'package:attendance_system/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  bool loading = false;

  double screenHeight = 0;
  double screenWidth = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This container contains the text "Registration"

            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: screenHeight / 12, bottom: screenHeight / 20),
                child: const Text(
                  "Registration",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            //This container contains the code for icon widget

            Center(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.person_add,
                    color: Colors.black54,
                    size: screenHeight / 6,
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 4),
                    borderRadius: const BorderRadius.all(Radius.circular(200))),
              ),
            ),

            SizedBox(
              height: screenHeight / 18,
            ),

            // This form contains "Name, email id, password and button"

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //This container contains "Name" text
                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenHeight / 100, left: screenWidth / 11),
                    child: const Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),

                  // This container contains the code for name text fields
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 20,
                        right: screenWidth / 20,
                        bottom: screenHeight / 30),
                    width: screenWidth / 1.15,
                    height: screenHeight / 15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Nitesh",
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.all(3.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
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

                  // This container contains "Email id" text

                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenHeight / 100, left: screenWidth / 11),
                    child: const Text(
                      "Email Id",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),

                  // This container contains the code for email text box
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 20,
                        right: screenWidth / 20,
                        bottom: screenHeight / 30),
                    width: screenWidth / 1.15,
                    height: screenHeight / 15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "abc@gmail.com",
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.all(3.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
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

                  // This container contains the code for "Password" text
                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenHeight / 100, left: screenWidth / 15),
                    child: const Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),

                  // This container contains the code for password text field
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 20,
                        right: screenWidth / 20,
                        bottom: screenHeight / 30),
                    width: screenWidth / 1.15,
                    height: screenHeight / 15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: "enter strong password",
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.all(3.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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

                  // This container is for button to sign up
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });

                        _auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });

                          Utils().showToast("Succesfully Registered");

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().showToast(error.toString());
                        });
                      },
                      child: Ink(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: screenWidth / 20,
                              right: screenWidth / 20,
                              bottom: screenHeight / 50,
                              top: screenHeight / 50),
                          width: screenWidth / 1.15,
                          height: screenHeight / 20,
                          child: Center(
                            child: loading == true
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: screenWidth / 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(2, 2))
                              ]),
                        ),
                      )),

                  //This container contains the text button to move on login screen if alreay signup
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account."),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text(
                            'Sign In',
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
