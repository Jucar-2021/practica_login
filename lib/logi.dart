
import 'package:flutter/material.dart';

class Paginalogin extends StatelessWidget {
  const Paginalogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Expanded(child:
        Container(

          child: OutlinedButton(
              onPressed: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logoGo.png",
                    scale: 6,
                  ),
                  Text(
                    "        Ingresa con Google",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              )),
        ),),
      ),
    );
  }
}