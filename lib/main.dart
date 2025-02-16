import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'logi.dart';
import 'package:lottie/lottie.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  efectoInicio();
  runApp(const MyApp());
}
Future<void> efectoInicio() async {
  // ignore: deprecated_member_use
  Soundpool pool = Soundpool(streamType: StreamType.notification);

  int soundId = await rootBundle
      .load("assets/efecto.mp3")
      .then((ByteData soundData) {
    return pool.load(soundData);
  });
  // ignore: unused_local_variable
  int streamId = await pool.play(soundId, repeat: 1);
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
    // ajuste del tiempo de pantalla de presentacion
    Future.delayed(const Duration(milliseconds: 7500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Paginalogin()),
      );
    });

    return Scaffold(
      body: Container(
        color: Colors.black,
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
