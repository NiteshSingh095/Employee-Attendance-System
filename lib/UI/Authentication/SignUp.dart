import 'package:attendance_system/UI/Authentication/Login_Screen.dart';
import 'package:attendance_system/UI/Authentication/signupFace.dart';
import 'package:attendance_system/services/facenet_service.dart';
import 'package:attendance_system/services/ml_kit_service.dart';
import 'package:attendance_system/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signUpScreen extends StatefulWidget {
  final CameraDescription cameraDescription;
  const signUpScreen({Key? key, required this.cameraDescription}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {

  // FaceNetService _faceNetService = FaceNetService.faceNetService;
  // MLKitService _mlKitService = MLKitService();
  // // DataBaseService _dataBaseService = DataBaseService();
  //
  // late CameraDescription cameraDescription = super.cameraDescription1;
  bool loading = false;
  // String githubUrl = "https://github.com/The-Assembly";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _startup();
  }

  late SharedPreferences sharedPreferences2;

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
              child: InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> SignUp(cameraDescription: widget.cameraDescription)));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 4),
                      borderRadius: const BorderRadius.all(Radius.circular(200))),
                ),
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
                      },
                    ),
                  ),

                  // This container is for button to sign up
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });

                        _auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString())
                            .then((value) {
                          createNewUser();
                          setState(() {
                            loading = false;
                          });

                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) => SignUp(
                              cameraDescription: widget.cameraDescription,
                            ),
                          ));

                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().showToast(error.toString());
                        });
                      }
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
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(2, 2))
                            ]),
                      ),
                    ),
                  ),

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

  void createNewUser() async {
    String userId = trimId(emailController.text.toString());

    sharedPreferences2 = await SharedPreferences.getInstance();

    await FirebaseFirestore.instance.collection("Employee").add({
      'id': userId,
      'name': nameController.text.toString(),
      'email': emailController.text.toString(),
    }).then((value){
      sharedPreferences2.setString("UserUniqueId", value.id.toString());
    });

    // Utils().showToast("New User added");
  }

  String trimId(String? email) {
    RegExp regExp = RegExp(r'(.*)@gmail.com');

    RegExpMatch? match = regExp.firstMatch(email!);

    String? data = " ";

    if (match != null) {
      data = match.group(1);
      print('Data extracted: $data');
    } else {
      print('No match found.');
    }

    return data!;
  }

  // void _startup() async{
  //   _setLoading(true);
  //
  //   List<CameraDescription> cameras = await availableCameras();
  //
  //   /// takes the front camera
  //   cameraDescription = cameras.firstWhere(
  //         (CameraDescription camera) =>
  //     camera.lensDirection == CameraLensDirection.front,
  //   );
  //
  //   // start the services
  //   await _faceNetService.loadModel();
  //   //  await _dataBaseService.loadDB();
  //   _mlKitService.initialize();
  //
  //   _setLoading(false);
  // }
  //
  // void _setLoading(bool value) {
  //
  //   setState(() {
  //     loading = value;
  //   });
  // }
}
