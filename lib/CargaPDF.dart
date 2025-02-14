import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'libros_firebase.dart';
import 'dart:convert';

class CargaLibro extends StatefulWidget {
  final String t;
  final String a;
  final String g;
  final String p;
  final String e;

  const CargaLibro({
    super.key,
    required this.t,
    required this.a,
    required this.g,
    required this.p,
    required this.e,
  });

  @override
  State<CargaLibro> createState() => _CargaLibroState();
}

class _CargaLibroState extends State<CargaLibro> {
  File? _imag;
  File? _pdf;
  final imagPic = ImagePicker();
  final pdfPic = FilePicker;
  String nomPDF = 'Selecciona el libro a cargar';
  DatabaseReference db = FirebaseDatabase.instance.ref().child("libro");
  File? imagen;
  String? imagenblob;
  var formKey = new GlobalKey<FormState>();
  String? imgEncoded;
  String? pdfEncoded;

  Future<void> pickPdf() async {
    setState(() {
      _imag = null;
    });

    // Selección del PDF
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Solo permite archivos PDF
    );

    if (result != null && result.files.single.path != null) {
      File pdfFile = File(result.files.single.path!);
      String pdfName = result.files.single.name;

      try {
        // Convertir el PDF a Base64
        pdfEncoded = base64Encode(pdfFile.readAsBytesSync());

        // Abrir PDF y procesar la primera página
        final doc = await PdfDocument.openFile(pdfFile.path);
        final opPag = await doc.getPage(1); // Primera página
        final portImage = await opPag.render(
          width: 1800,
          height: 1200,
        );
        await opPag.close();

        if (portImage?.bytes != null) {
          // Guardar la imagen en un archivo temporal
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/portada.jpg');
          await tempFile.writeAsBytes(portImage!.bytes);

          // Convertir la imagen a Base64
          imgEncoded = base64Encode(tempFile.readAsBytesSync());

          setState(() {
            _pdf = pdfFile;
            nomPDF = pdfName;
            _imag = tempFile; // Actualizar la portada como archivo
          });

          print("PDF en Base64: $pdfEncoded ");
          print("Imagen en Base64: $imgEncoded ");
          print("tamaño del pdf>>>>>>>>>>>>>>>>>${pdfEncoded?.length}");
          print("tamaño del imagen >>>>>>>>>>>>>>>>>${imgEncoded?.length}");
        } else {
          print("Error al generar la portada del PDF.");
        }
      } catch (e) {
        print("Error al procesar el PDF: $e");
      }
    } else {
      print("No se seleccionó ningún archivo PDF.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carga de libro en PDF'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Hero(
                    tag: 'portada_${_imag?.path ?? "default"}',
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _imag != null
                              ? FileImage(_imag!)
                              : const AssetImage('assets/libr.jpg')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: TextEditingController(text: nomPDF),
            decoration: InputDecoration(
              hintText: 'Selecciona el libro',
              floatingLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            readOnly: true,
            onTap: pickPdf,
          ),
          ElevatedButton(
            onPressed: () {
              if (imgEncoded == null) {
                _mensajeError(
                    "Error", "Debes seleccionar un PDF antes de subirlo.");
                return;
              }

              Map<String, String> libro = {
                "titulo": widget.t,
                "autor": widget.a,
                "genero": widget.g,
                "paginas": widget.p,
                "editorial": widget.e,
                "imagen": imgEncoded ?? "",
              };

              db.push().set(libro).whenComplete(() {
                _mensajeConfir(
                  'Archivo subido exitosamente',
                  'Se extrajo correctamente la imagen',
                  context,
                );
              });
            },
            child: const Icon(
              Icons.upload,
              color: Colors.blueAccent,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  void _mensajeError(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.red,
            size: 60,
          ),
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _mensajeConfir(String titulo, String mensaje, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 60),
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LibrosFirebase()),
                ); // Redirigir a la nueva pantalla
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
