// import 'package:flutter/material.dart';
//
//
// import '../OtpScreen.dart';
//
// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Auth'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(children: [
//             Container(
//               margin: EdgeInsets.only(top: 60),
//               child: Center(
//                 child: Text(
//                   'Phone Authentication',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 40, right: 10, left: 10),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Phone Number',
//                   prefix: Padding(
//                     padding: EdgeInsets.all(4),
//                     child: Text('+91'),
//                   ),
//                 ),
//                 maxLength: 10,
//                 keyboardType: TextInputType.number,
//                 controller: _controller,
//               ),
//             )
//           ]),
//           Container(
//             margin: EdgeInsets.all(10),
//             width: double.infinity,
//             child: TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => OTPScreen(_controller.text)));
//               },
//               child: Text(
//                 'Next',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController countryCode = TextEditingController();
  var phone="";

  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'img/celebrationstation.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          onChanged: (value){
                            phone=value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lime,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      // await FirebaseAuth.instance.verifyPhoneNumber(
                      //   phoneNumber: '${countryCode.text+phone}',
                      //   verificationCompleted: (PhoneAuthCredential credential) {},
                      //   verificationFailed: (FirebaseAuthException e) {},
                      //   codeSent: (String verificationId, int? resendToken) {},
                      //   codeAutoRetrievalTimeout: (String verificationId) {},
                      // );
                      //Navigator.pushNamed(context, 'verify');
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPscreen(number: phone),));
                    },
                    child: Text("Send the code")),
              )
            ],
          ),
        ),
      ),
    );
  }
  // TextEditingController _controller = TextEditingController();
  // @override
  // bool? check1 = false;
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(30.0),
  //         child: Form(
  //           child: Column(
  //             // crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               SizedBox(height: 50),
  //               Image.asset("img/celebrationstation.png"),
  //               SizedBox(height: 30),
  //               RichText(
  //                 textAlign: TextAlign.center,
  //                 text:TextSpan(
  //                     style: TextStyle(
  //                       fontSize: 30,
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                       shadows: <Shadow>[
  //                         Shadow(
  //                           offset: Offset(1.0, 2.5),
  //                           blurRadius: 3.0,
  //                           color: Color.fromARGB(100, 0, 0, 0),
  //                         ),
  //                       ],
  //                     ),
  //                     children: const <TextSpan>[
  //                       TextSpan(text: 'Signup for Free',style: TextStyle(letterSpacing: 2.0))
  //                     ]
  //                 ),
  //               ),
  //               SizedBox(height: 25.0),
  //               TextFormField(
  //                 textInputAction: TextInputAction.next,
  //                 decoration: InputDecoration(
  //                   enabledBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(20),
  //                     borderSide: BorderSide(
  //                       color: Colors.grey,
  //                       width: 2.0,
  //                     ),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(20),
  //                     borderSide: BorderSide(
  //                       color: Colors.black,
  //                       width: 2.0,
  //                     ),
  //                   ),
  //                   hintText: 'Enter Mobile No',
  //                 ),maxLength: 10,keyboardType: TextInputType.number, controller: _controller,
  //               ),
  //               SizedBox(height: 15.0),
  //               TextFormField(
  //                 textInputAction: TextInputAction.next,
  //                 obscureText: true,
  //                 enableSuggestions: false,
  //                 autocorrect: false,
  //                 decoration: InputDecoration(
  //                   enabledBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(20),
  //                     borderSide: BorderSide(
  //                       color: Colors.grey,
  //                       width: 2.0,
  //                     ),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(20),
  //                     borderSide: BorderSide(
  //                       color: Colors.black,
  //                       width: 2.0,
  //                     ),
  //                   ),
  //                   hintText: 'Enter OTP',
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: 30.0,
  //                     child: Checkbox(
  //                       value: check1,
  //                       onChanged: (bool? value) {
  //                         setState(() {
  //                           check1 = value;
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Container(
  //                       child: Text('I agree'),
  //                     ),
  //                   ),
  //                   Text('Resend OTP'),
  //                 ],
  //               ),
  //               SizedBox(height: 25.0),
  //               Center(
  //                 child: SizedBox(
  //                     height:50, //height of button
  //                     width:double.infinity, //width of button
  //                     child:ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         primary: Colors.lime[200], //background color of button
  //                         elevation: 3,
  //                         shape: RoundedRectangleBorder( //to set border radius to button
  //                             borderRadius: BorderRadius.circular(20)
  //                         ),
  //                       ),
  //                       onPressed: () async{
  //                         await FirebaseAuth.instance.verifyPhoneNumber(
  //                           phoneNumber: '+44 7123 123 456',
  //                           verificationCompleted: (PhoneAuthCredential credential) {},
  //                           verificationFailed: (FirebaseAuthException e) {},
  //                           codeSent: (String verificationId, int? resendToken) {},
  //                           codeAutoRetrievalTimeout: (String verificationId) {},
  //                         );
  //                         //Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPscreen(number: _controller.text),));
  //                       },
  //                       child: Text("Signup",
  //                         style:TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Colors.black
  //                         ),
  //                       ),
  //                     )
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
