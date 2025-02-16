import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'logi.dart';
import 'package:lottie/lottie.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AG3 FireBase",
      debugShowCheckedModeBanner: false,
      home: SplashPantalla(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class SplashPantalla extends StatelessWidget {
  const SplashPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    // ajuste del tiempo de pantalla de presentación......
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Paginalogin()),
      );
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Lottie.asset("assets/lib.json"),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  'Iniciando Aplicación',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                centerTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
