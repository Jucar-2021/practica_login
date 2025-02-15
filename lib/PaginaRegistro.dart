import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica_login/CargaPDF.dart';

class Paginaregistro extends StatefulWidget {
  const Paginaregistro({super.key});

  @override
  State<Paginaregistro> createState() => _PaginaregistroState();
}

class _PaginaregistroState extends State<Paginaregistro> {
  DatabaseReference db = FirebaseDatabase.instance.ref().child("libro");
  File? imagen;
  String? imagenblob;
  var formKey = new GlobalKey<FormState>();
  TextEditingController ctrlTitulo = new TextEditingController();
  TextEditingController ctrlAutor = new TextEditingController();
  TextEditingController ctrlGenero = new TextEditingController();
  TextEditingController ctrlPaginas = new TextEditingController();
  TextEditingController ctrlEditorial = new TextEditingController();
  late String t;
  late String a;
  late String g;
  late String p;
  late String e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Libro"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.vertical,
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo Vacío" : null;
                  },
                  controller: ctrlTitulo,
                  decoration: InputDecoration(
                    labelText: "Título",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo Vacío" : null;
                  },
                  controller: ctrlAutor,
                  decoration: InputDecoration(
                    labelText: "Autor",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo Vacío" : null;
                  },
                  controller: ctrlGenero,
                  decoration: InputDecoration(
                    labelText: "Género",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  validator: (value) {
                    int? number = int.tryParse(value!);
                    if (number == null || number <= 0) {
                      return 'El valor debe ser mayor a 0.';
                    }
                    return null;
                  },
                  controller: ctrlPaginas,
                  decoration: InputDecoration(
                      labelText: "Páginas",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      )),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo Vacío" : null;
                  },
                  controller: ctrlEditorial,
                  decoration: InputDecoration(
                    labelText: "Editorial",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                imagen != null ? Image.file(imagen!) : Container(),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                ElevatedButton(
                    onPressed: () async {
                      ImagePicker picker = new ImagePicker();
                      var imagenSeleccionada =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (imagenSeleccionada != null) {
                        imagen = File(imagenSeleccionada.path);
                        imagenblob = base64Encode(imagen!.readAsBytesSync());
                        setState(() {});
                      }
                    },
                    child: Text("Buscar imagen")),
                Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        //Si hay un campo vacío, muestra un mensaje de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Completa todos los campos antes de continuar"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else  {
                        setState(
                          () {
                            t = ctrlTitulo.text;
                            a = ctrlAutor.text;
                            g = ctrlGenero.text;
                            p = ctrlPaginas.text;
                            e = ctrlEditorial.text;
                          },
                        );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CargaLibro(t: t, a: a, g: g, p: p, e: e)));
                        ctrlTitulo.clear();
                        ctrlEditorial.clear();
                        ctrlPaginas.clear();
                        ctrlGenero.clear();
                        ctrlAutor.clear();
                      }


                    },
                    child: Text("Extraer Imagen de Libro")),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          //Si hay un campo vacío, muestra un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Completa todos los campos antes de continuar"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        Map<String, String> libro = {
                          "titulo": ctrlTitulo.text,
                          "autor": ctrlAutor.text,
                          "genero": ctrlGenero.text,
                          "paginas": ctrlPaginas.text,
                          "editorial": ctrlEditorial.text,
                          "imagen": imagenblob.toString()
                        };
                        db.push().set(libro).whenComplete(() {
                          Navigator.pop(context);
                          setState(() {});
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Guardar"), Icon(Icons.save)],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                    ElevatedButton(
                        onPressed: () {
                          ctrlAutor.clear();
                          ctrlEditorial.clear();
                          ctrlGenero.clear();
                          ctrlPaginas.clear();
                          ctrlTitulo.clear();
                          imagen = null;
                          imagenblob = null;
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Limpiar"), Icon(Icons.clear)],
                        ))
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
              ],
            )),
      ),
    );
  }
}
