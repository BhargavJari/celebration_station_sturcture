import 'dart:ffi';


import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15,top: 20,right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4,color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("img/profileImg.jpg")
                        ),
                      ),
                    ),
                     Positioned(
                      bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap:(){},
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white,
                              ),
                              color: Colors.blue,
                            ),
                            child: Icon(Icons.edit,color: Colors.white ,),
                            ),
                        ),
                        ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              buildTextField("Full Name", "Demon", false),
              buildTextField("Email", "demon@gmail.com", false),
              buildTextField("Password", "********", true),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.black,
                        ),
                      ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: Text("Submit",style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white
                      ),
                      ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lime,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // body: ListView(
      //   physics: BouncingScrollPhysics(),
      //   children: [
      //     ProfilePic(),
      //     SizedBox(height: 35.0),
      //     Text("Shree Ram"),
      //   ],
      // ),
    );
  }
  Widget buildTextField(String labelText,String placeholder,bool isPasswordTextField){
    return Padding(
        padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? _isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField ?
              IconButton(
                  onPressed: (){
                    setState(() {
                      _isObscurePassword = !_isObscurePassword;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye,color: Colors.grey)
              ): null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
        ),
      ),
    );
  }
}
