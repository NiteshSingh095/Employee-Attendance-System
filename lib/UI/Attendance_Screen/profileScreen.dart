import 'package:attendance_system/modal/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffeef444c);

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(

        child: Column(
          children: [

            // This container will store the picture of employee
            Container(
              margin: const EdgeInsets.only(top: 45, bottom: 20),
              alignment: Alignment.center,
              height: 120,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primary
              ),

              child: const Center(
                child : Icon(
                    Icons.person,
                  color: Colors.white,
                  size: 80,
                )
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
            textField("First Name","First Name"),

          //  This field is used to get the last name of employee
            textField("Last Name","Last Name"),

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
                    Users.birthDate = DateFormat("dd-MM-yyyy").format(value!);
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
                  child:Text(Users.birthDate, style: const TextStyle(color: Colors.black54, fontSize: 16),),
                ),
              ),
            ),

            // This field is used to store address of employee
            textField("Address","Address"),

            GestureDetector(
              onTap: (){

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
                    child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget textField(String title,String hint)
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
}
