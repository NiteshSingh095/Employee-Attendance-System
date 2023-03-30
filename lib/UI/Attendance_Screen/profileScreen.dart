import 'dart:io';

import 'package:attendance_system/modal/user.dart';
import 'package:attendance_system/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  double screenHeight = 0;
  double screenWidth = 0;

  String birth = "Date of Birth";
  File? image;
  final _picker = ImagePicker();

  Color primary = const Color(0xffeef444c);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> uploadProfilePic() async
  {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance
        .ref().child("${Users.employeeId.toLowerCase()}_profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        Users.profilePicLink = value;
      });

      await FirebaseFirestore.instance.collection("Employee").doc(Users.id).update({
        'profilePic': value,
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              // This container will store the picture of employee
              GestureDetector(
                onTap: (){
                  uploadProfilePic();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 45, bottom: 20),
                  alignment: Alignment.center,
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primary
                  ),

                  child: Center(
                    child : Users.profilePicLink == "" ? const Icon(
                        Icons.person,
                      color: Colors.white,
                      size: 80,
                    ) :
                    Image(
                      image: NetworkImage(Users.profilePicLink),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),

              // This contains the text for employee Id
              Align(
                alignment: Alignment.center,
                child: Text(
                    "Employee : " + Users.employeeId,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),

              const SizedBox(height: 15,),

              // This field is used to get the first name of employee
              textField("First Name","First Name", firstNameController),

            //  This field is used to get the last name of employee
              textField("Last Name","Last Name", lastNameController),

              // This container contains the constant Date of Birth text
              const Padding(
                padding: EdgeInsets.only(top: 10.0, left: 14.0, bottom: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Date of Birth", style: const TextStyle(fontWeight: FontWeight.w500),),
                ),
              ),

              // This container contains the date of birth field
              GestureDetector(
                onTap: (){
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      builder: (context, child)
                      {
                        return Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                    primary: primary,
                                    secondary: primary,
                                    onSecondary: Colors.white
                                ),
                                textTheme: const TextTheme(
                                  headline4: TextStyle(fontWeight: FontWeight.bold),
                                  overline: TextStyle(fontWeight: FontWeight.w700),
                                  button: TextStyle(fontWeight: FontWeight.w700),
                                )
                            ),
                            child: child!
                        );
                      }
                  ).then((value)
                  {
                    setState(() {
                      birth = DateFormat("dd-MM-yyyy").format(value!);
                    });
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 13, right: 13),
                  height: kTextTabBarHeight*1.15,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black54)
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child:Text(birth, style: const TextStyle(color: Colors.black54, fontSize: 16),),
                  ),
                ),
              ),

              // This field is used to store address of employee
              textField("Address","Address", addressController),

              // This button is used to save all the information present in above fields
              Users.canEdit ? GestureDetector(
                onTap: () async
                {
                  String firstName = firstNameController.text.toString();
                  String lastName = lastNameController.text.toString();
                  String birth1 = birth.toString();
                  String address = addressController.text.toString();

                  if(Users.canEdit)
                    {
                      if(firstName.isEmpty)
                      {
                        showSnackbar("Enter your first Name");
                      }
                      else if(lastName.isEmpty)
                      {
                        showSnackbar("Enter your last Name");
                      }
                      else if(birth1.isEmpty)
                      {
                        showSnackbar("Select Date of Birth");
                      }
                      else if(address.isEmpty)
                      {
                        showSnackbar("Enter your address");
                      }
                      else
                      {
                        await FirebaseFirestore.instance
                            .collection("Employee")
                            .doc(Users.id)
                            .update({
                          'firstName' : firstName,
                          'lastName' : lastName,
                          'birthDate' : birth,
                          'address' : address,
                          'canEdit' : false
                        }).then((value){
                          Utils().showToast("User Data uploaded successfully");
                        });
                      }
                    }
                  else
                    {
                      showSnackbar("You can\'t edit anymore. Contact support team!");
                    }
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  height: kTextTabBarHeight,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: primary,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black54)
                  ),
                  child: Center(
                    child: Container(
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  : const SizedBox(),
            ],
          ),
        ),
      )
    );
  }

  Widget textField(String title,String hint, TextEditingController controller)
  {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, bottom: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13.0),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                  color: Colors.black54
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black54
                  )
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black54
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  void showSnackbar(String text)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
          content: Text(text,),
      )
    );
  }
}
