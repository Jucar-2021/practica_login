import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> iniciarConGoogle() async {
  GoogleSignInAccount? cuentaGoogle = await googleSignIn.signIn();
  GoogleSignInAuthentication tokenUsuario = await cuentaGoogle!.authentication;
  AuthCredential credencial = GoogleAuthProvider.credential(
      idToken: tokenUsuario.idToken, accessToken: tokenUsuario.accessToken);
  User? usuario =
      (await FirebaseAuth.instance.signInWithCredential(credencial)).user;
  print(
      "<<<<<<<<<<<$usuario , , , , $credencial,,,,,,,,,,,,,,,,,,,,$tokenUsuario");
  return "Hola " + usuario.toString();
}

void salirGoogle() async {
  googleSignIn.signOut();
}
