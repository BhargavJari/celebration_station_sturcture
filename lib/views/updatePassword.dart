import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ourService.dart';

class updatePass extends StatefulWidget {
  const updatePass({Key? key}) : super(key: key);

  @override
  State<updatePass> createState() => _updatePassState();
}

class _updatePassState extends State<updatePass> {
  @override
  bool? check1 = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                Image.asset("img/celebrationstation.png"),
                SizedBox(height: 30),
                RichText(
                  textAlign: TextAlign.center,
                  text:const TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 2.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(100, 0, 0, 0),
                          ),
                        ],
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Update Password Here',style: TextStyle(letterSpacing: 2.0))
                      ]
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Enter Password',
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Confirm Password',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30.0,
                      child: Checkbox(
                        value: check1,
                        onChanged: (bool? value) {
                          setState(() {
                            check1 = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text('I agree'),
                      ),
                    ),
                    Text('Resend OTP'),
                  ],
                ),
                SizedBox(height: 25.0),
                Center(
                  child: SizedBox(
                      height:50, //height of button
                      width:double.infinity, //width of button
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lime[200], //background color of button
                          elevation: 3,
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const OurService()),
                          );
                        },
                        child: Text("Login",
                          style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
