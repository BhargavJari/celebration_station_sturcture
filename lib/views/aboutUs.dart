
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title:  Image.asset(
          "img/celebrationstation.png",
          height: 60,
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: ()
            {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const Terms()));
            },
            icon: Icon(
              CupertinoIcons.bell,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),
            Text(
              "About Us",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                decoration: TextDecoration.underline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset("img/party.jpg"),
                  SizedBox(height: 30.0),
                  Text(
                      "Celebration station is America's location for family, food, and fun! Celebration Station has the most ways to play including go karts, bumper boats, laser tag arena, restaurant, party rooms, multicourse miniature golf, playland rides, batting cages and much much more!",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
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
